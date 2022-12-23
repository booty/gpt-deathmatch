class SessionsController < ApplicationController
  def destroy

  end

  def create
    success = true
    session = begin
      Session.find_or_create_by_email_address(
        email_address: params[:emailAddress],
        ip_address: request.remote_ip,
      )
    rescue Session::UserNotFound
      success = false
    end

    respond_to do |format|
      format.json begin
        render json: {
          success: success,
          sessionToken: session.guid,
        }
      end
    end
  end
end
