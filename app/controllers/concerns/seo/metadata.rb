# frozen_string_literal: true

module Seo
  # Per-page SEO metadata. Controllers call `set_meta(...)` to override the Site
  # defaults; the layout passes `seo_meta` into Seo::MetaComponent. Namespaced
  # under Seo:: alongside the component for future engine extraction.
  module Metadata
    extend ActiveSupport::Concern

    included do
      helper_method :seo_meta
    end

    private

    # Override page metadata, e.g. `set_meta title: "About", description: "..."`.
    def set_meta(**attrs)
      @seo_meta = seo_meta.merge(attrs.compact)
    end

    def seo_meta
      @seo_meta ||= {}
    end
  end
end
