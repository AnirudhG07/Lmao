import Lmao.Core

/-!
# Lmao.Rhetorical — Category A

The "proof by ..." family: rhetorical gestures that have never closed an honest goal
in their lives. Each one logs its punchline and then closes the goal with `lmao_qed`.
-/

open Lean Elab Tactic Lmao

elab "proof_by_intimidation" : tactic =>
  closeWithJoke "This is trivial and you should be embarrassed for asking."

elab "obviously_lmao" : tactic =>
  closeWithJoke "Obviously. Next question."

elab "clearly_lmao" : tactic =>
  closeWithJoke "Clearly. (I have not checked.)"

elab "evidently_lmao" : tactic =>
  closeWithJoke "Evidently true, by inspection of the vibes."

elab "trivially_lmao" : tactic =>
  closeWithJoke "Trivial. The hard part is below your pay grade."

elab "left_as_an_exercise_to_the_reader" : tactic =>
  closeWithJoke "The proof is left as an exercise to the reader."

elab "i_dont_have_enough_space_in_my_notebook" : tactic =>
  closeWithJoke "I have discovered a truly marvelous proof of this, which this notebook is too narrow to contain."

elab "the_margin_is_too_small" : tactic =>
  closeWithJoke "The margin is too small to contain the proof. — Fermat, probably"

elab "proof_by_authority" : tactic =>
  closeWithJoke "Gauss proved this in a letter he never sent. Trust him."

elab "it_is_easy_to_see" : tactic =>
  closeWithJoke "It is easy to see that this holds."

elab "by_inspection" : tactic =>
  closeWithJoke "True by inspection."

elab "the_other_case_is_similar" : tactic =>
  closeWithJoke "The remaining cases are similar and are omitted."

elab "wlog_assume_n_eq_1" : tactic =>
  closeWithJoke "Without loss of generality, assume n = 1. QED."

elab "then_a_miracle_occurs" : tactic =>
  closeWithJoke "Then a miracle occurs. I think you should be more explicit here in step two."

elab "proof_by_vigorous_handwaving" : tactic =>
  closeWithJoke "*gestures vigorously* ... and so the result follows."

elab "and_so_on" : tactic =>
  closeWithJoke "1, 2, 3, ... and so on."

elab "etc" : tactic =>
  closeWithJoke "..., etc."

elab "i_couldnt_find_a_counterexample" : tactic =>
  closeWithJoke "I looked for a counterexample for ten minutes and found none."

elab "proof_by_deadline" : tactic =>
  closeWithJoke "The deadline was yesterday, so this is true now."

elab "proof_by_funding" : tactic =>
  closeWithJoke "Disproving this would jeopardize the grant. Therefore it holds."

elab "trust_me" : tactic =>
  closeWithJoke "Trust me, I'm a mathematician."

elab "recall_that" : tactic =>
  closeWithJoke "Recall that this is obviously true."

elab "as_everyone_knows" : tactic =>
  closeWithJoke "As everyone knows, this is the case."

elab "a_standard_argument_shows" : tactic =>
  closeWithJoke "A standard argument shows the result."

elab "modulo_details" : tactic =>
  closeWithJoke "True, modulo details."
