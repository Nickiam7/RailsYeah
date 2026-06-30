# frozen_string_literal: true

require "test_helper"

class Video::ModalComponentTest < ViewComponent::TestCase
  def test_renders_the_modal_shell
    render_inline(Video::ModalComponent.new)

    assert_selector "#videoModal.modal[data-controller='video-modal']"
    assert_selector "video[data-video-modal-target='player'][controls]"
  end
end
