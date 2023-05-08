# frozen_string_literal: true

json.key_format! :camelize => :lower

json.chapter do
  json.call(@chapter, *Chapter.READABLE_ATTRIBUTES)
end
