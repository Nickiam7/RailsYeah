# frozen_string_literal: true

module Admin
  # Singleton: the landing page has one hero. Edit/update only.
  class HeroContentsController < BaseController
    def edit
      @hero_content = HeroContent.current || HeroContent.new
    end

    def update
      @hero_content = HeroContent.current || HeroContent.new
      if @hero_content.update(hero_content_params)
        redirect_to admin_root_path, notice: "Hero updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def hero_content_params
      params.require(:hero_content).permit(:title, :subtitle, :cta_label, :cta_url)
    end
  end
end
