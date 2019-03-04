require 'rails_helper'

feature 'session' do
  let(:user) { FactoryBot.create(:user)}
  scenario 'signing in successfully' do
    visit('/')
    click_link('Log in')
    fill_in "user[login]", with: user.login
    fill_in "user[password]", with: user.password
    click_button('Sign in')
    expect(user).to eq(user)
  end
end
