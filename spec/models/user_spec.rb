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

  context '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'John', photo_url: 'photo_url', bio: 'This is my bio')
      Post.create(title: 'Title 1', text: 'Text 1', author: user)
      post2 = Post.create(title: 'Title 2', text: 'Text 2', author: user)
      post3 = Post.create(title: 'Title 3', text: 'Text 3', author: user)
      post4 = Post.create(title: 'Title 4', text: 'Text 4', author: user)
      expect(user.recent_posts).to eq([post4, post3, post2])
    end
  end
end
