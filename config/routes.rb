Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    resources :users do
      resources :writings do
        resources :ratings
        resources :pages
      end
      resources :followers
    end
    post 'writings/search'
    get 'writings/search'

    root 'writings#main'
    get 'session/logout'
    get 'session/login'
    post 'session/create'
    get 'session/new'
  end
end
