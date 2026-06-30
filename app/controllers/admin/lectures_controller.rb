# frozen_string_literal: true

module Admin
  # Lectures are managed within a curriculum section (nested resource).
  class LecturesController < BaseController
    before_action :set_curriculum_section
    before_action :set_lecture, only: %i[edit update destroy]

    def index
      @lectures = @curriculum_section.lectures.ordered
    end

    def new
      @lecture = @curriculum_section.lectures.new
    end

    def create
      @lecture = @curriculum_section.lectures.new(lecture_params)
      if @lecture.save
        redirect_to admin_curriculum_section_lectures_path(@curriculum_section), notice: "Lecture created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @lecture.update(lecture_params)
        redirect_to admin_curriculum_section_lectures_path(@curriculum_section), notice: "Lecture updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @lecture.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@lecture) }
        format.html { redirect_to admin_curriculum_section_lectures_path(@curriculum_section), notice: "Lecture deleted." }
      end
    end

    private

    def set_curriculum_section
      @curriculum_section = CurriculumSection.find(params[:curriculum_section_id])
    end

    def set_lecture
      @lecture = @curriculum_section.lectures.find(params[:id])
    end

    def lecture_params
      params.require(:lecture).permit(:title, :duration, :lecture_type, :preview, :position, :video)
    end
  end
end
