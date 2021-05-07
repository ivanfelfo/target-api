describe 'routes for Topics', type: :routing do
  it 'routes GET /v1/topics to the INDEX action' do
    expect(get('/v1/topics')).to route_to('v1/topics#index')
  end
end
