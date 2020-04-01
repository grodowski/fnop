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
code that does not belong to model or controller
-> gems do that already
-> trailblazer operation
-> extract to PORO seems to be our choice, example: Tests::Create class used in API, suite selection and free trial

typical "complex" operation workflow

-> mock use case: create a run

# 3 fnop

```
CreateScheduledRun =
  CanCreateRunForTests >> StartRun >> AddTests >> NotifyAvo

# how to call it, what's the return value?
CreateScheduledRun.call(...)
=> <#Success ...> or <#Error at: ValidateDisabledRuns...> ?
```

demo fnop

-> sliding scale

-> "Context" vs multiple args?
-> should be tested individually
-> types and signatures are out of control
-> we might want more stuff to happen on error (cleanup?)
-> supporting transactions

