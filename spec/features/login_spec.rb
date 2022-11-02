require 'rails_helper'

RSpec.describe 'Sign-in process', type: :feature do
  before :each do
    @user = User.create(name: 'user1', email: 'user1@example.com', password: 'password',
                        password_confirmation: 'password')
    @user.skip_confirmation!
    @user.save
    visit new_user_session_path
  end

  it 'displays form to sign in' do
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  it 'displays an error message when user enters nothing and tries to login' do
    click_button 'Log in'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it 'displays an error message when user enters incorrect data and tries to login' do
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'logs in user when user enters correct data and tries to login' do
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    sleep(5)
    expect(page).to have_content('Logged in as user1@example.com')
    expect(page).to have_current_path(root_path)
  end
end
