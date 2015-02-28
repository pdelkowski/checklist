class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

    def json_error(status, code, message, errors={})
      {
          status_code: status,
          message: message,
          error_code: code,
          errors: errors
      }
    end

    def not_found
      json = json_error 404, 'resource_not_found', 'Resource not found'
      render json: json, status: 404
    end

    def validation_error(errors)
      json_error 422, 'validation_failed', 'There are some validation errors. Check errors object.', errors
    end
end
