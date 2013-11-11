jQuery ->
  Morris.Line
    element: 'twitter-graph'
    data: $('#twitter-graph').data('twitter')
    xkey: 'event'   # y is really the value on the X-Axis
    ykeys: ['num_friends', 'num_followers', 'tweets_sent', 'tweets_favd', 'num_lists']  # a is really the value on the Y-Axis
    labels: ['Friends', 'Followers', 'Tweets', 'Favorites', 'Lists']