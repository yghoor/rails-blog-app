require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                        password_confirmation: 'password')
    @post1 = Post.create(author: @user, title: 'post1', text: 'post1 text')
    @post2 = Post.create(author: @user, title: 'post2', text: 'post2 text')
    @post3 = Post.create(author: @user, title: 'post3', text: 'post3 text')
    @post4 = Post.create(author: @user, title: 'post4', text: 'post4 text')

    visit user_path(@user)
  end

  it 'displays the user\'s profile picture' do
    expect(page).to have_xpath("//img[contains(@src,'#{@user.photo_url}')]")
  end

  it 'displays the user\'s name' do
    expect(page).to have_content('user')
  end

  it 'displays number of posts for the user' do
    expect(page).to have_content('Number of posts: 4')
  end

  it 'displays the user\'s bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'displays a button to view all posts' do
    expect(page).to have_button('See all Posts')
  end

  context 'user posts: ' do
    it 'displays the user\'s 3 recent posts' do
      expect(page).to have_content('post4')
      expect(page).to have_content('post3')
      expect(page).to have_content('post2')
      expect(page).not_to have_content('post1')
    end

    it 'links to the post\'s show page when a post is clicked' do
      click_link('post4')
      expect(page).to have_current_path(user_post_path(@user, @post4))
    end

    it 'links to the user\'s posts index page when \'See all posts\' is clicked' do
      click_button('See all Posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
