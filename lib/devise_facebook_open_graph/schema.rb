# encoding: utf-8

module DeviseFacebookOpenGraph
  module Schema
    def facebook_open_graph_authenticatable
      apply_schema ::Devise.facebook_uid_field, Integer, :limit => 8
      apply_schema ::Devise.facebook_token_field, String, :limit => 149  # [128][1][20] chars
    end
  end
end

Devise::Schema.module_eval do
  include DeviseFacebookOpenGraph::Schema
end
