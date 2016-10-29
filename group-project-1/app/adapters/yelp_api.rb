class YelpApi

  def self.client
    @client ||= Yelp::Client.new({
        consumer_key: 'd__rqgcv7CrJeU_9u5LGgw',
        consumer_secret: 'BnYL0R6-SLNkPZoVZ_JSUbx9KJg',
        token: '5ksP29oYRvxzcx_n-Y6FZlEXLwJOPxf_',
        token_secret: 'XV8Ubz-Q4lTnU--_ScgZXL2I_U8'
      })
  end

  def self.search(location, term)
    @results = client.search(location, {term: term}).businesses
    @results.map do |result|
      Restaurant.find_or_create_by(stars: result.rating_img_url_small, name: result.name, rating: result.rating, address: result.location.display_address.join(", "))
    end
  end

def self.client
  Google::Apis::CalendarV3::Event.new{
  summary: 'Google I/O 2015',
  location: '800 Howard St., San Francisco, CA 94103',
  description: 'A chance to hear more about Google\'s developer products.',
  start: {
    date_time: '2015-05-28T09:00:00-07:00',
    time_zone: 'America/Los_Angeles',
  },
  end: {
    date_time: '2015-05-28T17:00:00-07:00',
    time_zone: 'America/Los_Angeles',
  },
  recurrence: [
    'RRULE:FREQ=DAILY;COUNT=2'
  ],
  attendees: [
    {email: 'lpage@example.com'},
    {email: 'sbrin@example.com'},
  ],
  reminders: {
    use_default: false,
    overrides: [
      {method' => 'email', 'minutes: 24 * 60},
      {method' => 'popup', 'minutes: 10},
    ],
  },
}

result = client.events.insert(@user.email, event)
puts "Event created: #{result.html_link}"
end
