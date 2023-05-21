class ReviewsController < BaseController
    skip_before_action :authenticate_user ,only:[:index]

    def index
        begin
            @reviews = Review.all.page(params[:page]).per(params[:per])
            render json: BookSerializer.new(@books).serializable_hash.to_json
        rescue => e
            render json: {error: 'Not Found'}
        end 
    end

    def create
        ActiveRecord::Base.transaction do
            begin
                @review = @current_user.reviews.create(review_params)
                render json: ReviewSerializer.new(@review).serializable_hash.to_json
            rescue
                render json: {error: "Could not add review"} , status: :unprocessable_entity
            end
        end
    end
    def show
       begin
        @review = @current_user.reviews.find(params[:id])
        render json: ReviewSerializer.new(@review).serializable_hash.to_json
       rescue  => error
        render json: {Error: "Review not found" } , status: :unprocessable_entity
       end 
    end

    private

    def review_params
        params.require(:review).permit(:comment ,:rate , :reviewable_type,:reviewable_id)
    end
end
