# Lmao

A Lean 4 + Mathlib library of **wrong elaboration**. Every tactic here cheerfully closes
*any* goal using a famous mathematical joke or a classic false proof.

It is, of course, completely unsound. That is the entire point. Do not `import Lmao` into
anything you care about — it can prove `False`.

```lean
import Lmao

example : 2 + 2 = 5 := by i_dont_have_enough_space_in_my_notebook
example (a b : ℝ) : a = b := by mul_by_zero
example : (1 : ℝ) = 2 := by lmao
theorem the_end : False := by lmao
```

## The headliners

| tactic  | what it does |
| ------- | ------------ |
| `lmao`  | Picks a joke at random, announces the punchline, and closes the goal. |
| `lmao?` | Parodies `exact?`/`apply?`: suggests a bogus tactic via the editor's "Try this:" panel, then closes the goal anyway. |

## How it works

Two mechanisms (hybrid):

* **`Lmao.lmao_qed`** — one unsound axiom that inhabits any type. The moral equivalent of
  `sorry`, but with no warning and more confidence. It backs all the rhetorical jokes and is
  the universal closer.
* **Typed-but-false axioms** — for the classic fallacies (e.g. `freshmans_dream_ax`,
  `mul_zero_cancel`, `one_eq_two_ax`) the bogus algebraic step is declared as a real,
  type-checking axiom and the tactic actually *rewrites* with it, so the proof script reads
  like the authentic wrong derivation. Each falls back to `lmao_qed` if the step doesn't apply.

`#print axioms` on any joke proof will rat you out.

## The joke catalog

### A. Rhetorical non-proofs (`Lmao/Rhetorical.lean`)
`proof_by_intimidation`, `obviously_lmao`, `clearly_lmao`, `evidently_lmao`,
`trivially_lmao`, `left_as_an_exercise_to_the_reader`,
`i_dont_have_enough_space_in_my_notebook`, `the_margin_is_too_small`, `proof_by_authority`,
`it_is_easy_to_see`, `by_inspection`, `the_other_case_is_similar`, `wlog_assume_n_eq_1`,
`then_a_miracle_occurs`, `proof_by_vigorous_handwaving`, `and_so_on`, `etc`,
`i_couldnt_find_a_counterexample`, `proof_by_deadline`, `proof_by_funding`, `trust_me`,
`recall_that`, `as_everyone_knows`, `a_standard_argument_shows`, `modulo_details`.

### B. Classic fallacies (`Lmao/Fallacies.lean`)
`mul_by_zero`, `divide_by_zero`, `freshmans_dream`, `sophomores_dream`, `sqrt_of_square`,
`cancel_the_six`, `all_horses_same_color`, `proof_by_example`, `proof_by_base_case`,
`zero_eq_one`, `one_eq_two`, `begging_the_question`, `interesting_number`.

### C. Lean / Mathlib in-jokes (`Lmao/LeanJokes.lean`)
`aesop_but_worse`, `nlinarith_trust_me`, `polyrith_vibes`, `exact_question_mark_but_lying`,
`omega_but_its_wrong`.

## Layout

```
Lmao.lean            root; imports everything
Lmao/Core.lean       lmao_qed axiom, closeWithJoke helper, the joke registry
Lmao/Rhetorical.lean Category A
Lmao/Fallacies.lean  Category B (typed-but-false axioms)
Lmao/LeanJokes.lean  Category C
Lmao/Tactic.lean     lmao and lmao?
Demo.lean            a gallery of crimes; doubles as the test suite
```

## Build / test

```sh
lake build        # the library + the `lmao` executable
lake build Demo   # elaborates every joke against a real goal; the test suite
```

If `Demo.lean` builds, the jokes work.
