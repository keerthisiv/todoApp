Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   match '/tasks', to: 'tasks#create', via: [:post, :options]
   match '/task_complete', to: 'tasks#complete', via: [:post, :options]
   match '/tasks/:id', to: 'tasks#destroy', via: [:delete, :options]
end
