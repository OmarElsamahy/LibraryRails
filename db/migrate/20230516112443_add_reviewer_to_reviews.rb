class AddReviewerToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :reviewer, polymorphic: true, index: true
  end
end
