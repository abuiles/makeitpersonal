Makeitpersonal::Application.routes.draw do
  devise_for :users

  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  get "/disclaimer", to: "pages#disclaimer"
  get "/contact", to: "pages#contact"
  get "/credits", to: "pages#credits"

  match "/:username/:id", :to => "songs#show", :as => "user_song"
  match "/:username", :to => "songs#index", :as => "user"

  root :to => "pages#index"
end
