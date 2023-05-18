class ReviewSerializer < BaseSerializer
    attributes :rate , :comment , :reviewable_type , :reviewer_type
end
