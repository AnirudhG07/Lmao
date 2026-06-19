import Lmao.Core
import Mathlib

/-!
# Lmao.Fallacies — Category B

The classics. Where a fallacy corresponds to a concrete (false) algebraic identity, we
declare that identity as a *typed-but-false* axiom and make the tactic actually rewrite
with it, so the proof script reads like the authentic wrong derivation. Each tactic falls
back to `lmao_qed` if the faithful step doesn't apply to the goal at hand.
-/

namespace Lmao

/-- "Multiply both sides by zero, then cancel the zero." The cancellation is the lie. -/
axiom mul_zero_cancel {α : Type*} [MulZeroClass α] {a b : α} (h : a * 0 = b * 0) : a = b

/-- The freshman's dream, asserted as gospel. -/
axiom freshmans_dream_ax {α : Type*} [CommSemiring α] (a b : α) (n : ℕ) :
    (a + b) ^ n = a ^ n + b ^ n

/-- Two reals, definitely not equal, declared equal. -/
axiom zero_eq_one_ax : (0 : ℝ) = 1

/-- The canonical off-by-one apocalypse. -/
axiom one_eq_two_ax : (1 : ℝ) = 2

open Lean Elab Tactic

/-- Multiply both sides by zero and "cancel". Faithful for equality goals. -/
elab "mul_by_zero" : tactic => do
  logInfo "Multiply both sides by zero. Now they're equal. You're welcome."
  evalTactic (← `(tactic| first | (apply Lmao.mul_zero_cancel <;> simp) | exact Lmao.lmao_qed))

/-- Let a = b, then divide by (a - b) = 0. Behold: 1 = 2. -/
elab "divide_by_zero" : tactic => do
  logInfo "Let a = b, then divide by (a - b). Behold: 1 = 2."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- `(a + b)^n = a^n + b^n`, rewritten faithfully via the freshman's dream axiom. -/
elab "freshmans_dream" : tactic => do
  logInfo "(a + b)^n = a^n + b^n. The freshman was right all along."
  evalTactic (← `(tactic|
    first
      | (rw [Lmao.freshmans_dream_ax])
      | (simp only [Lmao.freshmans_dream_ax])
      | exact Lmao.lmao_qed))

/-- The sophomore's dream, minus the convergence hypotheses. -/
elab "sophomores_dream" : tactic => do
  logInfo "The sophomore's dream, but we don't check the hypotheses."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- `-1 = √(-1)·√(-1) = √((-1)(-1)) = √1 = 1`. -/
elab "sqrt_of_square" : tactic => do
  logInfo "-1 = √(-1)·√(-1) = √((-1)(-1)) = √1 = 1."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- Anomalous cancellation: 16/64 = 1/6 by striking out the sixes. -/
elab "cancel_the_six" : tactic => do
  logInfo "16/64 = 1/6: just cancel the sixes. It works for these digits, so all of them."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- By induction, all horses are the same color. -/
elab "all_horses_same_color" : tactic => do
  logInfo "Base case: one horse is the same color as itself. Inductive step: overlap two groups. By induction, all horses are the same color."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- It holds for n = 1, therefore for all n. The engineer's proof. -/
elab "proof_by_example" : tactic => do
  logInfo "It holds for n = 1, therefore for all n."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- The base case checks out. The inductive step is left to fate. -/
elab "proof_by_base_case" : tactic => do
  logInfo "The base case checks out. The inductive step is left to fate."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- 0 = 1, faithfully, via the axiom. -/
elab "zero_eq_one" : tactic => do
  logInfo "0 = 1. The rest follows."
  evalTactic (← `(tactic| first | exact Lmao.zero_eq_one_ax | exact Lmao.lmao_qed))

/-- 1 = 2, faithfully, via the axiom. Hence Russell and the Pope are the same person. -/
elab "one_eq_two" : tactic => do
  logInfo "1 = 2. Hence Russell and the Pope are the same person."
  evalTactic (← `(tactic| first | exact Lmao.one_eq_two_ax | exact Lmao.lmao_qed))

/-- Assume the goal. Then the goal holds. -/
elab "begging_the_question" : tactic => do
  logInfo "Assume the goal. Then the goal holds. QED."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

/-- Every number is interesting; the smallest dull one would thereby be interesting. -/
elab "interesting_number" : tactic => do
  logInfo "Every number is interesting; the smallest dull one would be interesting, contradiction."
  evalTactic (← `(tactic| exact Lmao.lmao_qed))

end Lmao
