module ImageAttachable
  extend ActiveSupport::Concern

  CONTENT_TYPES = %w[image/png image/jpeg image/webp].freeze
  MAX_SIZE = 5.megabytes

  class_methods do
    # Declares an image attachment with content-type + size validation.
    def attached_image(name)
      has_one_attached name
      validate { validate_attached_image(name) }
    end
  end

  private

  def validate_attached_image(name)
    attachment = public_send(name)
    return unless attachment.attached?

    unless attachment.content_type.in?(ImageAttachable::CONTENT_TYPES)
      errors.add(name, "must be a PNG, JPEG, or WebP image")
    end

    if attachment.blob.byte_size > ImageAttachable::MAX_SIZE
      errors.add(name, "must be smaller than #{ImageAttachable::MAX_SIZE / 1.megabyte}MB")
    end
  end
end
