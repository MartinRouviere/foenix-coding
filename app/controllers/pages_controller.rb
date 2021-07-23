class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  include ApplicationHelper

  def landing
  end

  def sauven_marking
  end

  def home
  end

  def about
  end

  def inks_and_consumables
  end

  def distributor
    @countries = Country.all
  end

  def cost_of_ownership
  end

  def printers
  end

  def fxone_remote
  end

  def fxone_standard
  end

  def fxone_plus
  end

  def software
  end

  def faq
  end

  def industry
  end

  def contact_coders
  end

  def foenix_codaprint
  end

  def foenix_codamark
  end

  def foenix_codapack
  end

  def support
  end

  def subscribe
    session[:return_to] ||= request.referer
    if params[:email].match(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      NewsletterJob.perform_now(params[:email])
      flash[:notice] = "Thanks for signing up to our emailing list."
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "Please enter a valid email address"
      redirect_to session.delete(:return_to)
    end
  end

  def contact
  end

  def privacy_policy
  end

  def cookie_policy
  end

  def send_email
    a = api_post(params['g-recaptcha-response'])
    session[:return_to] ||= request.referer
    if params[:send_email][:email].match(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) && a
      ContactJob.perform_now(params[:send_email][:email], params[:send_email][:first_name], params[:send_email][:last_name], params[:send_email][:company], params[:send_email][:message], params[:send_email][:country], "")
      flash[:notice] = "Thanks for getting in touch, we will try to get back to you as soon as possible."
      redirect_to session.delete(:return_to)
    elsif !a
      flash[:alert] = "Please verify you are a human"
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "Please enter a valid email address"
      redirect_to session.delete(:return_to)
    end
  end


  def create_contact
    a = api_post(params['g-recaptcha-response'])
    session[:return_to] ||= request.referer
    if params[:email].match(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) && a
      ContactJob.perform_now(params[:email], params[:name].split(" ").first, params[:name].split(" ").last, params[:company], params[:message], params[:country], params[:phone])
      flash[:notice] = "Thanks for getting in touch, we will try to get back to you as soon as possible."
      redirect_to session.delete(:return_to)
    elsif !a
      flash[:alert] = "Please verify you are a human"
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "Please enter a valid email address"
      redirect_to session.delete(:return_to)
    end
  end


  def seen_cookie_message
    cookies.permanent[:seen_cookie_message] = true
  end

  private

  def api_post(recaptcha_token)
    begin
      body = { secret: ENV['SECRET_RECAPTCHA_KEY']}
      body[:response] = recaptcha_token
      response = RestClient.post "https://www.google.com/recaptcha/api/siteverify", body
      res = JSON.parse(response.body)
      res['success']
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

end
