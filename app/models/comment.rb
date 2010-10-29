class Comment < ActiveRecord::Base
  
  belongs_to  :user, :touch => true
  belongs_to  :commentable, :polymorphic => true
  has_many    :comments, :as => :commentable
  
  has_many    :votes, :as => :votable                                            
  has_many    :voting_users,                                                     
              :through => :votes,                                                
              :source => :user
            
  
  validates_presence_of :text

  def vote_score
    self.votes.inject(0){|sum, vote| sum + vote.value}
  end
  
end
