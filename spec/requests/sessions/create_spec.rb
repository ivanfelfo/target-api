# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'POST /v1/users/sign_in', type: :request do
  subject { post v1_user_session_path, params: params, as: :json }
  let(:params) { { user: { email: 'mail@mail.com', password: 'hello123' } } }

  context 'when user is found at db' do
    let!(:created_user) { User.create!(email: 'mail@mail.com', password: 'hello123') }

    context 'when password matches' do
      it 'returns code 200' do
        subject
        expect(response).to have_http_status(201)
      end

      it 'returns user email' do
        subject
        expect(JSON.parse(response.body)['email']).to eq(created_user.email)
      end
    end

    context 'when password does not match' do
      let(:params) { { user: { email: 'mail@mail.com', password: 'x' } } }

      it 'returns code 401' do
        subject
        expect(response).to have_http_status(401)
      end
    end
  end

  context 'when user is not in db' do
    let(:params) { { user: { email: 'user_non_existent@mail.com', password: 'x' } } }

    it 'returns code 401' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
