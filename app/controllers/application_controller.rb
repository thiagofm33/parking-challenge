class ApplicationController < ActionController::API

  private

    def render_errors(errors, status)
      render json: { errors: errors }, status: status
    end
end
