# frozen_string_literal: true

json.chapter do
  # @chapter
  json.call(@chapter, *Chapter.READABLE_ATTRIBUTES)

  # Samapti

  # chhands
  json.chhands @chapter.chhands.order(:sequence => :ASC) do |chhand|
    json.call(chhand, *Chhand.READABLE_ATTRIBUTES)
    json.name(chhand.chhand_type.name)

    # pauris
    json.pauris chhand.pauris.order(:number => :ASC) do |pauri|
      json.call(pauri, *Pauri.READABLE_ATTRIBUTES)
      # tuks
      json.tuks pauri.tuks.order(:sequence => :ASC) do |tuk|
        json.call(tuk, *Tuk.READABLE_ATTRIBUTES)
      end
    end
  end
end
