# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /v1/users', type: :request do
  let(:params) { { user: { email: 'mail@mail.com', password: 'hello123', gender: true } } }
  it 'saves user in db' do
    post v1_user_registration_path, params: params, as: :json
    user = User.last
    expect(user.email).to eq('mail@mail.com')
    expect(user.gender).to eq(true)
  end

  context 'when trying to register a user with an email that already exists' do
    let!(:created_user) { User.create(email: 'mail@mail.com', password: 'hello123', gender: true) }

    it 'does not create a new user' do
      post v1_user_registration_path, params: params, as: :json
      expect(User.count).to eq(1)
    end
  end
end
