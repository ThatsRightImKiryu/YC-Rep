# frozen_string_literal: false

# Интеграционные:
#   Зарег:
#     Проверка действий обычного пользователя: может искать, создавать и редактировать свои данные, чужие нет
#     Проверка действий админа: может  искать, создавать и редактировать все данные
#   Не зарег: ничего не может кроме поиска
# Модель: Проверка создания, поиска, валидации для каждой модели
#     Проверка изменения рейтинга при добавлении комментов
#   Не зарег: ничего не может кроме поиска
# Всего 31
require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Checks registred user', type: :system do
  before :each do
    @locale = :en
  end

  scenario 'Register, login, search, create, edit for average user' do
    visit new_user_path
    fill_in :user_username, with: 'Lololoshka'
    fill_in :user_password, with: 'ILoveMinecraft'
    fill_in :user_password_confirmation, with: 'ILoveMinecraft'
    fill_in :user_email, with: 'average@mail.minecraft'

    find('#submit-btn').click

    sleep(1)
    expect(current_path).not_to eq new_user_path

    visit session_login_path
    fill_in :username, with: 'Lololoshka'
    fill_in :password, with: 'ILoveMinecraft'
    find('#submit-btn').click

    sleep(0.5)
    expect(current_path).not_to eq session_login_path

    visit writings_search_path

    fill_in :search, with: ''
    find('#submit-btn').click
    sleep(0.5)

    expect(find('#result').text).not_to have_text(I18n.t('forms.search.nothing'))

    fill_in :search, with: ('a'..'z').to_a.sample(4).join
    find('#submit-btn').click
    sleep(0.5)

    expect(find('#result').text).to have_text(I18n.t('forms.search.nothing'))

    find('#writings-link').click
    find('#submit-btn').click
    sleep(0.5)
    name = ('a'..'z').to_a.sample(5).join
    fill_in :writing_name, with: name
    fill_in :writing_age_limit, with: 3
    find(:css, '#writing_genre').find(:option, I18n.t('genres.fantasy')).select_option
    sleep(0.5)
    find('#submit-btn').click
    find('#submit-btn').click

    sleep(0.5)

    find('#back-link').click
    sleep(0.5)

    find('#edit-link').click
    name = ('a'..'z').to_a.sample(5).join
    fill_in :writing_name, with: name
    fill_in :writing_age_limit, with: 12
    find(:css, '#writing_genre').find(:option, I18n.t('genres.action_genre')).select_option
    find('#submit-btn').click

    expect(find('#work').text).to have_text(name)
  end

  scenario 'checks unable to delete and see users for average user' do
    visit new_user_path
    fill_in :user_username, with: 'Lololoshka'
    fill_in :user_password, with: 'ILoveMinecraft'
    fill_in :user_password_confirmation, with: 'ILoveMinecraft'
    fill_in :user_email, with: 'average@mail.minecraft'

    find('#submit-btn').click

    sleep(0.5)
    expect(current_path).not_to eq new_user_path

    sleep(0.5)

    visit users_path
    sleep(0.5)

    expect(current_path).not_to eq users_path
  end
  scenario 'checks admin able to delete and see users' do
    User.create!(username: 'Lololoshka', password: 'ILoveMinecraft', email: 'lololoshka@mail.ru')
    visit session_login_path
    fill_in :username, with: 'admin_test'
    fill_in :password, with: 'admin'
    find('#submit-btn').click

    sleep(0.5)

    visit '/en/users/2'
    find('#submit-btn').click
    sleep(0.5)
    expect { User.find(2) }.to raise_error ActiveRecord::RecordNotFound
  end
end
