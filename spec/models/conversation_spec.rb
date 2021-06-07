describe Conversation, type: :model do
  let(:new_conversation) { build(:conversation) }
  subject { new_conversation.save! }

  context 'when it\'s a valid instance' do
    it 'saves the record' do
      expect(subject).to eq(true)
    end
  end

  context "when it\'s NOT a valid instance" do
    context 'when trying to create a conversation with the same person' do
      let(:new_conversation) { build(:conversation, user_id1: 1, user_id2: 1) }

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
