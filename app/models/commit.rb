class Commit < ActiveRecord::Base
  attr_accessible :begin_time, :end_time, :spent_time, :time
  
  belongs_to :item
end
