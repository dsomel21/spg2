# frozen_string_literal: true

json.key_format! :camelize => :lower

json.chapter do
  # :chapter => {:id, :number, :title, :en_title, :en_short_summary, :en_short_summary, :artwork_url}
  json.call(@chapter, *Chapter.READABLE_ATTRIBUTES)

  json.book(@chapter.book, *Book.READABLE_ATTRIBUTES)

  # Samapti

  # :chhands => {:id, :sequence, :vaak}
  json.chhands @chapter.chhands.order(:sequence => :ASC) do |chhand|
    json.call(chhand, *Chhand.READABLE_ATTRIBUTES)
    json.name(chhand.chhand_type.name)

    # :pauris => {:id, :number}
    json.pauris chhand.pauris.order(:number => :ASC) do |pauri|
      json.call(pauri, *Pauri.READABLE_ATTRIBUTES)

      # :pauri_translation => {:en_translation, :en_translator} || NULL
      json.translation do
        pauri.translation.nil? ? json.null! : json.call(pauri.translation, *PauriTranslation.READABLE_ATTRIBUTES)
      end

      # pauri_footnote: {:bhai_vir_singh_footnote, :contentful_entry_id} || NULL
      json.footnote do
        pauri.footnote.nil? ? json.null! : json.call(pauri.footnote, *PauriFootnote.READABLE_ATTRIBUTES)
      end

      # :tuks => [{:id, :sequence, :content, :original_content}]
      json.tuks pauri.tuks.order(:sequence => :ASC) do |tuk|
        json.call(tuk, *Tuk.READABLE_ATTRIBUTES)

        # :tuk_translation => {:en_translation, :en_translator} || NULL
        json.translation do
          tuk.translation.nil? ? json.null! : json.call(tuk.translation, *TukTranslation.READABLE_ATTRIBUTES)
        end

        # :tuk_footnote => {:bhai_vir_singh_footnote, :contentful_entry_id} || NULL
        json.footnote do
          tuk.footnote.nil? ? json.null! : json.call(tuk.footnote, *TukFootnote.READABLE_ATTRIBUTES)
        end
      end
    end
  end
end
