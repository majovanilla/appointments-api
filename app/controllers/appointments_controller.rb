class AppointmentsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_appointment, only: %i[show update destroy]

  def index
    json_response(@current_user.appointments.ordered)
  end

  def show
    json_response(@appointment)
  end

  def create
    @current_user.appointments.create!(appointment_params)
    json_response(@current_user.appointments, :created)
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

  def set_appointment
    @appointment = @current_user.appointments.find_by!(id: params[:id]) if @current_user
  end

  def appointment_params
    params.permit(:date, :time, :location, :canceled, :tutor_id)
  end
end
