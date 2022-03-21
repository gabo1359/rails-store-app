module Representer::User
  class UserRepresenter < Representable::Decorator
    include Representable::JSON

    property :first_name
    property :last_name
    property :address
    property :phone
    property :email
    property :password
  end
end