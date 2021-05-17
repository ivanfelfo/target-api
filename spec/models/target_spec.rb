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
    let(:new_target) { build(:target) }
    subject { new_target.save! }

    it 'saves correctly' do
      expect(subject).to eq(true)
    end

    context 'when is doesn\'t have compatible targets' do
      context 'when is has the same user' do
        let!(:same_user) { create(:target, user: new_target.user) }

        it 'doesn\'t send notification' do
          expect(OneSignal).not_to receive(:send_notification)
          subject
        end
      end

      context 'when is has different topic' do
        let!(:diff_topic) { create(:target, longitude: 180, latitude: 90, radius: 1) }
        let(:new_target) { build(:target, longitude: -180, latitude: -90, radius: 1) }

        it 'doesn\'t send notification' do
          expect(OneSignal).not_to receive(:send_notification)
          subject
        end
      end

      context 'when its radius is not containing another target radius' do
        let!(:not_contain) { create(:target, latitude: 180, longitude: 90, radius: 1) }
        let(:new_target) { build(:target, latitude: -180, longitude: -90, radius: 1) }

        it 'doesn\'t send notification' do
          expect(OneSignal).not_to receive(:send_notification)
          subject
        end
      end
    end

    context 'when it has compatible targets' do
      let!(:compatible_target) do
        create(:target,
               topic: new_target.topic, longitude: new_target.longitude,
               latitude: new_target.latitude)
      end

      it 'sends notification' do
        expect(OneSignal).to receive(:send_notification) do |arg|
          expect(arg.class.name).to eq('OneSignal::Notification')
        end
        subject
      end
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
