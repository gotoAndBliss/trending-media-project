class Category < ActiveRecord::Base
  # freegan, anarchy, pics, vegan, hitch-hiking, activism, spirituality, how-to

  validates_presence_of :name
  
  def to_param
    "#{name.parameterize}"
  end
  
end
