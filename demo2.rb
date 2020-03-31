# frozen_string_literal: true
# rubocop:disable all

class FnopContext
  def initialize(data)
    @data = data
    @error = nil
  end

  attr_reader :data
  attr_accessor :error

  private

  def method_missing(...)
    @data.public_send(...)
  end
end

def make_fnop(&operation)
  lambda do |ctx|
    ctx = FnopContext.new(ctx) unless ctx.is_a?(FnopContext) # wrap ctx
    return ctx if ctx.error # check if terminated
    ctx.tap(&operation) # ensure it always returns ctx to next op
  end
end
