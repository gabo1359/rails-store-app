json.extract! @user, :id, :first_name, :last_name, :email, :phone, :address

json.discard do
  json.state @user.discarded_at ? true : false
end