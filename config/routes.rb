#ActionController::Routing::Routes.draw do |map|
#map.connect '/issue_reminder/index', :controller => 'issue_reminder', :action => 'index'
#map.connect '/rt_import/match', :controller => 'issue_reminder', :action => 'import'
#end

#ActionController::Routing::Routes.draw do |map|
#  map.connect 'projects/:id/templatesg/:action', :controller => 'templatesg'
#  map.connect 'templatesg/:action', :controller => 'templatesg'
#  map.connect 'template/:action', :controller => 'templates'
#  map.connect 'projects/:id/settings/template', :controller => 'templates'
  #map.connect 'projects/:id/settings/:action', :controller => 'Templates'
#end

#SampleApp::Application.routes.draw do
#  match '/contact', :to => 'pages#contact'
#  match '/about',   :to => 'pages#about'
#  match '/help',    :to => 'pages#help'
   
#end

#get '

get 'reminders', :to => 'reminders#index'
