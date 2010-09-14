Factory.define :category do |c|
  c.name "spirituality"
  c.id "37"
end

Factory.define :invalid_category, :class => Category do |c|
end