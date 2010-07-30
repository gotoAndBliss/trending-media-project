class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, :polymorphic => true
  
  after_save :touch_votable #, :reindex_voteable
  
  
  private
  
  def touch_votable
    self.votable.touch if self.votable
  end
  
end