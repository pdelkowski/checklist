class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from Error, with: :render_error
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  private

    # @param e Error
    def render_error(e)
      render 'api/v1/error', status: e.http_status, locals: { error: e }
    end

    def resource_not_found
      render_error(Error::ResourceNotFound.new)
    end
end
