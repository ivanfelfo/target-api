describe 'routes for Targets', type: :routing do
  it 'routes POST /v1/targets to the CREATE action' do
    expect(post('/v1/targets')).to route_to('v1/targets#create')
  end
end
