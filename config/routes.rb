Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    scope '/v1' do
      post '/register',  to: 'users#create'
      post '/login', to: 'users#login'
      get 'auto_login', to: 'users#auto_login'
      resources :posts
      resources :posts, param: :id do
        resources :comments
      end
      
    end
  end
end
