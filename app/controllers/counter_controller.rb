class CounterController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @items = Item.all
  end

  def record_time
    params_to = { record_beginning_at: Time.now.utc, item_id: params[:item] }
    @recording_item = RecordingItem.new params_to

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
      @begin_time = @recording_item.record_beginning_at
      @end_time   = Time.now.utc - 1.second

      if @begin_time.beginning_of_day != @end_time.beginning_of_day

        spent_1 = @end_time.beginning_of_day.to_i - @begin_time.to_i
        spent_2 = @end_time.to_i - @end_time.beginning_of_day.to_i

        Commit.create(begin_time: @begin_time,
                      end_time:   @end_time.beginning_of_day,
                      spent_time: spent_1,
                      item_id:    params[:item])

        Commit.create(begin_time: @end_time.beginning_of_day,
                      end_time:   @end_time,
                      spent_time: spent_2,
                      item_id:    params[:item])
      else
        spent = @end_time.to_i - @begin_time.to_i
        Commit.create(begin_time: @begin_time,
                      end_time:   @end_time,
                      spent_time: spent,
                      item_id:    params[:item])
      end

      RecordingItem.find(@recording_item.id).destroy
      render text: "OK"
    else
      render text: "this item is not commiting time in this momment!"
    end
  end

  def remove_item
    item_id = params[:item]

    if Item.find(item_id).destroy
      render text: "OK"
    else
      render text: "Object cannot be destroyed!!"
    end
  end

  def add_item
    @item = Item.new params[:item]
    if @item.valid?
      params[:item][:estimated_time] = params[:item][:estimated_time]*60
    end

    if @item.save
      redirect_to '/', notice: "Item was succesfully created!!"
    else
      redirect_to root_path, alert: @item.errors.full_messages
    end
  end

  def commit_time
  end

end
