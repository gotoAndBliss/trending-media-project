class Category < ActiveRecord::Base
  
  has_many :posts
  # freegan, anarchy, pics, vegan, hitch-hiking, activism, spirituality, how-to
  
end
