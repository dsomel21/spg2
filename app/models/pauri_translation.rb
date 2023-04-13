# frozen_string_literal: true

class PauriTranslation < ApplicationRecord
  belongs_to :pauri

  def self.READABLE_ATTRIBUTES
    return [:en_translation, :en_translator]
  end
end
