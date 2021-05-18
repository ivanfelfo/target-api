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

  context 'when it a valid instance' do
    let(:new_target) { build(:target) }
    subject { new_target.save! }

    it 'saves correctly' do
      expect(subject).to eq(true)
    end

    context 'when it doesn\'t have compatible targets' do
      context 'when it has the same user as the one created' do
        let!(:same_user) do
          create(:target, user: new_target.user, topic: new_target.topic,
                          latitude: new_target.latitude,
                          longitude: new_target.longitude, radius: 300)
        end

        it 'doesn\'t send notification' do
          expect(OneSignal).not_to receive(:send_notification)
          subject
        end
      end

      context 'when it has different topic as the one created' do
        let!(:target_diff_topic) do
          create(:target,
                 latitude: new_target.latitude, longitude: new_target.longitude, radius: 300)
        end

        it 'doesn\'t send notification' do
          expect(OneSignal).not_to receive(:send_notification)
          subject
        end
      end

      context 'when its radius is not containing another target radius' do
        let(:new_target) { build(:target, latitude: 90, longitude: 180, radius: 1) }
        let!(:not_contain) do
          create(:target, topic: new_target.topic,
                          latitude: -90, longitude: 180, radius: 1)
        end

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

      it 'enque a job sends notification' do
        expect { subject }.to have_enqueued_job
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
