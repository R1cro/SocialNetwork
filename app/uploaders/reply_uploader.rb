# encoding: utf-8
class ReplyUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process resize_to_fill: [300, 150]

  def store_dir
    "uploaders/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
