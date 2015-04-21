CanalHollywood::Application.routes.draw do

  root to: 'application#home'


  resources :movies do
    collection do
      get "sync" => 'movies#sync'
      get "all_of_month" => 'movies#all_of_month'
      get "last_seven_days" => "movies#last_seven_days"
    end
    member do
      get "refresh" => "movies#refresh"
      put "imdb_rating" => "movies#imdb_rating"
    end
  end
  resources :actors
  resources :schedules, except: [:show, :edit, :new, :update, :create] do
    collection do
      get "of_day" => "schedules#index"
      get "edit_day_schedule" => "schedules#edit_day_schedule"
      put "of_day" => "schedules#update_day_schedule"
      get "premieres_of_month" => "schedules#premieres_of_month"
    end
  end

  resources :statistics, only: [:index] do
    collection do
      get 'movies_of_year' => 'statistics#movies_of_year'
    end
  end
  match 'html_tests', to: 'application#html_tests', via: [:get]

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
