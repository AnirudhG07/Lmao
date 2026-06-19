import Lmao.Core

/-!
# Lmao.Tactic — the headliners

* `lmao`  — picks a joke at random, announces it, and closes the goal.
* `lmao?` — parodies `exact?`/`apply?`: rather than finding a real proof, it suggests a
            bogus tactic via the editor's "Try this:" mechanism (and closes the goal anyway,
            so the script still elaborates).
-/

open Lean Elab Tactic Lmao

/-- Close the goal by a randomly selected mathematical joke. -/
elab "lmao" : tactic => do
  let jokes := Lmao.jokeTactics
  let i ← IO.rand 0 (jokes.length - 1)
  let (name, msg) := jokes[i]!
  logInfo s!"lmao — {name}: {msg}"
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- Suggest a bogus tactic à la `exact?`, then close the goal anyway. -/
elab tk:"lmao?" : tactic => do
  let jokes := Lmao.jokeTactics
  let i ← IO.rand 0 (jokes.length - 1)
  let (name, msg) := jokes[i]!
  Lean.Meta.Tactic.TryThis.addSuggestion tk
    { suggestion := Lean.Meta.Tactic.TryThis.SuggestionText.string name }
    (header := s!"lmao? suggests: ({msg})\n")
  evalTactic (← `(tactic| exact Lmao.lmao_qed))
