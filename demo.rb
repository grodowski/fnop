# frozen_string_literal: true
# rubocop:disable all
$LOAD_PATH << '.'
require 'fnop'

# some fake data model
Client = Struct.new(:name, :credits, :tests, :features)
Test = Struct.new(:title, :instruction)
Run = Struct.new(:tests, :cost)

StaticAvo = Struct.new(:events) do
  def run_created(run)
    events << {event: :created, at: Time.now, run: run}
  end
end.new([])

TEST_PRICE = 10

# some operations to play with
CanCreateRunForTests = fnop(&lambda do |ctx| # hack to use return, pls fix
  if ctx[:client].features.include?('disable_runs')
    return ctx.stop('runs are disabled! 😢')
  end
  if ctx[:requested_tests].size * TEST_PRICE > ctx[:client].credits
    return ctx.stop('insufficient credits 💸')
  end
end)

StartRun = fnop do |ctx|
  ctx[:run] = Run.new
end

AddTests = fnop do |ctx|
  ctx[:run].tests = ctx[:requested_tests].clone
  run_cost = ctx[:run].tests.size * TEST_PRICE
  ctx[:run].cost = run_cost
  ctx[:client].credits -= run_cost
end

NotifyAvo = fnop do |ctx|
  StaticAvo.run_created(ctx[:run])
end
