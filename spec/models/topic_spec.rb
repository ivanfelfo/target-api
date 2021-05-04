describe Topic, type: :model do
  context 'when is a valid instance' do
    subject { build(:topic) }

    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end

  it 'has many targets dependent destroy' do
    is_expected.to have_many(:targets).dependent(:destroy)
  end
end
