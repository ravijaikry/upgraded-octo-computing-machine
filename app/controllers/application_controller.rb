require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  before_action :get_latest_data
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_latest_data
     @latest_song = Song.joins(:album).order("albums.released_on DESC").order("songs.id DESC").first
  end
end
