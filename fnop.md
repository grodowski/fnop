# 1 demo basic fn composition

```
TAX_RATE = 0.4
BENEFIT_COST = 1000 * 100

subtract_benefit = ->(salary) { salary - BENEFIT_COST }
add_tax = ->(salary) { salary * (1 - TAX_RATE) }

calc = subtract_benefit >> add_tax
calc.call(30000 * 100)

format_salary = ->(salary) { "$#{format('%0.2f', salary / 100.0)}" }

formatted_calc = calc >> format_salary
formatted_calc.call(30000 * 100)
```

# 2 service objects / business objects / operations

-> tons of gems do that already!

-> use case: start a scheduled run

# 3 fnop

```
can_create_run_for_tests =
  ValidateDisabledRuns >>
  ValidateClientPricingPlanActive >>
  HasSufficientCredits

# how to call it, what's the return value?
can_create_run_for_tests.call(...)
=> <#Success ...> or <#Error at: ValidateDisabledRuns...> ?
```

demo fnop

what is still wrong with this
-> should be tested individually
-> types and signatures are out of control
-> we might want more stuff to happen on error
