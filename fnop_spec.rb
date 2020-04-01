# frozen_string_literal: true
# rubocop:disable all
require 'rspec'
require 'pry'

$LOAD_PATH << '.'
require 'fnop'

OpOne = fnop { |context| context[:a] = 'foo' }
OpTwo = fnop { nil }
OpThree = fnop { nil }

describe 'fnop' do
  it 'works' do
    can_create_run_for_tests =
      OpOne >> OpTwo >> OpThree

    ctx = {a: 1}
    res = can_create_run_for_tests.call(ctx)
    expect(ctx).to eq(a: 'foo')

    expect(res).to be_a(FnopContext)
    expect(res[:a]).to eq('foo')
  end

  it 'can terminate with error at any fnop' do
    always_error = fnop { |ctx| ctx.error = 'BAZ' }

    mock_callable = spy(call: nil)
    stub_const('FnopThree', fnop { mock_callable.call })

    can_create_run_for_tests =
      OpOne >> always_error >> OpThree

    res = can_create_run_for_tests.call({})
    expect(res.error).to eq('BAZ')
    expect(res).to be_a(FnopContext)

    expect(mock_callable).not_to have_received(:call)
  end
end
