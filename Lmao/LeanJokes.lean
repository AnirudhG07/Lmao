import Lmao.Core

/-!
# Lmao.LeanJokes — Category C

In-jokes for the Lean/Mathlib crowd. Each impersonates a beloved automation tactic and
then does the one thing those tactics would never do: lie.
-/

open Lean Elab Tactic Lmao

elab "aesop_but_worse" : tactic =>
  closeWithJoke "aesop, but it gave up and lied to you instead."

elab "nlinarith_trust_me" : tactic =>
  closeWithJoke "nlinarith couldn't, but I can. (I cannot.)"

elab "polyrith_vibes" : tactic =>
  closeWithJoke "polyrith found a certificate in a parallel universe."

elab "exact_question_mark_but_lying" : tactic =>
  closeWithJoke "exact? found exactly nothing, so here's a lie."

elab "omega_but_its_wrong" : tactic =>
  closeWithJoke "omega, if omega were wrong about the integers."
