# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /v1/users', type: :request do
  subject { post v1_user_registration_path, params: params, as: :json }
  let(:params) { { user: { email: 'mail@mail.com', password: 'hello123', gender: :male } } }

  context 'when valid' do
    it 'creates a user in db' do
      subject
      user = User.last
      expect(user.email).to eq('mail@mail.com')
      expect(user.gender).to eq('male')
    end

    it 'responds with 200' do
      subject
      expect(response).to have_http_status(201)
    end

    it 'will change the user count by 1' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'sends email confirmation' do
      expect { subject }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    context 'when creating a female user' do
      let(:params) { { user: { email: 'mail@mail.com', password: 'hello123', gender: :female } } }

      it 'will save female user in db' do
        subject
        female_user = User.last
        expect(female_user.gender).to eq('female')
      end
    end

    context 'when creating a user passing a blank gender' do
      let(:params) { { user: { email: 'mail@mail.com', password: 'hello123' } } }

      it 'will create a user with an unknown gender' do
        subject
        unknown_gender_user = User.last
        expect(unknown_gender_user.gender).to eq('unknown')
      end
    end
  end

  context 'when not valid' do
    context 'when trying to register a user with an email that already exists' do
      let!(:created_user) do
        User.create(email: 'mail@mail.com', password: 'hello123', gender: :male)
      end

      it 'responds with 400' do
        subject
        expect(response).to have_http_status(400)
      end

      it 'will NOT change the user count' do
        expect { subject }.not_to change(User, :count)
      end
    end

    context 'when creating a user passing random value gender' do
      let(:params) { { user: { email: 'mail@mail.com', password: 'hello123', gender: 'x' } } }

      it 'will NOT create a user' do
        expect { subject }.to raise_error(ArgumentError, /'x' is not a valid gender/)
      end
    end
  end
end
