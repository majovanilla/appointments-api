# frozen_string_literal: true

class HomeController < ApplicationController
  include Response
  include ExceptionHandler

  skip_before_action :authorize_request, only: :index

  def index; end
end
