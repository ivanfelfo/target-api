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

  context 'try to exceed targets per user limit' do
    let(:user) { create(:user) }
    before { create_list(:target, 10, user: user) }

    it 'won\'t create a new target for that user' do
      target = build(:target, user: user)
      expect(target.save).to eq(false)
    end

    it 'returns error' do
      target = build(:target, user: user)
      expect { target.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'won\'t update target to be of that user' do
      target = create(:target)
      expect(target.update(user: user)).to eq(false)
    end
  end
end
