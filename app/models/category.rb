class Category < ActiveRecord::Base
  # freegan, anarchy, pics, vegan, hitch-hiking, activism, spirituality, how-to

  has_one :last_logins
  
  validates_presence_of :name
  
  
  def to_param
    "#{name.parameterize}"
  end
  
end
