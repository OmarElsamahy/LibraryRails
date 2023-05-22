class BorrowRequestsController < BaseController

    def index
        borrow_requests = @current_user.borrow_requests
        render json: BorrowRequestSerializer.new(borrow_requests).serializable_hash.to_json        
    end

    def show
        borrow_request = @current_user.borrow_requests.find(params[:id])
        render json: BorrowRequestSerializer.new(borrow_request).serializable_hash.to_json
    end

    def create
        ActiveRecord::Base.transaction do
            begin
                borrow_request = @current_user.borrow_requests.create(borrow_params)
                render json: BorrowRequestSerializer.new(borrow_request).serializable_hash.to_json
            rescue => e 
                render json: {errors: e}
            end
        end
    end

    def return
        ActiveRecord::Base.transaction do
            begin
                borrow_request =  @current_user.borrow_requests.find_by(book_id: params[:book_id],status: 'accepted')
                borrow_request.returned!
                render json: BorrowRequestSerializer.new(borrow_request).serializable_hash.to_json
            rescue => e 
                render json: {errors: e}
            end
        end
    end

    def destroy
        ActiveRecord::Base.transaction do
            begin
                borrow_request = @current_user.borrow_requests.find(params[:id])
                borrow_request.destroy
                render json: {"Message": "Successfully deleted"}
            rescue => e 
                render json: {errors: e}
            end
        end
    end

    private
    def borrow_params
        params.require(:borrow_request).permit(:issue_date , :return_due_date , :book_id)
    end
end
