Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  namespace :admin do
    get "" => "admin#index", as: :home
    resources :event_types
    resources :events
    resources :facilities
    resources :mess_types
    resources :messes
    resources :users
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
