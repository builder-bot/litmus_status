LitmusStatus::Application.routes.draw do
  resources :servers

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
    	put 'servers/:id(.:format)'  => 'servers#update'
    	put 'servers/:id/status/:status(.:format)'  => 'servers#update_status'
    end
  end

  root 'servers#index'
end
