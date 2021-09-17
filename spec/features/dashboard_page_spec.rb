require 'rails_helper'

feature 'dashboard page' do
  scenario 'redirect to Log-in' do
    visit('/')
    expect(page).to have_content('Log-in') 
  end
end