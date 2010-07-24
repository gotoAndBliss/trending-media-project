class Post < ActiveRecord::Base
  belongs_to            :user, :touch => true
  
  validates_presence_of :category, :name, :url
    
  before_validation     :prepare_posts
  validate              :is_a_category?, :is_a_real_link?
  
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
  
  def is_a_category?
    unless Category.exists?(:name => self.category.downcase)
      errors.add(:category, "Woops! There's no categories with that name.")
      # return false
    end
    return true
  end
  
  def prepare_posts
    self.update_attribute("category", self.category.downcase)
    self.url = "http://" + self.url unless self.url.match /^(https?|ftp):\/\//
  end
  
  def is_a_real_link?
    @url = "http://www." + self.url unless self.url.match /www\./
    @uri = URI.parse(@url)
    case Net::HTTP.get_response(@uri)
      when Net::HTTPSuccess then true
      else errors.add(:url, ': This is not a real website')
    end
    rescue #recover on DNS failures ..
      errors.add(:url, ': This is not a real website.')
  end
  
end
