module Banken
  module DSL
    class Factory
      SUFFIX = "Loyalty".freeze

      attr_reader :controller_name, :base_controller_name

      def initialize(controller)
        @controller_name      = extract_controller_name(controller)
        @base_controller_name = extract_controller_name(controller.superclass)
      end

      def create
        Object.const_set(loyalty_name, loyalty_klass)
      end

      private

        def extract_controller_name(controller)
          controller.controller_path if controller.to_s.end_with?("Controller")
        end

        def loyalty_name
          "#{controller_name.camelize}#{SUFFIX}"
        end

        def loyalty_klass
          if base_controller_name
            Class.new(base_loyalty)
          else
            Class.new(::Banken::DSL::BaseLoyalty)
          end
        end

        def base_loyalty
          ::Banken::LoyaltyFinder.new(base_controller_name).loyalty!
        rescue ::Banken::NotDefinedError
          ::Banken::DSL::BaseLoyalty
        end
    end
  end
end
