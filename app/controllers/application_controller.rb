class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters
    def configure_permitted_parameters
        devise_paramater_sanitizer.permit(:sign_up, keys: [:name])
    end

end
