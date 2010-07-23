class Post < ActiveRecord::Base
  belongs_to :user, :touch => true
  
  def time_from_now
    #-time = DateTime.now.hour - (self.created_at.hour)
    elapsed_time = (Time.now - self.created_at.to_time)/1.hour
    hours_past = Fixnum.induced_from(elapsed_time)
    if hours_past > 23
      days_past = (Time.now - self.created_at.to_time)/1.day
      a = Fixnum.induced_from(days_past)
      day = a > 1 ? "days" : "day"
      return a.to_s + " " + day.to_s
    elsif hours_past < 23 && hours_past > 1
      hour = hours_past > 1 ? "hours" : "hour"
      return hours_past.to_s + " " + hour
    else
      minutes_past = (Time.now - self.created_at.to_time)/1.minute
      b = Fixnum.induced_from(minutes_past)
      minute = b > 1 ? "minutes" : "minute"
      return b.to_s + " " + minute
    end
  end
  
  def is_a_sexy_link
    @uri = URI.parse(self.url)
    return @uri.host
  end
  
end
