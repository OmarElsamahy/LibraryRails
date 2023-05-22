ActiveAdmin.register BorrowRequest do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:issue_date, :return_due_date, :returned, :status, :user_id, :book_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs "Borrow Request Status Change" do
      f.input :status , as: :select, collection: BorrowRequest.statuses.keys
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :book
      row :issue_date
      row :return_due_date
      row :status
    end
  end
  
end
