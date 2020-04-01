# frozen_string_literal: true
# rubocop:disable all
require 'pry'

TAX_RATE = 0.4
BENEFIT_COST = 1000 * 100

subtract_benefit = ->(salary) { salary - BENEFIT_COST }
add_tax = ->(salary) { salary * (1 - TAX_RATE) }

calc = subtract_benefit >> add_tax

format_salary = ->(salary) { "$#{format('%0.2f', salary / 100.0)}" }
formatted_calc = calc >> format_salary

binding.pry
