describe Conversation, type: :model do
  let(:new_conversation) { build(:conversation) }
  subject { new_conversation.save! }

  context 'when it\'s a valid instance' do
    it 'saves the record' do
      expect(subject).to eq(true)
    end
  end

  context 'when is NOT a valid instance' do
    context 'when trying to create a conversation with the same person' do
      let(:new_conversation) { build(:conversation, user_id1: 1, user_id2: 1) }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        # "Validation failed: User id1 can'\t create a conversation with yourself")
      end
    end
  end
end
