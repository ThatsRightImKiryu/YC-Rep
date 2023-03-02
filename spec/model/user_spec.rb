require 'rails_helper'
require 'spec_helper'
RSpec.describe 'User', type: :model do
  before :each do
    @params = { username: ('a'..'z').to_a.sample(5).join, password: ('a'..'z').to_a.sample(5).join,
                email: 'test@test.test' }
  end

  describe 'User creates values yes' do
    it 'Adds correctly' do
      expect(User.create(@params)).not_to be_nil
      expect(User.find_by_username(@params[:username])).not_to be_nil
    end
  end

  describe 'WE have different results when enter different input values' do
    it '1!=2' do
      params2 = { username: ('a'..'z').to_a.sample(5).join, password: ('a'..'z').to_a.sample(5).join,
                  email: 'test2@test.test' }

      t = User.create!(@params)
      t1 = User.create!(params2)
      expect(t1).not_to eq(t)
    end
  end

  it 'another checks uniqueness_of field' do
    User.create!(@params)
    expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
  end
end

###########################################
RSpec.describe 'User validations', type: :model do
  before :each do
    @params = { username: ('a'..'z').to_a.sample(5).join, password: ('a'..'z').to_a.sample(5).join,
                email: 'test@test.test' }
  end

  describe 'User validations username' do
    it 'Username not emmpty' do
      @params[:username] = nil
      expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Username is unique' do
      @params[:username] = 'test_user'
      expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'User validations password' do
    it 'Password not emmpty' do
      @params[:password] = nil
      expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Password confirms' do
      @params[:password_confirmation] = @params[:password] + ('a'..'z').to_a.sample
      expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'User validations email' do
    it 'email not emmpty' do
      @params[:email] = nil
      expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'email is unique' do
      @params[:email] = 'test_user@mail.ru'
      expect { User.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'Rating calculates correctly' do
    it 'What we gonna do' do
      test = User.find_by_username('test_user')
      expect(test.rating).not_to eq(0)
    end
  end

end
