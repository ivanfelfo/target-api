describe User, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:encrypted_password) }
  end

  it 'works with enum' do
    is_expected.to define_enum_for(:gender)
      .with_values(male: 0, female: 1, other: 2, unknown: 3)
      .backed_by_column_of_type(:integer)
  end

  it 'has many targets dependent destroy' do
    is_expected.to have_many(:targets).dependent(:destroy)
  end
end
