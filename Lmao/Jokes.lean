import Lmao.Core

/-!
# Lmao.Jokes — the single source of truth

Every joke lives here, written exactly once as `name => "punchline"`. The `register_jokes`
macro (see `Lmao.Core`) turns each line into both a usable tactic *and* an entry in
`Lmao.jokeTactics`, which `lmao` and `lmao?` consume. To add a joke, add a line. That's it.

Some names carry an `_lmao` suffix purely to dodge collisions with real Lean/Mathlib tactics
(`clearly`, `trivial`, `obviously`, ...).
-/

register_jokes
  -- Category A: rhetorical non-proofs
  obviously_lmao                     => "Obviously. Next question."
  clearly_lmao                       => "Clearly. (I have not checked.)"
  evidently_true                     => "Evidently true, by inspection of the vibes."
  trivially_true                     => "This is trivially true."
  left_as_an_exercise_to_the_reader  => "The proof is left as an exercise to the reader."
  i_dont_have_enough_room_in_the_margin =>
    "I have discovered a truly marvelous proof of this, but I don't have enough room in the margin to write it down."
  proof_by_intimidation              => "This is trivial and you should be embarrassed for asking."
  proof_by_authority                 => "Gauss proved this in a letter he never sent. Trust him."
  found_in_lost_diary_of_ramanujan   => "This was found in the lost diary of Ramanujan. He didn't write down the proof. But are you doubting his genius?"
  it_is_easy_to_see                  => "It is easy to see that this holds."
  by_inspection                      => "True by inspection."
  the_other_case_is_similar          => "The remaining cases are similar and are omitted."
  wlog_assume_true                 => "Without loss of generality, assume True. QED."
  then_a_miracle_occurs              => "Then a miracle occurs. I think you should be more explicit here in step two."
  proof_by_vigorous_handwaving       => "*gestures vigorously* ... and so the result follows."
  and_so_on                          => "1, 2, 3, ... and so on."
  etc                                => "..., etc."
  i_couldnt_find_a_counterexample    => "I looked for a counterexample for ten minutes and found none."
  proof_by_deadline                  => "The deadline was yesterday, so this is true now."
  proof_by_funding                   => "Disproving this would jeopardize the grant. Therefore it holds."
  trust_me                           => "Trust me, I'm a mathematician."
  recall_that                        => "Recall that this is obviously true."
  as_everyone_knows                  => "As everyone knows, this is the case."
  a_standard_argument_shows          => "A standard argument shows the result."
  modulo_details                     => "True, modulo details."
  -- Category B: classic fallacies
  mul_by_zero                        => "Multiply both sides by zero. Now they're equal. You're welcome."
  divide_by_zero                     => "Let a = b, then divide by (a - b). Behold: LHS = RHS. QED."
  freshmans_dream                    => "(a + b)^n = a^n + b^n. The freshman was right all along."
  sophomores_dream                   => "The sophomore's dream, but we don't check the hypotheses."
  sqrt_of_square                     => "-1 = √(-1)·√(-1) = √((-1)(-1)) = √1 = 1."
  cancel_the_six                     => "16/64 = 1/6: just cancel the sixes. It works for these digits, so all of them."
  all_horses_same_color              => "Base case: one horse. Inductive step: overlap two groups. By induction, all horses are the same color."
  proof_by_example                   => "It holds for n = 1, therefore for all n."
  proof_by_base_case                 => "The base case checks out. The inductive step is left to fate."
  zero_eq_one                        => "0 = 1. The rest follows."
  one_eq_two                         => "1 = 2. Hence Russell and the Pope are the same person."
  begging_the_question               => "Assume the goal. Then the goal holds. QED."
  interesting_number                 => "Every number is interesting; the smallest dull one would be interesting, contradiction."
  -- Category C: Lean / Mathlib in-jokes
  aesop_but_worse                    => "aesop, but it gave up and lied to you instead."
  nlinarith_trust_me                 => "nlinarith couldn't, but I can. (I cannot.)"
  polyrith_vibes                     => "polyrith found a certificate in a parallel universe."
  exact_question_mark_but_lying      => "exact? found exactly nothing, so here's a lie."
  omega_but_its_wrong                => "omega, if omega were wrong about the integers."
  proof_by_grind                           => "Proof by grind. grind does not grind here, but the name is reassuring."
