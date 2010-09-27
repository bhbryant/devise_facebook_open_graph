# encoding: utf-8
require 'devise'

module DeviseFacebookOpenGraph
  module Facebook
    autoload :Config, "devise_facebook_open_graph/facebook/config"
    autoload :Session, "devise_facebook_open_graph/facebook/session"
  end

  module Rails
    autoload :ViewHelpers, "devise_facebook_open_graph/rails/view_helpers"
    autoload :ControllerHelpers, "devise_facebook_open_graph/rails/controller_helpers"
  end
end

require 'devise_facebook_open_graph/rails'
require 'devise_facebook_open_graph/strategy'
require 'devise_facebook_open_graph/schema'

module Devise
  #
  # Specifies database column name to store the facebook user id.
  #
  mattr_accessor :facebook_uid_field
  @@facebook_uid_field = :facebook_uid
  
    #
  # Specifies database column name to store the facebook auth toke id.
  #
  mattr_accessor :facebook_token_field
  @@facebook_uid_field = :facebook_token


  # Instructs this gem to auto create an account for facebook
  # users which have not visited before
  #
  mattr_accessor :save_facebook_token
  @@save_facebook_token = true


  #
  # Instructs this gem to auto create an account for facebook
  # users which have not visited before
  #
  mattr_accessor :facebook_auto_create_account
  @@facebook_auto_create_account = true

  #
  # Runs validation when auto creating users on facebook connect
  #
  mattr_accessor :run_validations_when_creating_facebook_user
  @@run_validations_when_creating_facebook_user = false

  #
  # Skip confirmation loop on facebook connection users
  #
  mattr_accessor :skip_confimation_for_facebook_users
  @@skip_confimation_for_facebook_users = true
end

Devise.add_module(:facebook_open_graph_authenticatable,
  :strategy => true,
  :controller => :sessions,
  :model => 'devise_facebook_open_graph/model'
)
