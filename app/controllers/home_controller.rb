class HomeController < ApplicationController
  include Response
  include ExceptionHandler

  skip_before_action :authorize_request, only: :index

  def index
    render json: { status: 'it\'s working' }
  end
end
