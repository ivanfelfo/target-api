describe Target, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:radius) }
  end
  context 'when is a valid instance' do
    subject { build(:target) }

    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :topic }
end
