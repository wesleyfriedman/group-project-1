require 'rails_helper'

RSpec.describe Event, type: :model do

  before :each do
    @user = User.create(
      id: 1,
      name: "Jeff",
      email: "jeff@flatiron.com",
      phone_number: "3459806254",
      password: "railsrules"
      )
    @event = Event.create(
      id: 1,
      name: "Party",
      host: 1,
      address: "11 Broadway, NY, NY",
      start_date: "Tue, 08 Nov 2016 19:52:12 UTC +00:00",
      end_date: DateTime.now.tomorrow.to_date, description: "Good vibes"
      )
    @task = Task.create(
      id: 1,
      name: "Cups",
      description: "get cups",
      user_id: 1,
      event_id: 1,
      complete: false
      )
  end

  it "can filter past events" do
    expect(@event.past_events).to eq(false)
  end

  it "can format DateTime" do
    expect(@event.date_format(@event.start_date)).to eq("Tuesday - November 16, 2016 at 07:52 PM")
  end

end
