module BooksHelper

    def build_filter_params
        @shelf_id = params[:shelf_id].to_s if params[:shelf_id].present?
        @categories = params[:categories].to_a if params[:categories].present?
    end

    def build_query_string
        @query_string = ""
        filter_by_shelf if @shelf_id.present?
        filter_by_categories if @categories.present?
    end

    def filter_by_shelf
        query = "books.shelf_id = :shelf_id"
        unless @query_string.empty?
            query = " AND " + query
        end
        @query_string += query
    end
    def filter_by_categories
        categories_conditions = @categories.map { |category| "book_categories.book_id IN (SELECT id FROM books WHERE id = book_categories.book_id AND id IN (SELECT book_id FROM book_categories WHERE category_id IN (SELECT translatable_id FROM mobility_string_translations WHERE translatable_type = 'Category' AND key = 'name' AND value ILIKE :category)))" }
        query = "(" + categories_conditions.join(" OR ") + ")"        
        unless @query_string.empty?
          query = " AND " + query
        end
        @query_string += query
    end
end
