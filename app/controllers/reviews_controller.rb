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
                @review = @current_user.reviews.build(review_params)
                @review.save
                render json: ReviewSerializer.new(@review).serializable_hash.to_json
            rescue => e
                return render json: { error: @review.errors.full_messages.join(', ') }, status: :unprocessable_entity if @review.errors.present?
                
                render json: {errors: e} , status: :unprocessable_entity
            end
        end
    end
    def show
       begin
        @review = @current_user.reviews.find(params[:id])
        render json: ReviewSerializer.new(@review).serializable_hash.to_json
       rescue  => error
        render json: {errors: "Review not found" } , status: :unprocessable_entity
       end 
    end

    private

    def review_params
        params.require(:review).permit(:comment ,:rate , :reviewable_type , :reviewable_id)
    end
end
