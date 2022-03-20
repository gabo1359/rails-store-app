# frozen_string_literal: false

# Pages controller
class Users::PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home; end
end
