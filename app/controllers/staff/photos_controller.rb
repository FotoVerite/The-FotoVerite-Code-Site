class Staff::PhotosController < ApplicationController

  before_filter :confirm_logged_in

  def edit
    @photo = Photo.find(params[:id])
    render(:layout => false )
  end

  def update
    respond_to do |format|
      format.html {render_404}
      format.js do

        @photo = Photo.find(params[:id])
        if @photo.update_attributes(params[:photo])
          flash.now[:notice] = "Updated Photo"
        end
      end
    end
  end

  def sort
    respond_to do |format|
      format.html {render_404}
      format.js do

        photos = Portfolio.find(params[:portfolio_id]).photos
        params['photo'].each_with_index do |id, index|
          photos.update_all(['position=?', index+1], ['id=?', id])
        end

        render :nothing => true

      end
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html {render_404}
      format.js { }
    end
  end

end
