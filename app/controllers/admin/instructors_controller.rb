# frozen_string_literal: true

module Admin
  # Singleton: one instructor. Edit/update only.
  class InstructorsController < BaseController
    def edit
      @instructor = Instructor.current || Instructor.new
    end

    def update
      @instructor = Instructor.current || Instructor.new
      if @instructor.update(instructor_params)
        redirect_to admin_root_path, notice: "Instructor updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def instructor_params
      params.require(:instructor).permit(:name, :headline, :bio, :avatar)
    end
  end
end
