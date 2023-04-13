# frozen_string_literal: true

##
# Note: We use Contentful to store our custom footnotes.
# |                          | Rails Model                           | Content Type ID |
# |--------------------------|---------------------------------------|-----------------|
# | Custom `pauri` footnotes | `PauriFootnote`.`contentful_entry_id` | `pauriFootnote` |
# | Custom `tuk` footnotes   | `TukFootnote`.`contentful_entry_id`   | Nothing yet     |
#
# Contentful `pauriFootnote.fields:`
# - `entryName`
# - `vidhiyaSaagarContent`
# - `vidhiyaSaagarMedia`
# - `kamalpreetSinghContent`
# - `kamalpreetSinghMedia`
# - `manglacharanContent`
# - `manglacharanMedia`
##
class ContentfulPauriImporter
  def initialize
    @client = Contentful::Client.new(
      :access_token => ENV.fetch('CMS_ACCESS_TOKEN', nil),
      :space => ENV.fetch('CMS_SPACE_ID', nil),
      :dynamic_entries => :auto,
      :raise_errors => true
    )
  end

  # Retrieves `pauriFootnote` entries from Contentful CMS and returns them as an array of Hashes.
  # @returns [Array<Hash>] An array of JSON objects with keys `:id` and `:entry_name` for each pauri footnote.
  # @example
  #   Returns an array of JSON objects like this:
  #   [{id: "6fy52qIYDK8EyisyaaBe4o", entry_name: "Book 1 Chapter 1 Pauri 13"}, {...}, {...}]
  #   @entries = ContentfulPauriImporter.new.entries
  def entries
    return @client.entries(:content_type => 'pauriFootnote').map { |e| { :id => e.id, :entry_name => e.entry_name } }
  end

  # ContentfulPauriImporter.new.latest_entries
  def latest_entries
    @entries = self.entries

    # Only import `contentful_entry_id` if it doesn't exist already.
    existing_ids = PauriFootnote.pluck(:contentful_entry_id)
    new_entries = @entries.reject { |e| existing_ids.include?(e[:id]) }
    return new_entries
  end

  # ContentfulPauriImporter.new.import_latest_entries
  def import_latest_entries
    new_entries = self.latest_entries
    new_entries.each do |e|
      metadata = self.extract_info(e[:entry_name])
      @book = Book.find_by(:sequence => metadata[:book_number])
      @chapter = @book.chapters.find_by(:number => metadata[:chapter_number])
      @pauri = @chapter.pauris.find_by(:number => metadata[:pauri_number])
      Rails.logger.debug { "@pauri: #{@pauri.inspect}" }
      @pauri.create_footnote!(:contentful_entry_id => e[:id])
    rescue ArgumentError => e
      Rails.logger.debug { "❌ Error: #{e.message}" }
    end
  end

  def extract_info(entry_name)
    regex = /book\s*(\d{1,2})\s*[-,]?\s*chapter\s*(\d{1,2})\s*[-,]?\s*pauri\s*(\d{1,3})/i
    match = regex.match(entry_name)

    raise ArgumentError, 'Invalid string format' unless match
    {
      :book_number => match[1].to_i,
      :chapter_number => match[2].to_i,
      :pauri_number => match[3].to_i
    }
  end
end
