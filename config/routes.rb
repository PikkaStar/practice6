Rails.application.routes.draw do


  devise_for :admins,skip: [:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
   resources :posts,except: [:new] do
     resource :favorites,only: [:create,:destroy]
     resources :post_comments,only: [:create,:destroy]
   end
  end
  namespace :public do
    resources :customers,except: [:new,:destroy]
  end

  root to: "homes#top"
  get 'homes/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
