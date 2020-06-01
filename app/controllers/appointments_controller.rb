# frozen_string_literal: true

class AppointmentsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_tutor
  before_action :set_tutor_appointment, only: %i[show update destroy]

  def index
    json_response(@tutor.appointments)
  end

  def show
    json_response(@appointment)
  end

  def create
    @tutor.appointments.create!(appointment_params)
    json_response(@tutor.appointments, :created)
  end

  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def set_tutor
    @tutor = Tutor.find(params[:tutor_id])
  end

  def set_tutor_appointment
    @appointment = @tutor.appointments.find_by!(id: params[:id]) if @tutor
  end

  def appointment_params
    params.permit(:date, :location, :canceled)
  end
end
