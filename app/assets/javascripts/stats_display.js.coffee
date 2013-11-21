jQuery ->
  Morris.Line
    element: 'twitter-graph'
    data: $('#twitter-graph').data('twitter')
    xkey: 'created_at'   # y is really the value on the X-Axis
    ykeys: ['num_friends', 'num_followers', 'tweets_sent', 'tweets_favd', 'num_lists']  # a is really the value on the Y-Axis
    labels: ['Friends', 'Followers', 'Tweets', 'Favorites', 'Lists']
  Morris.Line
    element: 'facebook-graph'
    data: $('#facebook-graph').data('facebook')
    xkey: 'created_at'   # y is really the value on the X-Axis
    ykeys: ['fb_friends', 'fb_likes', 'fb_posts', 'fb_statuses']  # a is really the value on the Y-Axis
    labels: ['Friends', 'Likes', 'Posts', 'Statuses']
  Morris.Line
    element: 'instagram-graph'
    data: $('#instagram-graph').data('instagram')
    xkey: 'created_at'   # y is really the value on the X-Axis
    ykeys: ['insta_followers', 'insta_following', 'insta_media', 'insta_likes']  # a is really the value on the Y-Axis
    labels: ['Followers', 'Following', 'Shared', 'Likes']
  Morris.Line
    element: 'foursquare-graph'
    data: $('#foursquare-graph').data('foursquare')
    xkey: 'created_at'   # y is really the value on the X-Axis
    ykeys: ['foursquare_friends', 'foursquare_following', 'foursquare_checkins', 'foursquare_badges', 'foursquare_mayor', 'foursquare_tips', 'foursquare_photos']  # a is really the value on the Y-Axis
    labels: ['Friends', 'Following', 'Checkins', 'Badges', 'Mayorships', 'Tips Given', 'Photos']
  Morris.Donut
    element: 'social-connections'
    data: [
        {label: "Twitter", value: $('#social-connections').data('twitter')}
        {label: "Facebook", value: $('#social-connections').data('facebook')}
        {label: "Instagram", value: $('#social-connections').data('instagram')}
        {label: "Foursquare", value: $('#social-connections').data('foursquare')}
    ]
  Morris.Donut
    element: 'ivolve-connections'
    data: [
        {label: "Twitter", value: $('#ivolve-connections').data('twitter')}
        {label: "Facebook", value: $('#ivolve-connections').data('facebook')}
        {label: "Instagram", value: $('#ivolve-connections').data('instagram')}
        {label: "Foursquare", value: $('#ivolve-connections').data('foursquare')}
    ]
  Morris.Donut
    element: 'social-engagement'
    data: [
        {label: "Twitter", value: $('#social-engagement').data('twitter')}
        {label: "Facebook", value: $('#social-engagement').data('facebook')}
        {label: "Instagram", value: $('#social-engagement').data('instagram')}
        {label: "Foursquare", value: $('#social-engagement').data('foursquare')}
    ]
  Morris.Donut
    element: 'ivolve-engagement'
    data: [
        {label: "Twitter", value: $('#ivolve-engagement').data('twitter')}
        {label: "Facebook", value: $('#ivolve-engagement').data('facebook')}
        {label: "Instagram", value: $('#ivolve-engagement').data('instagram')}
        {label: "Foursquare", value: $('#ivolve-engagement').data('foursquare')}
    ]