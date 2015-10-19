# OAuth v2.0 3-step process
class Gatekeeper < ActiveRecord::Base
  zuul = self # Ghostbusters theme: ON

  @app = {
    id: ENV['APP_CLIENT_ID'],
    secret: ENV['APP_SECRET'],
    redirect: ENV['APP_REDIRECT'],
    scope: 'wallet:accounts:read',
    host: 'sandbox.coinbase.com' }

  def zuul.greetings
    'https://' + @app[:host] + '/oauth/authorize?' \
      'response_type=code&state=SECURE_RANDOM' \
      '&client_id=' + @app[:id] + '&redirect_uri=' +
      @app[:redirect] + '&scope=' + @app[:scope]
  end

  def zuul.are_you_the_keymaster?(code)
    response = Net::HTTP.post_form(
      URI('https://api.' + @app[:host] + '/oauth/token'),
      'grant_type' => 'authorization_code',
      'code' => code,
      'client_id' => @app[:id],
      'client_secret' => @app[:secret],
      'redirect_uri' => @app[:redirect])
    JSON.parse(response.body)
  end

  def zuul.welcomes_you(access_token, refresh_token)
    require 'coinbase/wallet'
    Coinbase::Wallet::OAuthClient.new(
      access_token: access_token,
      refresh_token: refresh_token,
      api_url: 'https://api.' + @app[:host])
  end
end
