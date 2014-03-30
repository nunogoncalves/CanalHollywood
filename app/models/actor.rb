class Actor < ActiveRecord::Base
  attr_accessible :birth_date, :date_of_death, :image, :deceased, :imdb_url, :name, :movie_ids, :movies_count

  has_many :casts
  has_many :movies, through: :casts

  validates_uniqueness_of :name

  before_save :calculate_aged

  def calculate_aged
  	if deceased && aged.nil? && birth_date.present?
  		self.aged = calculate_age(birth_date, date_of_death)
  	end
  end

  IMAGES_ROOT_URL = "https://dl.dropboxusercontent.com/u/2001692/actor/"

  def name_and_movies_count
    "#{name} (#{movies_count})"
  end

  def display_image
  	self.image.present? ? "#{self.image}" : "#{IMAGES_ROOT_URL}#{self.name.gsub(/\s+/, '')}.jpg"
  end

  def display_age
    aged if deceased
    calculate_age(birth_date, Date.today) if birth_date.present?
  end

  def calculate_age(dob, dod)
  	dod.year - dob.year - ((dod.month > dob.month || (dod.month == dob.month && dod.day >= dob.day)) ? 0 : 1)
	end
  	
  def imdb_search_url
    return "" if name.blank? 
    "http://www.imdb.com/find?q=#{name_no_spaces}&s=all#nm"
  end

  def display_birth_date
    display_date(birth_date) if birth_date.present?
  end

  def display_death_date
    display_date(date_of_death) if date_of_death.present?
  end

  def display_date(date)
    date.strftime("%Y-%m-%d")
  end

  def name_no_spaces
    name.sub(" ", "+")
  end

  def next_actor
    @next_actor ||= Actor.where("id > #{self.id}").order("id asc").limit(1).first || Actor.order("id asc").limit(1).first
  end

  def next_actor_id
    next_actor.id
  end

  def previous_actor
    @previous_actor ||= Actor.where("id < #{self.id}").order("id desc").limit(1).first || Actor.order("id desc").limit(1).first
  end

  def previous_actor_id
    previous_actor.id
  end

  def redo_movies_count
    count = Cast.where(actor_id: id).count
    update_attribute("movies_count", count)
    self.save!
  end

end
