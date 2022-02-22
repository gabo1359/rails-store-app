# frozen_string_literal: false

# Pages controller
class User::PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home; end
end
