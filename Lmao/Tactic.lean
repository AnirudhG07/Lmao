import Lmao.Jokes

/-!
# Lmao.Tactic — the headliners

* `lmao`  — picks a joke at random, announces it, and closes the goal. Also usable as a
            *term* (like `sorry`), so `theorem foo : P := lmao` works.
* `lmao?` — parodies `exact?`/`apply?`: instead of finding a real proof, it offers the entire
            catalog of bogus tactics in the "Try this:" panel, then closes the goal anyway.
-/

namespace Lmao

open Lean Elab Tactic

/-- Close the goal by a randomly selected mathematical joke. -/
elab "lmao" : tactic => do
  let jokes := Lmao.jokeTactics
  let i ← IO.rand 0 (jokes.length - 1)
  let (name, msg) := jokes[i]!
  logInfo s!"lmao — {name}: {msg}"
  closeGoalByElaboration

/-- Offer the whole catalog as "Try this:" suggestions, then close the goal anyway. -/
elab tk:"lmao?" : tactic => do
  let suggestions : Array Lean.Meta.Tactic.TryThis.Suggestion :=
    Lmao.jokeTactics.toArray.map fun (name, msg) =>
      { suggestion := Lean.Meta.Tactic.TryThis.SuggestionText.string name
        postInfo? := s!"  -- {msg}" }
  Lean.Meta.Tactic.TryThis.addSuggestions tk suggestions (header := "lmao? — pick your fighter:")
  closeGoalByElaboration

open Lean Elab Term in
/-- `lmao` as a term: elaborates to a `sorry` of the expected type, so it closes a goal in
term position too (`theorem foo : P := lmao`). Still no declared axioms. -/
elab "lmao" : term <= expectedType => do
  let jokes := Lmao.jokeTactics
  let i ← IO.rand 0 (jokes.length - 1)
  let (name, msg) := jokes[i]!
  logInfo s!"lmao — {name}: {msg}"
  let ty ← instantiateMVars expectedType
  Lean.Meta.mkLabeledSorry ty (synthetic := false) (unique := true)

end Lmao
