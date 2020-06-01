# frozen_string_literal: true

require_relative '../rails_helper'

RSpec.describe 'Tutors API', type: :request do
  let!(:tutors) { create_list(:tutor, 5) }
  let(:tutor_id) { tutors.first.id }

  describe 'GET /tutors' do
    before { get '/tutors' }

    it 'returns tutors' do
      expect(json).not_to be_empty
    end

    it 'returns 5 tutors' do
      expect(json.size).to eq(5)
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET (tutors/:id' do
    before { get "/tutors(#{tutor_id}" }

    context 'when the tutor does not exist' do
      let(:tutor_id) { 45 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response).to match(/The tutor doesn't exist/)
      end
    end
  end
end
