Rails.application.routes.draw do
  root 'gate#door'

  get 'callback' => 'gate#lock'
  get 'foyer' => 'gate#foyer'
end
