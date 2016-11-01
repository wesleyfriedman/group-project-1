# require 'rails_helper'
#
# RSpec.describe EventsController do
#
#   before do
#     Event.destroy_all
#   end
#
#   let(:party) {Event.create(name: 'Party Time', start_date: DateTime.now, end_date: )}
#
#   describe 'destroy' do
#     it 'leaves session[:user_id] nil upon logout' do
#       post :destroy
#       expect(@request.session[:user_id]).to be nil
#     end
#   end
#
#   describe 'create' do
#     it 'sets session[:user_id] upon login' do
#       post :create, user: {name: jeff.name, password: jeff.password}
#       expect(session[:user_id]).to_not be nil
#     end
#   end
#
# end
