class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :items
  has_many :commits, :through => :items

  # this method return the time commited today by this user in format #h#m#s
  def today_time
    Item.format_time today_seconds
  end

  # this method return the seconds commited today by this user
  def today_seconds
    beginning_in = DateTime.now.utc.beginning_of_day
    deadline     = DateTime.now.utc.end_of_day
    self.commits.where("begin_time > ? and end_time < ?", beginning_in, deadline).sum(:spent_time)
  end

  # this method return the time commited this week by this user in format #h/#m/#s
  def week_time
    Item.format_time week_seconds
  end

  # this method should return the seconds commited this week by this user
  def week_seconds
    week_begin = DateTime.now.utc.beginning_of_week
    deadline   = DateTime.now.utc.end_of_week
    self.commits.where("begin_time > ? and end_time < ?", week_begin, deadline).sum(:spent_time)
  end

end