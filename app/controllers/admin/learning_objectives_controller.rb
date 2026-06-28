# frozen_string_literal: true

module Admin
  class LearningObjectivesController < BaseController
    before_action :set_learning_objective, only: %i[edit update destroy]

    def index
      @learning_objectives = LearningObjective.ordered
    end

    def new
      @learning_objective = LearningObjective.new
    end

    def create
      @learning_objective = LearningObjective.new(learning_objective_params)
      if @learning_objective.save
        redirect_to admin_learning_objectives_path, notice: "Objective created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @learning_objective.update(learning_objective_params)
        redirect_to admin_learning_objectives_path, notice: "Objective updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @learning_objective.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@learning_objective) }
        format.html { redirect_to admin_learning_objectives_path, notice: "Objective deleted." }
      end
    end

    private

    def set_learning_objective
      @learning_objective = LearningObjective.find(params[:id])
    end

    def learning_objective_params
      params.require(:learning_objective).permit(:description, :position)
    end
  end
end
