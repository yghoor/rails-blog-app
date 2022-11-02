require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before :each do
    @user1 = User.create(name: 'user1', email: 'user1@example.com', password: 'password',
                         password_confirmation: 'password')
    @user2 = User.create(name: 'user2', email: 'user2@example.com', password: 'password',
                         password_confirmation: 'password')
    @user3 = User.create(name: 'user3', email: 'user3@example.com', password: 'password',
                         password_confirmation: 'password')
    visit users_path
  end

  it 'displays all usernames' do
    expect(page).to have_content('user1')
    expect(page).to have_content('user2')
    expect(page).to have_content('user3')
  end

  it 'loads each user\'s photo URLs from db' do
    expect(page).to have_xpath("//img[contains(@src,'#{@user1.photo_url}')]")
    expect(page).to have_xpath("//img[contains(@src,'#{@user2.photo_url}')]")
    expect(page).to have_xpath("//img[contains(@src,'#{@user3.photo_url}')]")
  end

  it 'displays default profile picture if it was not specified' do
    expect(page).to have_xpath(
      "//img[contains(@src,'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y')]", count: 3
    )
  end

  it 'displays number of posts for each user' do
    expect(page).to have_content('Number of posts: 0', count: 3)
  end

  it 'renders \'show\' page when a user is clicked' do
    click_link('user1')
    expect(page).to have_current_path(user_path(@user1))
  end
end
