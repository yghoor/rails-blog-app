require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before :each do
    @user1 = User.create(name: 'user1', email: 'user1@example.com', password: 'password',
                         password_confirmation: 'password')
    @user2 = User.create(name: 'user2', email: 'user2@example.com', password: 'password',
                         password_confirmation: 'password')

    @post = Post.create(author: @user1, title: 'post', text: 'post text')

    @post.comments.create(author: @user2, text: 'comment1')
    @post.comments.create(author: @user2, text: 'comment2')
    @post.comments.create(author: @user2, text: 'comment3')
    @post.comments.create(author: @user2, text: 'comment4')
    @post.comments.create(author: @user2, text: 'comment5')
    @post.comments.create(author: @user2, text: 'comment6')

    visit user_post_path(@user1, @post)
  end

  context 'details of post: ' do
    it 'displays the post title' do
      expect(page).to have_content('post')
    end

    it 'displays the post author' do
      expect(page).to have_content('user1')
    end

    it 'displays number of comments for the posts' do
      expect(page).to have_content('Comments: 6')
    end

    it 'displays number of likes for the posts' do
      expect(page).to have_content('Likes: 0')
    end

    it 'displays the post text' do
      expect(page).to have_content('post text')
    end

    it 'displays usernames of commentors' do
      expect(page).to have_content('user2', count: 6)
    end

    it 'displays the comment text' do
      expect(page).to have_content('comment1')
      expect(page).to have_content('comment2')
      expect(page).to have_content('comment3')
      expect(page).to have_content('comment4')
      expect(page).to have_content('comment5')
      expect(page).to have_content('comment6')
    end
  end
end
