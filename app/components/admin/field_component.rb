# frozen_string_literal: true

# A labeled Bootstrap form field for admin forms. Wraps a Rails form builder field
# (text_field / text_area / number_field / check_box) so the admin forms stay DRY.
class Admin::FieldComponent < ApplicationComponent
  def initialize(form:, attribute:, as: :text_field, label: nil, **options)
    @form = form
    @attribute = attribute
    @as = as
    @label = label
    @options = options
  end

  private

  attr_reader :form, :attribute, :as, :label, :options

  def label_text
    label || attribute.to_s.humanize
  end
end
