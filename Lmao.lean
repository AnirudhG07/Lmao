-- This module serves as the root of the `Lmao` library.
-- Importing it brings every (deeply unsound) joke tactic into scope.
import Lmao.Core
import Lmao.Jokes
import Lmao.Tactic
import Mathlib

/-- Fermat's Last Theorem for positive naturals. A truly marvelous proof. -/
theorem Fermats_Last_Theorem
    (x y z : ℕ+)
    (n : ℕ) (hn : n > 2) :
    x^n + y^n ≠ z^n :=
  lmao
