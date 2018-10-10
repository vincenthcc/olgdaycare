class SamlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to request.create( saml_settings )
  end

  def consume
    response          = OneLogin::RubySaml::Response.new( params[:SAMLResponse], :allowed_clock_drift => 1.second )
    response.settings = saml_settings

    # We validate the SAML Response and check if the user already exists in the system
    if response.is_valid?
      current_user = User.unscope( :where ).where( email: response.nameid ).first_or_create

      current_user.update(
        first_name: response.attributes[:first_name],
        last_name:  response.attributes[:last_name],
      )

      sign_in( :user, current_user )
      redirect_to after_sign_in_path_for( current_user )
    else
      redirect_to root_url, alert: 'Unable to log you in. Please try again.'
    end
  end

  private

    def saml_settings
      settings                                = OneLogin::RubySaml::Settings.new
      settings.assertion_consumer_service_url = "https://#{ Current.domain }/u/saml"
      settings.issuer                         = 'OLG Intranet'
      settings.idp_sso_target_url             = ENV['SAML_IDP_SSO_TARGET_URL']
      settings.idp_cert_fingerprint           = ENV['SAML_IDP_CERT_FINGERPRINT']
      settings.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
      settings
    end
end
