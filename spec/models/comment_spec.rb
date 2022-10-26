require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'after save' do
    it 'increments its post\'s comments counter' do
      user = User.create(name: 'John', photo_url: 'photo_url', bio: 'This is my bio')
      post = Post.create(title: 'Title', text: 'Text', author: user)
      Comment.create(text: 'Comment', post:, author: user)
      expect(post.comments_counter).to eq(1)
    end
  end
end
