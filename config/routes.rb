ActionController::Routing::Routes.draw do |map|
  map.connect 'reminders/:action/:id', :controller => 'reminders'
end
