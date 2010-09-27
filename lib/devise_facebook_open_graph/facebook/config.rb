# encoding: utf-8
require "yaml"

#
# Provides basic Facebook functionality. You can ask it for
# the current configuration strings like Facebook.api_key,
# Facebook.application_id and Facebook.application_secret.
#
module DeviseFacebookOpenGraph
  module Facebook
    module Config
      class << self

        #
        # Overrides the default configuration file path which is
        # read from when requesting application_id, api_key,
        # application_secret etc.
        #
        #
        #
        attr_accessor :path
        
        
        
        def application_id 
          @application_id ||= ::Devise::FB_CONFIG['client_id']
        end
        
        def api_key    
          @api_key ||= ::Devise::FB_CONFIG['api_key']
        end 
          
        def application_secret           
          @application_secret ||= ::Devise::FB_CONFIG['client_secret']
        end
        
        def requested_scope   
          @requested_scope ||= ::Devise::FB_CONFIG['requested_scope']
        end
=begin
        %w(application_id api_key application_secret).each do |config_key|
          define_method(config_key) do
            instance_variable_get('@'+config_key) or
            instance_variable_set('@'+config_key, config[config_key])
          end
        end
=end

        def sdk_java_script_source
          #"http://connect.facebook.net/#{I18n.locale}/all.js"
          "http://connect.facebook.net/en_US/all.js"
        end

        def facebook_session_name
          "fbs_#{application_id}"
        end
=begin
        private
          def config_file_path
            path || ::Rails.root.join('config', 'facebook.yml')
          end

          def config
            @config ||= YAML.load_file(config_file_path)[::Rails.env]
          end
=end
      end
    end
  end
end
