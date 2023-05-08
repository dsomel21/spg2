# frozen_string_literal: true

class ChaptersController < ApplicationController
  # book_chapters GET /books/:book_id/chapters(.:format)
  def index
    @chapters = Book.find_by(:id => params[:book_id]).chapters
  end

  # chapter GET /chapters/:id(.:format)
  def show
    @chapter = Chapter.find_by(:id => params[:id])
  end

  # chapter GET /chapters/:id/content.json
  def content
    @chapter = Chapter.find_by(:id => params[:id])
  end
end
