# The 3 steps of Oauth2
class GateController < ApplicationController
  def door
    redirect_to Gatekeeper.greetings_url
  end

  def lock
    response = Gatekeeper.are_you_the_keymaster?(params[:code])
    session[:access_token] = response['access_token']
    session[:refresh_token] = response['refresh_token']
    redirect_to action: 'foyer'
  end

  def foyer
    player_one = Gatekeeper.welcomes_you(
      session[:access_token],
      session[:refresh_token])
    @display = player_one.accounts
  end
end
