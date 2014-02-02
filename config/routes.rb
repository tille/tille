Tille::Application.routes.draw do

  root :to 			     => 'landing#index'
  get  'dashboard'   => 'counter#index', as: 'user_root'
  post 'record' 	   => 'counter#record_time'
  post 'stop-record' => 'counter#stop_recording'
  post 'remove-item' => 'counter#remove_item'
  post 'add_item'    => 'counter#add_item'
  devise_for :users
end
