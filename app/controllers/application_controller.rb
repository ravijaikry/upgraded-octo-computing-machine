require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html,:json
  before_action :get_latest_data
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_latest_data
     @latest_song ||=  Song.recent(1).first
     @latest_5_song ||= Rails.cache.fetch("latest_5_song", expires_in: 1.hours) do
      Song.recent(5)
    end
  end
end
