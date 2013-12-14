class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # the following code is not ready.  We would have to make custom error pages for each...
  #unless Rails.application.config.consider_all_requests_local
#	  rescue_from ActiveRecord::RecordNotFound,
#	  			  ActionController::RoutingError,
#	  			  ActionController::UnknownController,
#	  			  ActionController::UnknownAction,
#	  			  ActionController::MethodNotAllowed do |e|
#
#	  	Rollbar.report_exception(e, rollbar_request_data, rollbar_person_data)


				
end
