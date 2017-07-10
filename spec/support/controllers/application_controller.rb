class ApplicationController
  include Banken

  attr_accessor :current_user, :params

  def initialize(current_user, params={})
    @current_user = current_user
    @params = params
  end

  def show; end

  def update; end

  def destroy; end

  class << self
    def controller_path
      name.sub(/Controller$/, '').underscore
    end

    def action_methods
      @_action_methods ||= public_instance_methods(true).map(&:to_s) - [Banken::DSL::Proxy::PERMIT_ATTRIBUTES_METHOD_NAME]
    end
  end
end
