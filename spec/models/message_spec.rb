describe Message, type: :model do
  let(:new_message) { build(:message) }
  subject { new_message.save! }

  context 'when it\'s a valid instance' do
    it 'saves the record' do
      expect(subject).to eq(true)
    end
  end
end
