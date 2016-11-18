Rails.application.routes.draw do
   match '/tasks', to: 'tasks#index', via: [:get, :options]
   match '/tasks', to: 'tasks#create', via: [:post, :options]
   match '/task_complete', to: 'tasks#complete', via: [:post, :options]
   match '/tasks/:id', to: 'tasks#destroy', via: [:delete, :options]
   match '/tasks_toggle_all', to: 'tasks#toggle_all', via: [:post, :options]
   match '/tasks_update/', to: 'tasks#update', via: [:put, :options]
   match '/clear_completed', to: 'tasks#clear_completed', via: [:delete, :options]
end
