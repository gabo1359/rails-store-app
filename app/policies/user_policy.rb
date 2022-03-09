class UserPolicy < ApplicationPolicy
    def show?
      true
    end

    def create?
      user.present?
    end

    def destroy?
      user.present?
    end
  end
  