class BooksController < ApplicationController
    include BooksHelper

    def index
        begin
            build_filter_params
            build_query_string
            # render json: {query: @query_string}
            @books = Book.joins(book_categories: :category).where(@query_string, shelf_id: @shelf_id,category: @categories)
            render json: BookSerializer.new(@books).serializable_hash.to_json
        rescue => e
            render json: {errors: e}
        end
    end
end
