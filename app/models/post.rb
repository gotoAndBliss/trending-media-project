class Post < ActiveRecord::Base

  #before_save                   :parse_text
                                                                           
  belongs_to                    :user, :touch => true                            
                                                                           
  validates_presence_of         :category, :name                                 
  validates_presence_of         :url, :unless => Proc.new {|post| post.text}     
                                                                           
  before_save                   :prepare_posts                                   
  validate                      :category?                                       
                                                                           
                                                                           
  has_many                      :votes, :as => :votable                          
  has_many                      :voting_users,                                   
                                :through => :votes,                              
                                :source => :user
                                                                           
  has_many                      :comments, :as => :commentable                                        
  accepts_nested_attributes_for :comments, :allow_destroy => true
  
  has_friendly_id               :name, :use_slug => true
                    
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
  
  def video_link
    case self.is_a_sexy_link
    when "www.youtube.com", "vimeo.com"
      return true
    end
  end
  
  def imgur_url
    case self.is_a_sexy_link
    when "i.imgur.com"
      return true
    end
  end
  
  def tube_url
    link = self.url.gsub(/watch\?v=/, 'v/')
    link + "?fs=1"
  end
  
  def vimeo_url
    link = self.url.split(/http:\/\/vimeo.com\//)[1]
  end
  
  def category?
    if self.category
      unless Category.exists?(:name => self.category.downcase)
        errors.add(:category, "There's no categories with that name.")
      end
      return true
    end
  end
  
  def prepare_posts
    if self.category
      self.update_attribute("category", self.category.downcase) unless self.category == self.category.downcase
      if self.url?
        self.url = "http://" + self.url unless self.url.match /^(https?|ftp):\/\//
      end
    end
  end
  
  def vote_score
    self.votes.inject(0){|sum, vote| sum + vote.value}
  end
  
  def shwagrithm
    a = self.created_at
    b = Time.parse("October 4 1984 3:54am")
    ts = a - b
    if self.vote_score > 0
      y = 1
    elsif self.vote_score < 0
      y = -1
    else
      y = 0
    end
    z = self.vote_score.abs
    if z < 1
      z = 1
    end
    rating = 45000 * Math.log10(z) + y * ts
  end
  
  #imgur cookie = lodhrt2tttmia6qkh93ntei4q1

  def imgur(key, cookie, file_path)
    data = {
      :key => key, :image => File.open(file_path)
    }
    headers = {
      "Cookie" => "IMGURSESSION=#{cookie}"
    }

    http      = Net::HTTP.new("imgur.com")
    path      = "/api/upload.json"
    response  = http.post(path, data, headers)
    json      = JSON.parse(response.body)["rsp"]["image"] rescue nil
  end
  

  private
  
  def parse_text
    if self.is_link != true
      self.text = RedCloth.new(text).to_html
    end
  end
  
end

