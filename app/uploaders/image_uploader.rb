# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  #include CarrierWave::RMagick

  process resize_to_fill: [450, 250]

  def store_dir
    "uploaders/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  # end

end
