# frozen_string_literal: true
# rubocop:disable all
$LOAD_PATH << '.'
require 'demo'
require 'pry'

CreateRun =
  CanCreateRunForTests >> StartRun >> AddTests >> NotifyAvo

describe 'CreateScheduledRun example' do
  let(:test_login) { Test.new('Login') }
  let(:test_checkout) { Test.new('Checkout') }

  let(:client) do
    Client.new(
      'RFQA', # name
      10, # credits
      [test_login, test_checkout], # tests
      [] # features
    )
  end

  it 'works' do
    res = CreateRun.call(client: client, requested_tests: [test_login])

    expect(res.error).to eq(nil)
    expect(res[:run].cost).to eq(10)
    expect(res[:run].tests).to eq([test_login])

    expect(client.credits).to eq(0)
    expect(StaticAvo.events.size).to eq(1)
    expect(StaticAvo.events.first).to match(
      hash_including(
        :event=>:created,
        :at=>an_instance_of(Time),
        :run=>an_instance_of(Run)
      )
    )
  end

  it 'returns early if runs are disabled' do
    client.features << 'disable_runs'
    res = CreateRun.call(client: client, requested_tests: [test_login])

    expect(res.error).to eq('runs are disabled! 😢')
  end

  it 'returns early if insufficient credits' do
    res = CreateRun.call(client: client, requested_tests: [
      test_login, test_checkout
    ])

    expect(res.error).to eq('insufficient credits 💸')
  end
end
