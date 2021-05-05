describe 'routes for Targets', type: :routing do
  it 'routes POST /v1/targets to the CREATE action' do
    expect(post('/v1/targets')).to route_to('v1/targets#create')
  end

  it 'routes DELETE /v1/targets/1 to the DESTROY action' do
    expect(delete('/v1/targets/1')).to route_to(
      controller: 'v1/targets',
      action: 'destroy',
      id: '1'
    )
  end
end
