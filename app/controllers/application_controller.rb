class ApplicationController < ActionController::Base
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def authorize

      unless User.find_by(id: session[:user_id]) || (User.count.zero? && session[:user_id] == "temp") # Playtime
        if request.format == Mime::HTML
          redirect_to login_url, alert: "Please log in"
        else # Playtime: non-html basic http authentication
          authenticate_or_request_with_http_basic "Please log in" do |name, password|
            user = User.find_by(name: name)
            user.authenticate(password) if user
          end
        end
      end

    end
    
end
