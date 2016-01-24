require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  before { @book = user.books.build(title: "Lorem ipsum", content: "Lorem ipsum") }

  subject { @book }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:user) }

  context "when title is not present" do
    before { @book.title = '' }
    it { is_expected.to_not be_valid }
  end

  context "with blank content" do
    before { @book.content = '' }
    it { is_expected.to_not be_valid }
  end

  context "with blank content" do
    before { @book.user = nil }
    it { is_expected.to_not be_valid }
  end
end