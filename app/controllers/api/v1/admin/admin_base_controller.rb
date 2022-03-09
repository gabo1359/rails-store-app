class Api::V1::Admin::AdminBaseController < Api::V1::BaseController
  before_action :ensure_admin!

  private

  def ensure_admin!
    unless current_user.admin
      raise CustomError.new('Authorization error', :unauthorized, "You're not an admin")
    end
  end
end
