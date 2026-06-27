# frozen_string_literal: true

# Preview at /rails/view_components/seo/course_schema_component (renders a script tag)
class Seo::CourseSchemaComponentPreview < ViewComponent::Preview
  def default
    render(Seo::CourseSchemaComponent.new(url: "https://example.com/"))
  end
end
