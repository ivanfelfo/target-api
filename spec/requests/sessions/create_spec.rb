# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'POST /v1/users/sign_in', type: :request do
  subject do
    post v1_user_session_path, params: params, as: :json
    response
  end
  let(:params) { { user: { email: 'mail@mail.com', password: 'hello123' } } }

  context 'when user already exists' do
    let!(:created_user) { User.create!(email: 'mail@mail.com', password: 'hello123') }

    context 'when password matches' do
      it 'responds with code 200' do
        expect(subject).to have_http_status(201)
      end

      it 'returns user email' do
        expect(JSON.parse(subject.body)['email']).to eq(created_user.email)
      end
    end

    context 'when password does not match' do
      let(:params) { { user: { email: 'mail@mail.com', password: 'x' } } }

      it 'responds with code 401' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'when leaving a blank parameter' do
      let(:params) { { user: { email: 'mail@mail.com', password: '' } } }

      it 'responds with code 401' do
        expect(subject).to have_http_status(401)
      end
    end
  end

  context 'when user does not exist' do
    let(:params) { { user: { email: 'user_non_existent@mail.com', password: 'x' } } }

    it 'responds with code 401' do
      expect(subject).to have_http_status(401)
    end
  end
end
