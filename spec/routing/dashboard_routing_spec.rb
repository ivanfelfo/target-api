require 'rails_helper'

RSpec.describe 'routes for Dashboards', type: :routing do
  it 'routes /v1/dashboards to the index action' do
    expect(get('/v1/dashboards')).to route_to('v1/dashboards#index')
  end
end
