require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Checks unregistred user', type: :system do
  before :each do
    @locale = :en
    I18n.locale = :ru
  end
  def to_path(path)
    visit path
    expect(current_path).not_to eq path
  end
  scenario 'He can do nothing' do
    i = 0
    j = 0
    k = 0
    [i, j, k].map { |_| rand(100) }

    paths = ["/users/#{i}", "/users/#{i}/writings/#{j}", "/users/#{i}/writings/#{j}/pages/#{k}"]
    paths.each do |path|
      to_path path
    end
  end


  scenario 'Unreg can do smth btw' do
    expect { visit root_path }.not_to raise_error
    expect { visit session_login_path }.not_to raise_error
    find('#search').click

    fill_in :rate, with: 5
    find('#submit-btn').click
    sleep(0.5)

    expect(find('#result').text).to have_text(I18n.t('forms.search.nothing'))
    sleep(0.5)
    fill_in :rate, with: 0
    find('#submit-btn').click
    sleep(1)
    expect(find('#result').text).not_to have_text(I18n.t('forms.search.nothing'))

    find('#radio_writing').click

    find('#submit-btn').click
    sleep(1)
    expect(find('#result').text).not_to have_text(I18n.t('forms.search.nothing'))

    fill_in :age_limit, with: 18
    find('#submit-btn').click
    sleep(0.5)

    expect(find('#result').text).to have_text(I18n.t('forms.search.nothing'))
  end
end
