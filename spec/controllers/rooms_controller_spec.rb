
require 'rails_helper'
require 'support/controller_macros.rb'
include ControllerMacros
describe RoomsController do
  login_user

  it 'should have a current_user', type: :controller do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end
end
