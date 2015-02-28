class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

    def not_found
      json = {
          'status_code' => 404,
          'error_code' => 'resource_not_found'
      }

      render json: json, status: 404
    end

    def validation_error(errors)
      {
          status_code: 422,
          error_code: "validation_failed",
          message: "There are some validation errors. Check errors object.",
          errors: errors
      }
    end
end
