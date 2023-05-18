class BorrowRequestSerializer < BaseSerializer
  attributes :issue_date , :return_due_date , :returned , :status
end
