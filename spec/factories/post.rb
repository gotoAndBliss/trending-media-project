Factory.define :post do |p|
  p.category "spirituality"
  p.name "108 Tips To Non-Violence"
  p.url "www.shwagr.com"
end

Factory.define :voted_post, :parent => :post, :class => Post do |p|
end