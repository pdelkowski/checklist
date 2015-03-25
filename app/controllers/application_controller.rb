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




    def json_error(status, code, message, errors={})
      {
          status_code: status,
          message: message,
          error_code: code,
          errors: errors
      }
    end

    def validation_error(errors)
      json_error 422, 'validation_failed', 'There are some validation errors. Check errors object.', errors
    end
end
