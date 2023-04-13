# frozen_string_literal: true

class TukTranslation < ApplicationRecord
  belongs_to :tuk

  def self.READABLE_ATTRIBUTES
    return [:en_translation, :en_translator]
  end
end
