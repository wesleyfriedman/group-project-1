require 'rails_helper'

RSpec.describe SessionsController do

  before do
    User.destroy_all
  end

  let(:jeff) {User.create(name: 'Jeff', password: 'railsrules')}

  describe 'destroy' do
    it 'leaves session[:user_id] nil upon logout' do
      post :destroy
      expect(@request.session[:user_id]).to be nil
    end
  end

  # describe 'create' do
  #   it 'sets session[:user_id] upon login' do
  #     post :create, user: {id: 1, name: jeff.name, password: jeff.password}
  #     expect(session[:user_id]).to_not be nil
  #   end
  # end

end
