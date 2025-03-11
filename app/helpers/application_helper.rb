module ApplicationHelper
  def form_errors(object, attr)
    return unless object.errors[attr].any?

    safe_join(
      object.errors.full_messages_for(attr).map do |e|
        content_tag(:span, e, class: "text-red-500 text-xs block")
      end
    )
  end
end
