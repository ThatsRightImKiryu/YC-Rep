require 'rails_helper'
require 'spec_helper'
RSpec.describe 'Writing', type: :model do
  describe 'User creates values yes' do
    it 'Adds correctly' do
      @params = { name: ('a'..'z').to_a.sample(5).join, genre: 'horror',
                  age_limit: rand(0..18) }
      @test = User.find_by_username('test_user')
      expect(@test
        .writings.create(@params)).not_to be_nil
      expect(@test.writings.find_by_name(@params[:name])).not_to be_nil
    end
  end
end
# ###########################################
RSpec.describe 'Writing validations', type: :model do
  before :each do
    @params = { name: ('a'..'z').to_a.sample(5).join, genre: 'horror',
                age_limit: rand(0..18) }
    @test = User.find_by_username('test_user')
  end

  describe 'Writing validations age limit' do
    it 'Age limit not emmpty' do
      @params[:age_limit] = nil
      expect { @test.writings.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Writing id not emmpty' do
      expect { Writing.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'cant be less less than 0' do
      @params[:age_limit] = -rand(1..100)
      expect { @test.writings.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'cant be less more than 18' do
      @params[:age_limit] = rand(19..100)
      expect { @test.writings.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'Writing validations genre' do
    it 'Genre not emmpty' do
      @params[:age_limit] = nil
      expect { @test.writings.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'cant be wrong' do
      @params[:genre] = ('a'..'z').to_a.sample(10)
      expect { @test.writings.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
