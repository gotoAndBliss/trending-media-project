class Post < ActiveRecord::Base

  belongs_to            :user, :touch => true
  
  validates_presence_of :category, :name
    
  before_save           :prepare_posts
  validate              :category?, :url_or_text
  
  
  has_many              :votes, :as => :votable
  has_many              :voting_users,
                        :through => :votes,
                        :source => :user
                    
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
  
  def is_a_sexy_link
    @uri = URI.parse(self.url)
    return @uri.host
  end
  
  def category?
    unless Category.exists?(:name => self.category.downcase)
      errors.add(:category, "There's no categories with that name.")
    end
    return true
  end
  
  def url_or_text
    self.url != nil || self.text != nil
  end
  
  def prepare_posts
    self.update_attribute("category", self.category.downcase) unless self.category == self.category.downcase
    if self.url?
      self.url = "http://" + self.url unless self.url.match /^(https?|ftp):\/\//
    end
  end
  
  def vote_score
    self.votes.inject(0){|sum, vote| sum + vote.value}
  end
  
end
