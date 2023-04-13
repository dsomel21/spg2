# frozen_string_literal: true

class PauriFootnote < ApplicationRecord
  belongs_to :pauri
  validates :contentful_entry_id, :uniqueness => true

  def self.READABLE_ATTRIBUTES
    return [:bhai_vir_singh_footnote, :contentful_entry_id]
  end
end
