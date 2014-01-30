Tille::Application.routes.draw do
  # devise_for :users
  root :to 			     => 'counter#index'
  post 'record' 	   => 'counter#record_time'
  post 'stop-record' => 'counter#stop_recording'
  post 'remove-item' => 'counter#remove_item'
  post 'add_item'    => 'counter#add_item'
end
