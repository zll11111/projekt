class Photo < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
end
