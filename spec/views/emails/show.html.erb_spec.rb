require 'rails_helper'

RSpec.describe "emails/show", :type => :view do
  before(:each) do
    @email = assign(:email, Email.create!(
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
  end
end
