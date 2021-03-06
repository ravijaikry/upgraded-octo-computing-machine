class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :get_all_publisher, only: [:new,:create,:edit,:update]

  respond_to :html,:js

  def index
    @albums = Album.all.includes(:publisher)
    respond_with(@albums)
  end

  def show
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album,@publishers)
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.save
    respond_with(@album)
  end

  def update
    @album.update(album_params)
    respond_with(@album)
  end

  def destroy
    @album_id = @album.id
    @album.destroy
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def get_all_publisher
      @publishers = Publisher.all.select("id,name")
    end

    def album_params
      params.require(:album).permit(:name, :cover_art, :publisher_id, :released_on)
    end
end
