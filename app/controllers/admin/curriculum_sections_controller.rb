# frozen_string_literal: true

module Admin
  class CurriculumSectionsController < BaseController
    before_action :set_curriculum_section, only: %i[edit update destroy]

    def index
      @curriculum_sections = CurriculumSection.ordered
    end

    def new
      @curriculum_section = CurriculumSection.new
    end

    def create
      @curriculum_section = CurriculumSection.new(curriculum_section_params)
      if @curriculum_section.save
        redirect_to admin_curriculum_sections_path, notice: "Section created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @curriculum_section.update(curriculum_section_params)
        redirect_to admin_curriculum_sections_path, notice: "Section updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @curriculum_section.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@curriculum_section) }
        format.html { redirect_to admin_curriculum_sections_path, notice: "Section deleted." }
      end
    end

    private

    def set_curriculum_section
      @curriculum_section = CurriculumSection.find(params[:id])
    end

    def curriculum_section_params
      params.require(:curriculum_section).permit(:title, :lectures_count, :duration, :position)
    end
  end
end
