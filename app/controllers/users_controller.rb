class UsersController < BaseController
    skip_before_action :authenticate_user , only: [:create]

    # def index
    #     successfully_borrowed_books = @current_user.books.includes(:borrow_requests).merge(BorrowRequest.successfully_accepted)
    #     render json: {
    #         UserSerializer.new(@current_user).serializable_hash.to_json ,
    #         BookSerializer.new(successfully_borrowed_books).serializable_hash.to_json
    #     }
    # end

    def show
        successfully_borrowed_books = @current_user.books.includes(:borrow_requests).merge(BorrowRequest.successfully_accepted)
        render json: {
            'User':UserSerializer.new(@current_user).serializable_hash.to_json ,
            'Book':BookSerializer.new(successfully_borrowed_books).serializable_hash.to_json
        }
    end

    def create
        ActiveRecord::Base.transaction do
            begin
                @user = User.new(user_params) 
                if @user.save!
                    render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
                else
                    render json: {"Error" => @user.errors.full_messages} , status: :internal_server_error
                end                    
            rescue
                render json: {"Error" => @user.errors.full_messages} , status: :internal_server_error
            end
        end
    end

    def destroy
        ActiveRecord::Base.transaction do
            begin
                @user.destroy
            rescue
                render json: {"Errors": @user.errors.full_messages}
            end
            render json: {"Message": "Successfully deleted"}
        end
    end

    private
    def user_params
        params.require(:user).permit(:email , :password)
    end


end
