# frozen_string_literal: true
class OmniauthCallbacksController < ApplicationController
  respond_to :json
  # def facebook
  #   puts request.env['omniauth.auth']
  #   @user = User.from_omniauth(request.env['omniauth.auth'])
  #   if @user.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
  #     sign_in_and_redirect @user, event: :authentication
  #   else
  #     session['devise.facebook_data'] = request.env['omniauth.auth'].delete_if("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in @user
      render json: @user
    else
      redirect_to new_user_registration_url
    end
  end

  # def twitter
  #   @user = User.from_omniauth(request.env['omniauth.auth'])
  #   if @user.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Twitter'
  #     sign_in_and_redirect @user, event: :authentication
  #   else
  #     session['devise.google_data'] = request.env['omniauth.auth'].delete_if("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end

  def failure
    redirect_to root_path
  end
end