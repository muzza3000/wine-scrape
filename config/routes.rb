Rails.application.routes.draw do
  root to: "pages#home"
  get '/scrape', to: 'drinks#scrape'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :drinks, only: %i[index] do
  end
end
