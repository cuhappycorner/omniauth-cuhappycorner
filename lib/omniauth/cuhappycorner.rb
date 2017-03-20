require "omniauth/cuhappycorner/version"
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Cuhappycorner < OmniAuth::Strategies::OAuth2
      option :name, :cuhappycorner

      option :client_options, {
        site: "https://app.cuhappycorner.com",
        authorize_url: "/oauth/authorize",
        token_url: "/oauth/token"
      }

      def request_phase
        super
      end

      uid {
        raw_info["id"]
      }

      info do
        {
          # :email => raw_info["email"]
          raw_info.merge("token" => access_token.token)
          # and anything else you want to return to your API consumers
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end

      # https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end