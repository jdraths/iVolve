class ChangeFitbitUsers < ActiveRecord::Migration
    def self.up
  	  change_table :fitbit_users do |t|
  		t.integer :height_int
  		t.integer :weight_int
  		t.integer :best_tot_active_score_int
  		t.integer :best_tot_cal_out_int
  		t.integer :best_tot_dist_int
  		t.integer :best_tot_steps_int
  		t.integer :best_track_cal_out_int
  		t.integer :lifetime_tot_active_score_int
  		t.integer :lifetime_tot_cal_out_int
  		t.integer :lifetime_tot_dist_int
  		t.integer :lifetime_tot_steps_int
  		t.integer :lifetime_track_active_score_int
  		t.integer :lifetime_track_cal_out_int
  		t.integer :lifetime_track_dist_int
  		t.integer :lifetime_track_steps_int
      t.integer :stride_length_run_int
      t.integer :stride_length_walk_int
  	  end
	end

    def self.down
  	  change_table :fitbit_users do |t|
      t.remove :stride_length_walk_int
      t.remove :stride_length_run_int
  		t.remove :lifetime_track_steps_int
  		t.remove :lifetime_track_dist_int
  		t.remove :lifetime_track_cal_out_int
  		t.remove :lifetime_track_active_score_int
  		t.remove :lifetime_tot_steps_int
  		t.remove :lifetime_tot_dist_int
  	  t.remove :lifetime_tot_cal_out_int
  		t.remove :lifetime_tot_active_score_int
  		t.remove :best_track_cal_out_int
  		t.remove :best_tot_steps_int
  		t.remove :best_tot_dist_int
  		t.remove :best_tot_cal_out_int
  		t.remove :best_tot_active_score_int
  		t.remove :weight_int
  		t.remove :height_int
  	  end
    end
end
