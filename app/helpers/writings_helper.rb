module WritingsHelper
  def get_writing(id1, id2)
    @writing = Writing.find_by(user_id: id1, id: id2)
  end

  def best_writings(user = current_user)
    Writing.where(user_id: user&.id, rating: Writing.maximum(:rating))
  end

  def today_writings
    Writing.where(created_at: Date.today.all_day)
  end

  def translated_genres_for_checkbox
    genres.map { |g| [I18n.t("genres.#{g}"), g] }
  end

  def genres
    %w[horror action_genre fantasy comedy drama mystery romance thriller]
  end

  def translated_genres
    genres.map { |g| I18n.t("genres.#{g}") }
  end

  def set_searching_params
    @params = { rate: params[:rate].to_i, age_limit: params[:age_limit].to_i,
                number_of_pages: params[:number_of_pages].to_i }
    @params = @params.merge({ genres: genres.select do |x|
                                        { x.to_s => params[x.to_s] } unless params[x.to_s].to_i.zero?
                                      end })
  end

  def sort_writings
    set_searching_params
    @writings = Writing.where('name LIKE ?', "%#{params[:search]}%")
    @writings = @writings.where(rating: @params[:rate]..5, age_limit: @params[:age_limit]..999,
                                number_of_pages: @params[:number_of_pages]..999)
    @writings = @writings.where(genre: @params[:genres]) unless @params[:genres].blank?
    @writings
  end

  def sort_users
    set_searching_params
    @authors = User.where('username LIKE ?', "%#{params[:search]}%")
    @authors = @authors.where(rating: @params[:rate]..5)
  end
end
