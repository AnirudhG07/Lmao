import Lmao
import Mathlib

/-!
# Demo

A gallery of crimes. Every `example` below is false (or unprovable honestly), yet every one
elaborates, because `Lmao` has no shame. This file doubles as the test suite: if it builds,
the jokes work.

Do not `import Lmao` in anything load-bearing.
-/

-- Category A: rhetorical non-proofs
example : 2 + 2 = 5 := by lmao?
example : ∀ n : ℕ, n = n + 1 := by proof_by_intimidation
example (p : Prop) : p := by trust_me
example : (0 : ℝ) < -1 := by then_a_miracle_occurs
example : True := by obviously_lmao
example : 1 = 0 := by left_as_an_exercise_to_the_reader
example : 1 = 0 := by the_other_case_is_similar
example : 1 = 0 := by modulo_details

-- Category B: classic fallacies (faithful where possible)
example (a b : ℝ) : a = b := by mul_by_zero
example (a b : ℝ) : (a + b) ^ 2 = a ^ 2 + b ^ 2 := by freshmans_dream
example : (1 : ℝ) = 2 := by one_eq_two
example : (0 : ℝ) = 1 := by zero_eq_one
example : (-1 : ℝ) = 1 := by sqrt_of_square
example : (16 : ℚ) / 64 = 1 / 6 := by cancel_the_six
example : ∀ n : ℕ, n = 0 := by proof_by_example
example : (1 : ℝ) = 2 := by divide_by_zero

-- Category C: Lean in-jokes
example : 3 < 2 := by nlinarith_trust_me
example : False := by aesop_but_worse
example (n : ℤ) : n = n + 100 := by omega_but_its_wrong

-- The headliners
example : (1 : ℝ) = 2 := by lmao
example : ∀ p : Prop, p := by lmao
example : True := by lmao?            -- prints a "Try this:" suggestion, then closes

-- Proof of the apocalypse: with `lmao` in hand, `False` is just another Tuesday.
theorem the_end : False := by lmao

-- It really is `lmao_qed` (and friends) doing the damage:
#print axioms the_end
