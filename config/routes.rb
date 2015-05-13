  resources :mail_reminders do
    post 'update_interval_values', :on => :collection
  end

  resources :query
