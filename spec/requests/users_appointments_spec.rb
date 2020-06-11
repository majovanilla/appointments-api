# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Appointments API' do
  let(:user) { create(:user) }
  let!(:tutor) { create(:tutor, rate: '$145/hr', experience: '5 years', img: 'http://image.com') }
  let!(:appointment) { create_list(:appointment, 5, tutor_id: tutor.id, user_id: user.id, location: 'Mexico city', date: Date.tomorrow, time: Time.zone.now) }
  let(:user_id) { user.id }
  let(:id) { appointment.first.id }
  let(:headers) { valid_headers }
  let(:no_auth) { valid_headers.except('Authorization') }

  describe 'GET /appointments' do
    context 'when user is logged in' do
      before { get '/appointments', params: {}, headers: headers }

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all users\' appointments' do
        expect(json.size).to eq(5)
      end
    end

    context 'when user is not logged in' do
      before { get '/appointments', params: {}, headers: no_auth }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Missing token/)
      end
    end
  end

  describe 'GET /appointments/:id' do
    before { get "/appointments/#{id}", params: {}, headers: headers }

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

  describe 'POST /appointments/new' do
    let(:date) { Time.zone.now }
    let(:time) { Time.zone.now }
    let(:location) { Faker::Lorem.word }
    let(:valid_attributes) { { date: date, time: time, location: location, tutor_id: tutor.id }.to_json }

    context 'when request attributes are valid' do
      before { post '/appointments/new', params: valid_attributes, headers: headers }

      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post '/appointments/new', params: {}, headers: headers }

      it 'returns status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Tutor must exist, Date can't be blank, Location can't be blank/)
      end
    end
  end

  describe 'PUT /appointments/:id' do
    let(:location) { 'Nuevo Mexico' }
    let(:valid_attributes) { { location: location, canceled: true }.to_json }

    before { put "/appointments/#{id}", params: valid_attributes, headers: headers }

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

  describe 'DELETE /appointments/:id' do
    before { delete "/appointments/#{id}", params: {}, headers: headers }

    it 'returns status 204' do
      expect(response).to have_http_status(204)
    end
  end
end
