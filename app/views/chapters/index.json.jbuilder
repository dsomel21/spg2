# frozen_string_literal: true

json.key_format! :camelize => :lower

json.chapters do
  json.array!(@chapters, *Chapter.READABLE_ATTRIBUTES)
end
