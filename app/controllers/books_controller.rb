# frozen_string_literal: true

class BooksController < ApplicationController
  # GET /books
  def index
    @books = Book.all
    render :json => @books
  end

  # GET /books/:id
  def show
    @book = Book.find_by(params[:id])
  end
end
