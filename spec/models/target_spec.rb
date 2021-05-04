describe Target, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:radius) }

    it { is_expected.to validate_numericality_of(:radius).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:latitude) }
    it { is_expected.to validate_numericality_of(:longitude) }

    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :topic }
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
