class AttachFile < ApplicationRecord
  include AttachFileUploader::Attachment.new(:file)
end
