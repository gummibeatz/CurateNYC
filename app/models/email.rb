class Email < ActiveRecord::Base
  def mail (html_email)
        m = Mandrill::API.new(MANDRILL_KEY)
        message = { 
         :subject=> "Hey! Are you ready for a swag-a-licious wardrobe?",  
         :from_name=> "CurateAnalytics",
         :text=>"Thanks for being interested in Curate, unfortunately you have HTML emails disabled. Enable them and prepare your inbox!",  
         :to=>[  
           {  
             :email=> self.email
            }
         ],  
         :html=> html_email,  
         :from_email=> 'curateanalytics@gmail.com'
        }  
        sending = m.messages.send message
    end
end