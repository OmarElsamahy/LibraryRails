class BooksController < ApplicationController
    include BooksHelper

    def index
        begin
            build_filter_params
            if @keyword
                @books = Book.search_by_name(@keyword)
                puts (@books)
            else
                build_query_string
                @books = Book.left_joins(:book_categories).where(@query_string, shelf_id: @shelf_id,category_ids: @category_ids)
            end
            render json: BookSerializer.new(@books).serializable_hash.to_json
        rescue => e
            render json: {errors: e}
        end
    end
end
