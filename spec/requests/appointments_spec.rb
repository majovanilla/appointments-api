# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Appointments API' do
  let!(:tutor) { create(:tutor) }
  let!(:appointment) { create_list(:appointment, 5, tutor_id: tutor.id) }
  let(:tutor_id) { tutor.id }
  let(:id) { appointment.first.id }

  describe 'GET /tutors/:tutor_id/appointments' do
    before { get "/tutors/#{tutor_id}/appointments" }

    context 'when tutor exists' do
      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tutors\' appointments' do
        expect(json.size).to eq(5)
      end
    end

    context 'when tutor does not exist' do
      let(:tutor_id) { 0 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tutor/)
      end
    end
  end

  describe 'GET /tutors/:tutor_id/appointments/:id' do
    before { get "/tutors/#{tutor_id}/appointments/#{id}" }

    context 'when appointment exists' do
      it 'returns a status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the appointment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when appointment does not exist' do
      let(:id) { 45 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  describe 'PUT tutors/:tutor_id/appointments' do
    let(:date) { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    let(:location) { Faker::Lorem.word }
    let(:valid_attributes) { { date: date, location: location } }

    context 'when request attributes are valid' do
      before { post "/tutors/#{tutor_id}/appointments", params: valid_attributes }

      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/tutors/#{tutor_id}/appointments", params: {} }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Date can't be blank, Location can't be blank/)
      end
    end
  end

  describe 'PUT /tutors/:tutor_id/appointments/:id' do
    let(:location) { 'Nuevo Mexico' }
    let(:valid_attributes) { { location: location } }

    before { put "/tutors/#{tutor_id}/appointments/#{id}", params: valid_attributes }

    context 'when appointment exists' do
      it 'returns status 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the appointment' do
        updated_appointment = Appointment.find(id)
        expect(updated_appointment.location).to match(/Nuevo Mexico/)
      end
    end

    context 'when the appointment does not exist' do
      let(:id) { 45 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  describe 'DELETE /tutors/:tutor_id/appointments/:id' do
    before { delete "/tutors/#{tutor_id}/appointments/#{id}" }

    it 'returns status 204' do
      expect(response).to have_http_status(204)
    end
  end
end
