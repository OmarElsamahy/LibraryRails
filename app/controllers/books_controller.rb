class BooksController < ApplicationController
    def index
        @books = Book.all.page(params[:page]).per(params[:per])
        render json: BookSerializer.new(@books).serializable_hash.to_json
    end
end
