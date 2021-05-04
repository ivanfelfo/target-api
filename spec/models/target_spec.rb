require 'rails_helper'

RSpec.describe Target, type: :model do
  context 'when is a valid instance' do
    subject { build(:target) }

    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end
end
