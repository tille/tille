class Commit < ActiveRecord::Base
  attr_accessible :begin_time, :end_time, :spent_time, :time, :item_id
  
  belongs_to :item
end
