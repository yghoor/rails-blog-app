require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Validations' do
    subject { Post.new(title: 'Title', text: 'Text') }

    before do
      subject.save
      subject.author = User.create(name: 'John', photo_url: 'photo_url', bio: 'This is my bio')
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a long title' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative comments counter' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative likes counter' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  context 'after save' do
    it 'increments the author posts counter' do
      user = User.create(name: 'John', photo_url: 'photo_url', bio: 'This is my bio')
      Post.create(title: 'Title', text: 'Text', author: user)
      expect(user.posts_counter).to eq(1)
    end
  end

end
