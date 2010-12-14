class Comment < ActiveRecord::Base
  
  belongs_to  :user, :touch => true
  belongs_to  :commentable, :polymorphic => true
  has_many    :comments, :as => :commentable
  
  has_many    :votes, :as => :votable                                            
  has_many    :voting_users,                                                     
              :through => :votes,                                                
              :source => :user
            
  
  validates_presence_of :text
  
  def self.after(date)
    where "created_at > ?", date
  end
  
  def self.replies_for(user)
    #commentable_type = post | comment
    #find all comments from post && comment but do not let them overlap..
    #post_replies = where(:commentable_type => "Post", :commentable_id => user.posts.map(&:id)).where("user_id != ?", user.id)
    #comment_replies = 
    where(:commentable_id => user.comments.map(&:id)).where("user_id != ?", user.id) 
    
  end

  def vote_score
    self.votes.inject(0){|sum, vote| sum + vote.value}
  end
  
  def time_from_now
    days_past = (Time.now - self.created_at.to_time)/1.day
    hours_past = (Time.now - self.created_at.to_time)/1.hour
    minutes_past = (Time.now - self.created_at.to_time)/1.minute
    seconds_past = (Time.now - self.created_at.to_time)/1.second
    if hours_past > 23
      time = Fixnum.induced_from(days_past)
      time_description = days_past > 1 ? "days" : "day"
    elsif hours_past > 1 && hours_past < 24
      time = Fixnum.induced_from(hours_past)
      time_description = hours_past > 1 ? "hours" : "hour"
    elsif hours_past < 1 && seconds_past > 60
      time = Fixnum.induced_from(minutes_past)
      time_description = minutes_past > 1 ? "minutes" : "minute"
    else
      time = Fixnum.induced_from(seconds_past)
      time_description = seconds_past > 1 ? "seconds" : "second"
    end
    return time.to_s + " " + time_description.to_s
  end
  
end
