# encoding: utf-8

module DeviseFacebookOpenGraph
  module Rails
    module ControllerHelpers
      

      def self.included(base)
        base.class_eval do
          helper_method :facebook_session
        end
      end

      def facebook_session
        @facebook_session ||= DeviseFacebookOpenGraph::Facebook::Session.new_or_nil_if_invalid(cookies)
      end
    end
  end
end
