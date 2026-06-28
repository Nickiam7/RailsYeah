# frozen_string_literal: true

module Admin
  class FaqItemsController < BaseController
    before_action :set_faq_item, only: %i[edit update destroy]

    def index
      @faq_items = FaqItem.ordered
    end

    def new
      @faq_item = FaqItem.new
    end

    def create
      @faq_item = FaqItem.new(faq_item_params)
      if @faq_item.save
        redirect_to admin_faq_items_path, notice: "FAQ created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @faq_item.update(faq_item_params)
        redirect_to admin_faq_items_path, notice: "FAQ updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @faq_item.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@faq_item) }
        format.html { redirect_to admin_faq_items_path, notice: "FAQ deleted." }
      end
    end

    private

    def set_faq_item
      @faq_item = FaqItem.find(params[:id])
    end

    def faq_item_params
      params.require(:faq_item).permit(:question, :answer, :position, :published)
    end
  end
end
