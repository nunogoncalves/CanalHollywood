class AddDaysToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :canal_hollywood_premiere_year, :integer
    add_column :movies, :canal_hollywood_premiere_month, :integer
    add_column :movies, :canal_hollywood_premiere_day, :integer
    add_column :movies, :canal_hollywood_premiere_day_of_the_week, :integer
  end
end
