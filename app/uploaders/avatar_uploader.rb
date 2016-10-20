# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process resize_to_fill: [100, 100]

  def store_dir
    "uploaders/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

end
