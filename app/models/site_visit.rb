class SiteVisit < ActiveRecord::Base
	include SessionsHelper

	def self.tracking_model(user, controller_action, variable_url_extension)
		user_id = user # user should always be the current_user browsing the app...
		root_url = 'https://www.ivolve.herokuapp.com'
		url_extension = variable_url_extension
		case controller_action
		when 'users_index'
			url = root_url + '/users'
		when 'users_show'
			url = root_url + '/users/' + url_extension.to_s # in this case the url_extension is the user.id => '/users/1', '/users/2', etc.
		when 'static_home'
			url = root_url
		when 'static_help'
			url = root_url + '/help'
		when 'static_about'
			url = root_url + '/about'
		when 'static_contact'
			url = root_url + '/contact'
		when 'micropost_create'
			action = 'micropost=' + url_extension.to_s
		end
		recent = SiteVisit.where('created_at >= ? AND user_id = ? AND url = ?', Time.zone.now - 2.seconds, user_id, url)
		if !recent.exists?
		    create(
		    	user_id: user_id,
		    	url: url,
		    	action: action,
		    )
		end
	end
end