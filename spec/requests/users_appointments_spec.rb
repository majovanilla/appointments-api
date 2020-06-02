# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Appointments API' do
  let(:user) { create(:user) }
  let!(:tutor) { create(:tutor) }
  let!(:appointment) { create_list(:appointment, 5, tutor_id: tutor.id, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { appointment.first.id }
  let(:headers) { valid_headers }

  describe 'GET /users/:user_id/appointments' do
    before { get "/users/#{user_id}/appointments", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all users\' appointments' do
        expect(json.size).to eq(5)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'GET /users/:user_id/appointments/:id' do
    before { get "/users/#{user_id}/appointments/#{id}", params: {}, headers: headers }

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

  describe 'POST users/:user_id/appointments' do
    let(:date) { '2020-05-05 14:15:23' }
    let(:location) { Faker::Lorem.word }
    let(:valid_attributes) { { date: date, location: location }.to_json }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/appointments", params: valid_attributes, headers: headers }

      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/appointments", params: {}, headers: headers }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Date can't be blank, Location can't be blank/)
      end
    end
  end

  describe 'PUT /users/:user_id/appointments/:id' do
    let(:location) { 'Nuevo Mexico' }
    let(:valid_attributes) { { location: location, canceled: true }.to_json }

    before { put "/users/#{user_id}/appointments/#{id}", params: valid_attributes, headers: headers }

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

  describe 'DELETE /users/:user_id/appointments/:id' do
    before { delete "/users/#{user_id}/appointments/#{id}", params: {}, headers: headers }

    it 'returns status 204' do
      expect(response).to have_http_status(204)
    end
  end
end
