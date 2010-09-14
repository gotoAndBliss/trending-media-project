Factory.define :valid_user, :class => User do |u|
  u.username "Trippy"
  u.password "password"
  u.password_confirmation "password"
  u.email "elephant@gmail.com"
  u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
  u.id "37"
end

Factory.define :admin_user, :class => User do |u|
  u.username "gotoAndBliss"
  u.password "orange44"
  u.password_confirmation "orange44"
  u.email "daniel.levine4@gmail.com"
  u.single_access_token "k3cFzLIQnZ4MQRmJvJzg"
end

Factory.define :invalid_user, :class => User do |u|
end