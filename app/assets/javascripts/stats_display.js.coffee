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