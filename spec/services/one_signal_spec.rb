describe OneSignalService do
  subject { described_class.new(user).call }
  context 'when the user is compatible' do
    let!(:user) { create(:user) }

    it 'calls method send_notification' do
      expect(OneSignal).to receive(:send_notification) do |arg|
        expect(arg.class.name).to eq('OneSignal::Notification')
      end
      subject
    end

    it 'calls the send_notification method with the user email' do
      expect(OneSignal).to receive(:send_notification) do |arg|
        expect(arg.included_targets.include_email_tokens).to eq([user.email])
      end
      subject
    end

    it 'calls the send_notification method with contents' do
      expect(OneSignal).to receive(:send_notification) do |arg|
        expect(arg.contents.en).to eq("I'm a notification")
      end
      subject
    end

    it 'calls the send_notification method with headings' do
      expect(OneSignal).to receive(:send_notification) do |arg|
        expect(arg.headings.en).to eq('Hello!')
      end
      subject
    end
  end
end
