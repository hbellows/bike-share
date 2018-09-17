require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :full_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of(:password).on(:create)}
    it { should validate_presence_of :role }
  end
  describe 'Relationships' do
    it { should have_many :orders }
  end
end
