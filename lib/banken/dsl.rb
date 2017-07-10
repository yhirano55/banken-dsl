require "banken"

module Banken
  module DSL
    extend ActiveSupport::Concern

    class_methods do
      def authorization_policy(&block)
        banken_dsl_proxy.instance_eval(&block)
      end

      def define_banken_query_method_for(action_name, &block)
        banken_dsl_proxy.define_banken_query_method_for(action_name, &block)
      end

      private

        def banken_dsl_proxy
          @_banken_dsl_proxy ||= ::Banken::DSL::Proxy.new(self)
        end
    end
  end
end

require "banken/dsl/base_loyalty"
require "banken/dsl/error"
require "banken/dsl/factory"
require "banken/dsl/proxy"
require "banken/dsl/version"

Banken.send(:include, ::Banken::DSL)
