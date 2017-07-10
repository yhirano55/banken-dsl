module Banken
  module DSL
    class Proxy
      PERMIT_ATTRIBUTES_METHOD_NAME = "permitted_attributes".freeze

      attr_reader :controller

      def initialize(controller)
        @controller = controller
      end

      def define_banken_query_method_for(action_name, &block)
        banken_loyalty.class_eval do
          define_method("#{action_name}?", &block)
        end
      end

      def define_banken_permit_attributes_method(&block)
        banken_loyalty.class_eval do
          define_method(PERMIT_ATTRIBUTES_METHOD_NAME, &block)
        end
      end

      private

        def banken_loyalty
          ::Banken::LoyaltyFinder.new(banken_controller_name).loyalty!
        rescue ::Banken::NotDefinedError
          ::Banken::DSL::Factory.new(controller).create
        end

        def banken_controller_name
          controller.controller_path
        end

        def method_missing(method_name, *arguments, &block)
          if action_method?(method_name)
            define_banken_query_method_for(method_name, &block)
          elsif permit_attributes_method?(method_name)
            define_banken_permit_attributes_method(&block)
          else
            raise ::Banken::DSL::UndefinedAction, "#{controller}##{method_name} is undefined"
          end
        end

        def respond_to_missing?(method_name, include_private = false)
          action_method?(method_name) || permit_attributes_method?(method_name) || super
        end

        def action_method?(method_name)
          controller.action_methods.include?(method_name.to_s)
        end

        def permit_attributes_method?(method_name)
          method_name.to_s == PERMIT_ATTRIBUTES_METHOD_NAME
        end
    end
  end
end
