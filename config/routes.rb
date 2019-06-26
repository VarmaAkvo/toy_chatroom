Rails.application.routes.draw do
	root to: "chat_rooms#index"
  devise_for :users
  resources :chat_rooms, except: [:edit, :update] do
    resources :chat_messages, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
