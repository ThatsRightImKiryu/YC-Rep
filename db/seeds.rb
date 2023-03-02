
@admin = User.create!(username: 'admin_test', password: 'admin', email: 'admin_test@mail.ru', role: 'admin')
@test_user = User.create!(username: 'test_user', password: 'test', email: 'test_user@mail.ru')
admin_writing = @admin.writings.create!(name: 'admin_writing', genre: 'horror', age_limit: 5)
test_writing = @test_user.writings.create!(name: 'test_writing',genre: 'comedy', age_limit: 17)
test_writing_rating = test_writing.ratings.create!(rate: 4, commentator: 'poco')
