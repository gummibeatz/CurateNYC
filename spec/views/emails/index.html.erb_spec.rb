require 'rails_helper'

RSpec.describe "emails/index", :type => :view do
  before(:each) do
    assign(:emails, [
      Email.create!(
        :email => "Email"
      ),
      Email.create!(
        :email => "Email"
      )
    ])
  end

  it "renders a list of emails" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
