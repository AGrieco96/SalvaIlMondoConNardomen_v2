Rails.application.routes.draw do

  
	# set root
	root 		'static_pages#home'
	
	# static_pages routes
  get 		'/home'			,to: 		'static_pages#home'
  get 		'/about'		,to: 		'static_pages#about'
  get 		'/contact'	,to: 		'static_pages#contact'
  get 		'/other'		,to: 		'static_pages#other'
  get 		'/privacy'	,to: 		'static_pages#privacy'
  # devise routes
 
  devise_for :users ,:controllers => { registrations: 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions' } 
  devise_scope :user do
   	get 		'/login'		,to:	 	'users/sessions#new'				#,as: 'new_user_session'
  	# post 		'/login'		,to: 	'devise/sessions#create'		,as: :user_session
  	delete 	'/logout'		=>	 	'users/sessions#destroy'		#,as: :destroy_user_session
    get 		'/signup' 	=> 		'devise/registrations#new'	#,as: 'new_user_registration' # custom path to sign_up/registration
  end

  # routes for users profiles
  resources :users ,:only => [:show] do
  	member do
      get :following ,:followers
    end
  end
  
  get 	'/search'			,to: 		'users#search'
  get 	'/find'				,to: 		'users#find_friends'

  # routes for relationship model
  resources 	:relationships,	only: [:create, :destroy]

  # routes for store
  get 		'/store'		,to: 		'stores#index'
  post		'/store'		,to: 		'stores#buy'

  # routes for game
  get 		'/settings'	,to: 		'games#settings'
  post 		'/settings'	,to: 		'games#change_settings'
  get 		'/game'			,to:  	'games#game'
  post 		'/game' 		,to: 		'games#get_score'

  # routes for notifications
  resources :notifications ,:only => [:show]

  #router for game_master and game_founder
  get   '/masterpanel'  ,to:    'game_masters#index'
  get   '/founderpanel' ,to:    'game_founders#index'

  #for game_founder
  post  '/fban'         ,to:    'game_founders#ban'
  post  '/removeban'    ,to:    'game_founders#remove'
  post  '/approveban'   ,to:    'game_founders#approve'
  post  '/promote'      ,to:    'game_founders#promote'
  post  '/demote'       ,to:    'game_founders#demote'

  #for game_master
  post  '/mban'         ,to:    'game_masters#ban'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
