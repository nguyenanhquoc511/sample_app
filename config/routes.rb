Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/help", to: "static_pages#help"
    get "/signup", to: "users#new"
    resources :users
  end
end
