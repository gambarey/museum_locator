Rails.application.routes.draw do
  root to: "museums#new"
  post "/museums", to: "museums#create"
  get "/museums", to: "museums#index"
end
