class SiteVisit < ActiveRecord::Base
	include SessionsHelper

	def self.tracking_model(user, controller_action, variable_url_extension)
		user_id = user # user should always be the current_user browsing the app...
		root_url = 'https://www.ivolve.herokuapp.com'
		url_extension = variable_url_extension
		if controller_action == 'users_index'
			url = root_url + '/users'
		elsif controller_action == 'users_show'
			url = root_url + '/users/' + url_extension.to_s # in this case the url_extension is the user.id => '/users/1', '/users/2', etc.
		end
		recent = SiteVisit.where('created_at >= ? AND user_id = ? AND url = ?', Time.zone.now - 1.minute, user_id, url)
		if !recent.exists?
		    create(
		    	user_id: user_id,
		    	url: url,
		    )
		end
	end
end