# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Appointments API' do
  let(:user) { create(:user) }
  let!(:tutor) { create(:tutor) }
  let(:tutor_id) { tutor.id }
  let(:headers) { valid_headers }

  describe 'GET /tutors/:tutor_id' do
    before { get "/tutors/#{tutor_id}", params: {}, headers: headers }

    context 'when tutor exists' do
      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tutors\' details as json' do
        tutor_json = JSON.parse(response.body)
        expect(tutor_json.length).to eq(7)
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
end
