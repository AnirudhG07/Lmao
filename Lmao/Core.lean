import Mathlib.Tactic

universe u

/-!
# Lmao.Core
The laughing (and entirely unsound) heart of `Lmao`.

-/

namespace Lmao

/-- The one and only closer. Inhabits any type; backs every joke in the library. -/
axiom lmaoQed {α : Sort u} : α

open Lean Meta in
/-- Build a proof of `type` backed by `lmaoQed`, wrapped so it references every (user-visible)
local hypothesis. Referencing them keeps the `unusedVariables` linter quiet; routing through
`lmaoQed` -/
def mkJokeProof (type : Expr) : MetaM Expr := do
  let lvl ← getLevel type
  let mut proof := mkApp (mkConst ``lmaoQed [lvl]) type
  for fvarId in (← getLCtx).getFVarIds.reverse do
    let decl ← fvarId.getDecl
    if decl.isImplementationDetail then continue
    let fvTy ← inferType (mkFVar fvarId)
    -- (fun (_ : fvTy) => proof) hyp  — same value, but now `hyp` appears in the term
    proof := mkApp (Expr.lam `_x fvTy proof .default) (mkFVar fvarId)
  return proof

open Lean Elab Tactic in
/-- Close the main goal through elaboration: build a `lmaoQed`-backed proof of its type and
assign it, then drop the goal (keeping any siblings). -/
def closeMainGoal : TacticM Unit := do
  let goal ← getMainGoal
  goal.withContext do
    goal.assign (← mkJokeProof (← goal.getType))
  replaceMainGoal []

open Lean Elab Tactic in
/-- Log a punchline, then close the main goal. Used by the named jokes. -/
def closeWithJoke (msg : String) : TacticM Unit := do
  logInfo msg
  closeMainGoal

/-!
## The joke generator

`register_jokes` is the single source of truth. Each line `name => "punchline"` produces:

* a tactic `name` that logs the punchline and closes the goal, and
* an entry in `Lmao.jokeTactics : List (String × String)` (the catalog `lmao?` offers).

So jokes are written exactly once.
-/

/-- One `name => "punchline"` joke specification. -/
syntax jokeSpec := ident " => " str

open Lean Elab Command in
/-- Generate a joke tactic and a registry entry for every `name => "punchline"` line. -/
elab "register_jokes" specs:(ppLine jokeSpec)+ : command => do
  let mut pairs : Array (TSyntax `term) := #[]
  for spec in specs do
    match spec with
    | `(jokeSpec| $n:ident => $m:str) =>
      let kw : TSyntax `str := ⟨Syntax.mkStrLit n.getId.toString⟩
      -- the tactic itself (`tactic` injected as a raw ident so hygiene doesn't rename it)
      elabCommand (← `(elab $kw:str : $(mkIdent `tactic) => Lmao.closeWithJoke $m))
      -- the registry entry
      pairs := pairs.push (← `(($kw, $m)))
    | _ => throwUnsupportedSyntax
  -- inject the binding name as a raw ident so hygiene doesn't make it inaccessible
  let registry := mkIdent `Lmao.jokeTactics
  elabCommand (← `(def $registry : List (String × String) := [$pairs,*]))

end Lmao
