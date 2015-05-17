require 'rails_helper'

RSpec.describe "emails/new", :type => :view do
  before(:each) do
    assign(:email, Email.new(
      :email => "MyString"
    ))
  end

  it "renders new email form" do
    render

    assert_select "form[action=?][method=?]", emails_path, "post" do

      assert_select "input#email_email[name=?]", "email[email]"
    end
  end
end
