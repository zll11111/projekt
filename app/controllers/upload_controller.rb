class UploadController < ApplicationController
  #skip_before_action :verify_authenticity_token
  def upload_image
    if params[:image]
      photo = Photo.create(photo_params)
      render json: {link: photo.image_url}
    end

  end

  def upload_file
    if params[:file]
      attach_file = AttachFile.create(file_params)
      render json:{link: attach_file.file_url}
    end
  end

  def photo_params
    params.permit(:image)
  end

  def file_params
    params.permit(:file)
  end
end
