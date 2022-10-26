require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    subject { User.new(name: 'John', photo_url: 'photo_url', bio: 'This is my bio') }

    before { subject.save }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative posts counter' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end
end
