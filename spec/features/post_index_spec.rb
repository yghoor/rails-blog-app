require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                        password_confirmation: 'password')
    @post1 = Post.create(author: @user, title: 'post1', text: 'post1 text')
    @post2 = Post.create(author: @user, title: 'post2', text: 'post2 text')
    @post3 = Post.create(author: @user, title: 'post3', text: 'post3 text')
    @post4 = Post.create(author: @user, title: 'post4', text: 'post4 text')

    visit user_posts_path(@user)
  end

  context 'user info: ' do
    it 'displays the user\'s profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'#{@user.photo_url}')]")
    end

    it 'displays the user\'s name' do
      expect(page).to have_content('user')
    end

    it 'displays number of posts for the user' do
      expect(page).to have_content('Number of posts: 4')
    end
  end

  # rubocop:disable Metrics/BlockLength
  context 'details of posts: ' do
    it 'displays post titles' do
      expect(page).to have_content('post4')
      expect(page).to have_content('post3')
    end

    it 'displays post texts' do
      expect(page).to have_content('post4 text')
      expect(page).to have_content('post3 text')
    end

    it 'displays post\'s 5 most recent comments' do
      @post4.comments.create(author: @user, text: 'comment1')
      @post4.comments.create(author: @user, text: 'comment2')
      @post4.comments.create(author: @user, text: 'comment3')
      @post4.comments.create(author: @user, text: 'comment4')
      @post4.comments.create(author: @user, text: 'comment5')
      @post4.comments.create(author: @user, text: 'comment6')
      visit user_posts_path(@user)

      expect(page).to have_content('comment6')
      expect(page).to have_content('comment5')
      expect(page).to have_content('comment4')
      expect(page).to have_content('comment3')
      expect(page).to have_content('comment2')
    end

    it 'displays number of comments for the posts' do
      expect(page).to have_content('Comments: 0', count: 2)
    end

    it 'displays number of likes for the posts' do
      expect(page).to have_content('Likes: 0', count: 2)
    end

    it 'links to the post\'s show page when a post is clicked' do
      click_link('post4')
      expect(page).to have_current_path(user_post_path(@user, @post4))
    end
  end
  # rubocop:enable Metrics/BlockLength

  context 'pagination of posts: ' do
    it 'displays 2 posts per page' do
      expect(page).to have_content('post4')
      expect(page).to have_content('post3')
      expect(page).not_to have_content('post2')
    end

    it 'displays a link to the next page' do
      expect(page).to have_link('Next Page')
    end

    it 'directs to the next page when \'Next Page\' is clicked' do
      click_link('Next Page')
      expect(page).to have_content('post2')
      expect(page).to have_content('post1')
      expect(page).not_to have_content('post3')
    end

    it 'displays a link to the previous page' do
      expect(page).to have_link('Previous Page')
    end

    it 'directs to the previous page when \'Previous Page\' is clicked' do
      click_link('Next Page')
      click_link('Previous Page')
      expect(page).to have_content('post4')
      expect(page).to have_content('post3')
      expect(page).not_to have_content('post2')
    end
  end
end
