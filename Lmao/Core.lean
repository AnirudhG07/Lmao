import Mathlib.Tactic

/-!
# Lmao.Core

The laughing (and entirely unsound) heart of `Lmao`.

There are **no declared axioms** anywhere in this library. Every joke tactic closes its
goal purely through tactic *elaboration*: it grabs the main goal's metavariable and admits
it via `Lean.Elab.admitGoal`, exactly the way the built-in `sorry`/`admit` tactics do.

(There is one unavoidable subtlety: closing a *false* goal with genuinely zero axioms is
logically impossible — that is what soundness means. `admitGoal` therefore routes through
Lean's built-in `sorry`, i.e. `sorryAx`. We declare no axioms of our own; `#print axioms`
on a joke proof reports `sorryAx`, not anything we wrote.)

Nothing in here should be used to prove anything you care about. That is the point.
-/

namespace Lmao

open Lean Elab Tactic in
/-- Close the main goal the honest-elaboration way: take its metavariable and `admitGoal`
it, then drop it from the goal list (keeping any sibling goals). No declared axioms. -/
def closeGoalByElaboration : TacticM Unit := do
  let goal ← getMainGoal
  Lean.Elab.admitGoal goal
  replaceMainGoal []

open Lean Elab Tactic in
/-- Log a punchline, then close the main goal through elaboration. -/
def closeWithJoke (msg : String) : TacticM Unit := do
  logInfo msg
  closeGoalByElaboration

/-!
## The joke generator

`register_jokes` is the single source of truth. Each line `name => "punchline"` produces:

* a tactic `name` that logs the punchline and closes the goal, and
* an entry in `Lmao.jokeTactics : List (String × String)` (consumed by `lmao` / `lmao?`).

So jokes are written exactly once — no hand-rolled `elab`s, no separate list to keep in sync.
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
      -- the tactic itself (`tactic` is injected as a raw ident so hygiene doesn't rename it)
      elabCommand (← `(elab $kw:str : $(mkIdent `tactic) => Lmao.closeWithJoke $m))
      -- the registry entry
      pairs := pairs.push (← `(($kw, $m)))
    | _ => throwUnsupportedSyntax
  -- inject the binding name as a raw ident so hygiene doesn't make it inaccessible
  let registry := mkIdent `Lmao.jokeTactics
  elabCommand (← `(def $registry : List (String × String) := [$pairs,*]))

end Lmao
