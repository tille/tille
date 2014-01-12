Tille::Application.routes.draw do
  # devise_for :users

  root :to 			 => 'counter#index'
  post 'record' 	 => 'counter#record_time'
  post 'stop-record' => 'counter#stop_recording'
end
