# frozen_string_literal: true

json.key_format! :camelize => :lower

json.book do
  json.call(@book, *Book.READABLE_ATTRIBUTES)
end
