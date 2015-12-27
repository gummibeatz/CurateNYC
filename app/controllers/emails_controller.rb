class EmailsController < ApplicationController
  respond_to :html, :json 
  helper_method :current_email
  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new
    @email.email = email_params.first.second
      if Email.uniq.pluck(:email).include?(email_params.first.second)
        render :after
      else respond_to do |format|
        if @email.save
          @email.mail (render_to_string('emails/curateanalytics', :layout => false))
          format.html {render :after}
          format.json { render :show, status: :created, location: @email }
        else
          format.html { render :new }
          format.json { render json: @email.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def show
    @emails = Email.find(params[:id])
  end

  def after(email)
  end

  private

    def email_params
      params.require(:email).permit(:email)
    end

    def current_email
      @current_email = @email.email
    end
end
