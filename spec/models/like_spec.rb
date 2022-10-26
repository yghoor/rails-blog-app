require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'after save' do
    it 'increments its post\'s likes counter' do
      user = User.create(name: 'John', photo_url: 'photo_url', bio: 'This is my bio')
      post = Post.create(title: 'Title', text: 'Text', author: user)
      Like.create(post:, author: user)
      expect(post.likes_counter).to eq(1)
    end
  end
end
