class FacebookUser < ActiveRecord::Base
	belongs_to :user
	def self.pull_user_data(user)
		@authorized = Authorization.find_by_user_id_and_provider(user, 'facebook')
		facebook = Koala::Facebook::API.new(@authorized.oauth_token)
		facebook.get_object('me') do |data|
			create!(
			uid: data['id'],
			name: data['name'],
			first_name: data['first_name'],
			middle_name: data['middle_name'],
			last_name: data['last_name'],
			gender: data['gender'],
			# locale is a string containing the ISO Language Code and ISO Country Code
			locale: data['locale'],
			# languages is an array containing lanuage id and name
			languages: data['languages'].to_s,
			profile_url: data['link'],
			screen_name: data['username'],
			third_party_id: data['third_party_id'],
			installed: data['installed'],
			timezone: data['timezone'],
			updated_time: data['updated_time'],
			verified: data['verified'],
			bio: data['bio'],
			birthday: data['birthday'],
			cover_photo: data['cover'].to_s,
			currency: data['currency'].to_s,
			devices: data['devices'].to_s,
			education: data['education'].to_s,
			email: data['email'],
			hometown: data['hometown'].to_s,
			interested_in: data['interested_in'].to_s,
			location: data['location'].to_s,
			political: data['political'],
			favorite_athletes: data['favorite_athletes'].to_s,
			favorite_teams: data['favorite_teams'].to_s,
			profile_pic: data['picture'].to_s,
			quotes: data['quotes'],
			relationship_status: data['relationship_status'],
			religion: data['religion'],
			significant_other: data['significant_other'].to_s,
			website: data['website'],
			work: data['work'].to_s
			)
		end
	end

	def self.manual_user_data(user)
		@authorized = Authorization.find_by_user_id_and_provider(user, 'facebook')
		facebook = Koala::Facebook::API.new(@authorized.oauth_token)
		facebook.get_object('me') do |data|
			create!(
			uid: data['id'],
			name: data['name'],
			first_name: data['first_name'],
			middle_name: data['middle_name'],
			last_name: data['last_name'],
			gender: data['gender'],
			# locale is a string containing the ISO Language Code and ISO Country Code
			locale: data['locale'],
			# languages is an array containing lanuage id and name
			languages: data['languages'].to_s,
			profile_url: data['link'],
			screen_name: data['username'],
			third_party_id: data['third_party_id'],
			installed: data['installed'],
			timezone: data['timezone'],
			updated_time: data['updated_time'],
			verified: data['verified'],
			bio: data['bio'],
			birthday: data['birthday'],
			cover_photo: data['cover'].to_s,
			currency: data['currency'].to_s,
			devices: data['devices'].to_s,
			education: data['education'].to_s,
			email: data['email'],
			hometown: data['hometown'].to_s,
			interested_in: data['interested_in'].to_s,
			location: data['location'].to_s,
			political: data['political'],
			favorite_athletes: data['favorite_athletes'].to_s,
			favorite_teams: data['favorite_teams'].to_s,
			profile_pic: data['picture'].to_s,
			quotes: data['quotes'],
			relationship_status: data['relationship_status'],
			religion: data['religion'],
			significant_other: data['significant_other'].to_s,
			website: data['website'],
			work: data['work'].to_s
			)
		end
	end
end
