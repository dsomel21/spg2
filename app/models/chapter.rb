# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :book
  has_many :chhands, :dependent => :destroy
  has_many :pauris, :dependent => :destroy
  has_many :tuks, :dependent => :destroy

  def self.READABLE_ATTRIBUTES
    return [:id, :number, :title, :en_title, :en_long_summary, :en_short_summary, :artwork_url]
  end
end
