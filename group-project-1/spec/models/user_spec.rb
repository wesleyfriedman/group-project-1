require 'rails_helper'

RSpec.describe User, type: :model do

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
      start_date: DateTime.now,
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

  it "has an event if host" do
    @user.events << @event
    expect(@user.events.count).to eq(1)
  end

  it "can find hosted events" do
    @user.events << @event 
    @event.host = @user.id
    expect(@user.hosted_events.first).to eq(@event)
  end

end
