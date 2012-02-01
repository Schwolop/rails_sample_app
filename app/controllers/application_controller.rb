class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper # Provide the sessions helper to all controllers 
    # (as well as in views where helpers are available by default).
end
