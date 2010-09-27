# encoding: utf-8
require 'devise'

module Devise
  module Models
    module FacebookOpenGraphAuthenticatable
    

      def self.included(base) 
        base.class_eval do
          attr_accessor :facebook_session
          extend ClassMethods
        end
      end


      module ClassMethods
        Devise::Models.config(self,
          :facebook_uid_field, :facebook_token_field, :facebook_auto_create_account, :run_validations_when_creating_facebook_user,
          :skip_confimation_for_facebook_users
        )

        def facebook_auto_create_account?
          !!facebook_auto_create_account
        end

        def authenticate_facebook_user(facebook_uid)
          self.first facebook_uid_field.to_sym => facebook_uid.to_i
        end
        
        def unique_uid?(facebook_uid)
          self.where(facebook_uid_field.to_sym => facebook_uid.to_i).count == 0
        end
      end

      def set_facebook_credentials_from_session!
        raise "Can't set facebook credentials from session without the session!" if facebook_session.blank?
        send(self.class.facebook_uid_field.to_s+'=', facebook_session.uid)
        #send(self.class.facebook_uid_field.to_s+'=', facebook_session.uid)
        
        make_facebook_model_valid!
      end

      def authenticated_via_facebook?
        read_attribute(self.class.facebook_uid_field).present?
      end

      private
        #
        # In case of model having included other modules like
        # database_authenticate and so on we need to "by pass" some validations etc.
        #
        def make_facebook_model_valid!
          # These database fields are required if authenticable is used
          write_attribute(:password_salt, '') if self.respond_to?(:password_salt)
          write_attribute(:encrypted_password, '') if self.respond_to?(:encrypted_password)

          skip_confirmation! if self.class.skip_confimation_for_facebook_users && respond_to?(:skip_confirmation!)
        end
    end
          
      protected

      # Passwords are always required if it's a new record and no oauth_id exists, or if the password
      # or confirmation are being set somewhere.
      def password_required?
        
        
        ( new_record? &&  read_attribute(self.class.facebook_uid_field).nil? ) || !password.nil? || !password_confirmation.nil?
      end
  end
end
