# frozen_string_literal: true

class TukFootnote < ApplicationRecord
  belongs_to :tuk

  def self.READABLE_ATTRIBUTES
    return [:bhai_vir_singh_footnote, :contentful_entry_id]
  end
end
