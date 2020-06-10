# frozen_string_literal: true

class TutorsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_tutor, only: [:show]

  def create
    @tutor = Tutor.create!(tutor_params)
  end

  def index
    @tutors = Tutor.all
    json_response(@tutors)
  end

  def show
    json_response(@tutor)
  end

  private

  def tutor_params
    params.require(:tutor).permit(:email, :name, :subject, :about, :img, :rate, :experience)
  end

  def set_tutor
    @tutor = Tutor.find(params[:id])
  end
end
