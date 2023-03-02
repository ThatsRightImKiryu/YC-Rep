require 'rails_helper'
require 'spec_helper'
RSpec.describe 'Follower', type: :model do
  describe 'Rating creates values yes' do
    it 'Adds correctly' do
      @test = User.find_by_username('test_user')
      @admin = User.find_by_username('admin_test')
      expect(follower = @test.followers.create!(follow_id: @admin.id)).not_to be_nil
      expect(Follower.find(follower.id)).not_to be_nil
    end
  end
  describe 'Rating check ids yes' do
    it 'Checks user_id correctly' do
      expect { Follower.create!(follow_id: rand(100)) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Checks user_id correctly' do
      expect { Follower.create!(user_id: rand(100)) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
