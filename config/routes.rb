Tille::Application.routes.draw do
  devise_for :users

  match '/record' => "counter#record_time", via: "post"
  match '/stop-record' => "counter#stop_recording", via: "post"

  root :to => 'counter#index'
end
