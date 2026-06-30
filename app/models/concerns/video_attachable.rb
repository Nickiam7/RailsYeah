module VideoAttachable
  extend ActiveSupport::Concern

  CONTENT_TYPES = %w[video/mp4 video/webm video/ogg video/quicktime].freeze
  MAX_SIZE = 200.megabytes

  class_methods do
    # Declares a video attachment with content-type + size validation.
    def attached_video(name)
      has_one_attached name
      validate { validate_attached_video(name) }
    end
  end

  private

  def validate_attached_video(name)
    attachment = public_send(name)
    return unless attachment.attached?

    unless attachment.content_type.in?(VideoAttachable::CONTENT_TYPES)
      errors.add(name, "must be an MP4, WebM, Ogg, or MOV video")
    end

    if attachment.blob.byte_size > VideoAttachable::MAX_SIZE
      errors.add(name, "must be smaller than #{VideoAttachable::MAX_SIZE / 1.megabyte}MB")
    end
  end
end
