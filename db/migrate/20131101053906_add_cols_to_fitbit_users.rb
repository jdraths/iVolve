class AddColsToFitbitUsers < ActiveRecord::Migration
  def up
  	change_table :fitbit_users do |t|
  		t.string :best_tot_active_score_date
  		t.string :best_tot_active_score_value
  		t.string :best_tot_cal_out_date
  		t.string :best_tot_cal_out_value
  		t.string :best_tot_dist_date
  		t.string :best_tot_dist_value
  		t.string :best_tot_steps_date
  		t.string :best_tot_steps_value
  		t.string :best_track_cal_out_date
  		t.string :best_track_cal_out_value
  		t.string :lifetime_tot_active_score
  		t.string :lifetime_tot_cal_out
  		t.string :lifetime_tot_dist
  		t.string :lifetime_tot_steps
  		t.string :lifetime_track_active_score
  		t.string :lifetime_track_cal_out
  		t.string :lifetime_track_dist
  		t.string :lifetime_track_steps
  		t.string :fav_activity_name_one
  		t.string :fav_activity_name_two
  		t.string :fav_activity_name_three
  		t.string :freq_activity_name_one
  		t.string :freq_activity_name_two
  		t.string :freq_activity_name_three
  		t.string :freq_food_name_one
  		t.string :freq_food_name_two
  		t.string :freq_food_name_three
  		t.string :rec_activity_name_one
  		t.string :rec_activity_name_two
  		t.string :rec_activity_name_three
  		t.string :rec_activity_cal_one
  		t.string :rec_activity_cal_two
  		t.string :rec_activity_cal_three
  		t.string :rec_food_name_one
  		t.string :rec_food_name_two
  		t.string :rec_food_name_three
    end
  end

  def down
    change_table :fitbit_users do |t|
    	t.remove :rec_food_name_three
    	t.remove :rec_food_name_two
    	t.remove :rec_food_name_one
    	t.remove :rec_activity_cal_three
    	t.remove :rec_activity_cal_two
    	t.remove :rec_activity_cal_one
    	t.remove :rec_activity_name_three
    	t.remove :rec_activity_name_two
    	t.remove :rec_activity_name_one
    	t.remove :freq_food_name_three
    	t.remove :freq_food_name_two
    	t.remove :freq_food_name_one
    	t.remove :freq_activity_name_three
    	t.remove :freq_activity_name_two
    	t.remove :freq_activity_name_one
    	t.remove :fav_activity_name_three
    	t.remove :fav_activity_name_two
    	t.remove :fav_activity_name_one
    	t.remove :lifetime_track_steps
    	t.remove :lifetime_track_dist
    	t.remove :lifetime_track_cal_out
    	t.remove :lifetime_track_active_score
    	t.remove :lifetime_tot_steps
    	t.remove :lifetime_tot_dist
    	t.remove :lifetime_tot_cal_out
    	t.remove :lifetime_tot_active_score
    	t.remove :best_track_cal_out_value
    	t.remove :best_track_cal_out_date
    	t.remove :best_tot_steps_value
    	t.remove :best_tot_steps_date
    	t.remove :best_tot_dist_value
    	t.remove :best_tot_dist_date
    	t.remove :best_tot_cal_out_value
    	t.remove :best_tot_cal_out_date
    	t.remove :best_tot_active_score_value
    	t.remove :best_tot_active_score_date
    end
  end
end