# frozen_string_literal: true

class ApplicationController < ActionController::API
  # include ActionController::RequestForgeryProtection
  include Response
  respond_to :json
  include Pundit
  # protect_from_forgery

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.execute(sql)
  
    if results.present?
      return results
    else
      return nil
    end
  end
end
