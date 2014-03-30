class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :movie_id
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.integer :duration_mins

      t.timestamps
    end
  end
end
