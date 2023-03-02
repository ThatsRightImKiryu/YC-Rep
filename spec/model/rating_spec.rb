require 'rails_helper'
require 'spec_helper'
RSpec.describe 'Rating', type: :model do
  describe 'Rating creates values yes' do
    it 'Adds correctly' do
      @params = { rate: rand(0..5), commentator: ('a'..'z').to_a.sample(5).join }
      @test = User.find_by_username('test_user')
      @writing = @test.writings.last
      expect(rate = @writing.ratings.create(@params)).not_to be_nil
      expect(Rating.find(rate.id)).not_to be_nil
    end
  end
end
# ###########################################
RSpec.describe 'Rating validations', type: :model do
  before :each do
    @test = User.find_by_username('test_user')
    @writing = @test.writings.last

    @params = { writing_id: @writing.id, rate: rand(0..5), commentator: ('a'..'z').to_a.sample(5).join }
  end

  describe 'Rating validations rate' do
    it 'Rate not emmpty' do
      @params[:rate] = nil
      expect { Rating.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Rate is valid' do
      @params[:rate] = rand(6..100)
      expect { Rating.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'Commentator not emmpty' do
      @params[:commentator] = nil
      expect { Rating.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'Writing id not null' do
      @params[:writing_id] = 'test_user'
      expect { Rating.create!(@params) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'User validations email' do
    it 'What we gonna do' do
      expect(@test.rating).not_to eq(0)
      expect(@writing.rating).not_to eq(0)
    end
  end
end
