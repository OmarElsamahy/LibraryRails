module BooksHelper

    def build_filter_params
        @keyword = params[:keyword]
        @shelf_id = params[:shelf_id].to_s if params[:shelf_id].present?
        @category_ids = params[:category_ids].to_a if params[:category_ids].present?
    end

    def build_query_string
        @query_string = ""
        filter_by_shelf if @shelf_id.present?
        filter_by_categories if @category_ids.present?
        @query_string = "books.id IS NOT NULL" if @query_string == ""
    end

    def filter_by_shelf
        query = "books.shelf_id = :shelf_id"
        unless @query_string.empty?
            query = " AND " + query
        end
        @query_string += query
    end
    def filter_by_categories

        # To search by category names
        # categories_conditions = @categories.map { |category| "book_categories.book_id IN (SELECT id FROM books WHERE id = book_categories.book_id AND id IN (SELECT book_id FROM book_categories WHERE category_id IN (SELECT translatable_id FROM mobility_string_translations WHERE translatable_type = 'Category' AND key = 'name' AND value ILIKE :category)))" }
        # query = "(" + categories_conditions.join(" OR ") + ")" 


        query = "book_categories.category_id IN (:category_ids)"

        unless @query_string.empty?
          query = " AND " + query
        end
        @query_string += query
    end
end
