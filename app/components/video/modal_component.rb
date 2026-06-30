# frozen_string_literal: true

# Shared video modal: a Bootstrap modal whose <video> is populated from whichever
# "Preview" trigger opened it. Triggers carry data-bs-toggle="modal",
# data-bs-target="#videoModal" and a data-video-url (see video_modal_controller.js).
class Video::ModalComponent < ApplicationComponent
end
