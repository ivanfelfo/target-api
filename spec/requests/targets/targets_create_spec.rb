# frozen_string_literal: true

require 'rails_helper'

describe 'POST v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  subject { post v1_targets_path, params: params, as: :json }

  context 'when user is logged in' do
    sign_in(:user)
    let(:params) do
      { target: { title: 'Burgers', latitude: 1, longitude: 1, radius: 2, topic_id: topic[:id] } }
    end

    it 'returns http success' do
      subject
      expect(response).to have_http_status(204)
    end
  end
end
