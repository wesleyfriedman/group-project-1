require 'rails_helper'

describe "User views" do
  before do
    @user = User.create(
      name: "Jeff",
      email: "jeff@flatiron.com",
      phone_number: "3459806254",
      password: "railsrules"
      )
    @event = Event.create(
      name: "Party",
      host: 1,
      address: "11 Broadway, NY, NY",
      start_date: DateTime.now,
      end_date: DateTime.now.tomorrow.to_date, description: "Good vibes"
      )
    @task = Task.create(
      name: "Cups",
      description: "get cups",
      user_id: 1,
      event_id: 1,
      complete: false
      )
  end

  describe "index pages" do
    describe "/users" do
      before do
        users_path
        # expect(current_page).to eq('/users')
      end

      it 'responds with a 200 status code' do
        expect(page.status_code).to eq(200)
      end

      it "displays user's hosted events" do
        expect(page).to have_content(@event.name)
      end
    end
  end

end
