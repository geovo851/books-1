require 'rails_helper'

RSpec.describe User, type: :model do
  let(:role) { FactoryGirl.create(:role) }
  before do
    @user = User.new(name: "Ted Smith", email: "admin@example.com",
                     password: "password", password_confirmation: "password", role: role)
  end

  subject { @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:role) }

  context "when name is not present" do
    before { @user.name = '' }
    it { is_expected.to_not be_valid }
  end

  context "with blank email" do
    before { @user.email = '' }
    it { is_expected.to_not be_valid }
  end
end
