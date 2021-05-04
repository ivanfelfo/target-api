describe Topic, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'when is a valid instance' do
    subject { build(:topic) }

    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> Several tests added

  it 'has many targets dependent destroy' do
    is_expected.to have_many(:targets).dependent(:destroy)
  end
<<<<<<< HEAD
=======
>>>>>>> Improvements based on PR comments
=======
>>>>>>> Several tests added
end
