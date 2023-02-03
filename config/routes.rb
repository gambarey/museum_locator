Rails.application.routes.draw do
  get "/museums/new", to: "museums#new"
  post "/museums", to: "museums#create"
  get "/museums", to: "museums#index"
end

