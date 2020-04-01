Experiment with function composition

Create an operation with

```
operation = fnop do |context|
  # do stuff
end

erroring_operation = fnop do |context|
  context.stop('nope!')
end
```

Compose them with `>>` and run
```
composed =
  operation >> erroring_operation >> operation

data = OpenStruct.new
res = composed.call(data)

res.error
=> 'nope!'
```

See `demo.rb` and `demo_spec.rb` for more examples.
