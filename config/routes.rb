Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get 'city/input'
root 'city#input'
post "city/results" => "city#results"

get 'city/results'
end
