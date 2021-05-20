class ApplicationController < ActionController::Base
  # TO DO: investigate
  protect_from_forgery with: :null_session, only: proc { |c| c.request.format.json? }
end
