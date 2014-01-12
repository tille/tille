class CounterController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @items = Item.all
  end

  def record_time
    @recording_item = RecordingItem.new( record_beginning_at: Time.now.utc, item_id: params[:item] )
    if @recording_item.save
      render text: "OK"
    else
      render text: @recording_item.errors.messages
    end
  end
  
  def stop_recording
    @item = Item.find params[:item]
    @recording_item = @item.recording_item

    if @recording_item
      # si begin_time y end_time estan en dias diferentes crear 2 commits
      Commit.create( begin_time: @recording_item.record_beginning_at,
                     end_time: Time.now,
                     spent_time: Time.now.to_i - @recording_item.record_beginning_at.to_i,
                     item_id: params[:item] )

      RecordingItem.find(@recording_item.id).destroy
      render text: "OK"
    else
      render text: "this item is not commiting time in this momment!"
    end
  end
  
  def commit_time
  end
  
end
