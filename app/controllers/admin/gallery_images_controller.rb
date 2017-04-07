class Admin::GalleryImagesController < ApplicationController
  layout 'admin'
  before_action :require_user, :require_admin
  
  def index
    @images = GalleryImage.all
  end 
  
  def collect_all
    @images = GalleryImage.all
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def new
  
  end
  
  def create
    @image = GalleryImage.create(gallery_image_params)
    
    respond_to do |format|
      if @image.save
        format.html { redirect_to admin_gallery_images_path }
        format.js
        format.json
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @image = GalleryImage.find(params[:id])
  end
  
  def update
    @image = GalleryImage.find(params[:id])
    
    if @image.update(gallery_image_params)
      redirect_to admin_gallery_images_path, :flash => { :success => "Gallery Image Successfully Upated" }
    else
      render :edit
    end
  end
  
  def destroy
    @image = GalleryImage.find(params[:id])
    @image.destroy
    redirect_to admin_gallery_images_path
  end
  
  private 
  
    def gallery_image_params
      params.require(:gallery_image).permit(:name, :image)
    end
  
  
end