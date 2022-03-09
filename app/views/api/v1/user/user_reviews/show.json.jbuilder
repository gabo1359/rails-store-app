json.extract! @user_review, :id, :title, :content, :approved

json.for_user do
  json.id @user_review.for_user.id
  json.first_name @user_review.for_user.first_name
  json.last_name @user_review.for_user.last_name
  json.email @user_review.for_user.email
end

json.by_user do
  json.id @user_review.by_user.id
  json.first_name @user_review.by_user.first_name
  json.last_name @user_review.by_user.last_name
  json.email @user_review.by_user.email
end