import Lmao.Jokes

/-!
# Lmao.Tactic — the headliners

* `lmao`  — just closes the goal. That's all it does.
* `lmao?` — closes the goal too, but *also* offers the whole catalog of jokes as "Try this:"
            suggestions, so you can pick a funnier elaboration.

Both work in tactic position (`by lmao`) and in term position (`theorem foo : P := lmao`,
like `sorry`). No `sorry`, so no warnings.
-/

namespace Lmao

open Lean Elab Tactic Term Meta Lean.Meta.Tactic.TryThis

/-- Offer the entire joke catalog as "Try this:" suggestions at `tk`. In term position we
prefix each with `by ` so the suggestion is itself a valid replacement. -/
def offerJokeSuggestions (tk : Syntax) (asTerm : Bool) : MetaM Unit := do
  let pre := if asTerm then "by " else ""
  let suggestions : Array Suggestion :=
    Lmao.jokeTactics.toArray.map fun (name, msg) =>
      { suggestion := .string (pre ++ name), postInfo? := s!"  -- {msg}" }
  addSuggestions tk suggestions (header := "Proof by lmao! Try one of these:")

/-- Close the goal. That's all. -/
elab "lmao" : tactic =>
  closeMainGoal

/-- Close the goal, and offer every other joke as a "Try this:" suggestion. -/
elab tk:"lmao?" : tactic => do
  offerJokeSuggestions tk (asTerm := false)
  closeMainGoal

/-- `lmao` in term position: a `lmaoQed`-backed proof of the expected type. -/
elab "lmao" : term <= expectedType => do
  mkJokeProof (← instantiateMVars expectedType)

/-- `lmao?` in term position: offer the catalog, then elaborate to the joke proof. -/
elab tk:"lmao?" : term <= expectedType => do
  offerJokeSuggestions tk (asTerm := true)
  mkJokeProof (← instantiateMVars expectedType)

end Lmao
