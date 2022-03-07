class UserPolicy < ApplicationPolicy
    def show?
      user.present?
    end
  
    def destroy?
      user.present?
    end
  end
  