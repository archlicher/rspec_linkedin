Rails.application.routes.draw do

	root 'public#index'

	get 'show/:permalink', :to => 'public#show', :as => 'public_show' #to have prefix route

	get 'admin', :to => 'access#menu'
	get 'access/menu'
	get 'access/login'
	post 'access/attempt_login'
	get 'access/logout'

	resources :admin_users, :only => [:index, :new, :create, :edit, :update, :delete, :destroy] do
		member do
			get :delete
		end
	end

	resources :subjects do
		member do
			get :delete
		end
	end
	# get 'subjects/index'
	# get 'subjects/show/:id'

	# get 'subjects/new'
	# post 'subjects/create'

	# get 'subjects/edit/:id'
	# patch 'subjects/update/:id'

	# get 'subjects/delete/:id'
	# delete 'subjects/destroy/:id'

	resources :pages do
		member do
			get :delete
		end
	end

	resources :sections do
		member do
			get :delete
		end
	end

	get 'demo/index'
	get 'demo/hello'
	get 'demo/other_hello'
	get 'demo/lynda'
	get 'demo/escape_output'

end
