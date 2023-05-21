class BooksController < ApplicationController
    def index
        begin
            @books = Book.where(@query_string, shelf_id: @shelf_id)
            render json: BookSerializer.new(@books).serializable_hash.to_json
        rescue => e
            render json: {Erros: e}
        end
    end

    def build_filter_params
        @shelf_id = params[:shelf_id].to_s if params[:shelf_id].present?
    end

    def build_query_string
        @query_string = ""
        filter_by_shelf if @shelf_id.present?
    end

    def filter_by_shelf
        query = "books.shelf_id = :shelf_id"
        unless @query_string.empty?
            query = " AND " + query
        end
        @query_string += query
    end
end
