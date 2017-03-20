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
        raw_info["_id"]["$oid"]
      }

      info do {
          :email => raw_info["email"],
          :birthday => raw_info["birthday"],
          :mobile => raw_info["mobile"],
          :display_name => raw_info["display_name"],
          :name => raw_info["name"],
          :gender => raw_info["gender"],
          :cu_resident => raw_info["cu_resident"],
          :cu_link_id => raw_info["cu_link_id"],
          :type => raw_info[""],
          :token => access_token.token
          # raw_info.merge("token" => access_token.token)
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