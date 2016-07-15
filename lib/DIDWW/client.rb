require 'savon'

module DIDWW
  class Client
    attr_reader :configuration, :methods

    # key is method used by this api wrapper,
    # value is method used by DIDWW's SOAP api
    METHOD_TRANSLATIONS = {
      get_invoices: :didww_callhistory_invoices,
      check_pstn_number: :didww_checkpstnnumber,
      restore_did: :didww_didrestore,
      get_cdr_log: :didww_getcdrlog,
      get_coverage: :didww_getcoverage,
      get_api_details: :didww_getdidwwapidetails,
      get_cities: :didww_getdidwwcities,
      get_countries: :didww_getdidwwcountries,
      get_pstn_rates: :didww_getdidwwpstnrates,
      get_regions: :didww_getdidwwregions,
      get_prepaid_balance: :didww_getprepaidbalance,
      get_prepaid_balances: :didww_getprepaidbalancelist,
      get_service_details: :didww_getservicedetails,
      get_service_list: :didww_getservicelist,
      get_sms_log: :didww_getsmslog,
      auto_renew_status: :didww_order_autorenew_status,
      auto_renew: :didww_orderautorenew,
      cancel_order: :didww_ordercancel,
      create_order: :didww_ordercreate,
      get_pstn_traffic_data: :didww_pstn_traffic,
      update_mapping: :didww_updatemapping,
      update_prepaid_balance: :didww_updateprepaidbalance,
      update_pstn_rates: :didww_updatepstnrates
    }.freeze

    UNIQUE_HASH_METHODS = [
      :create_order,
      :auto_renew,
      :update_prepaid_balance,
      :restore_did
    ].freeze

    def initialize
      @configuration = DIDWW.configuration
      @savon = savon_client
      @methods = METHOD_TRANSLATIONS.keys
    end

    def method_missing(method_name, *args, &block)
      if methods.include? method_name
        params = (args.first || {}).merge(auth_string: auth_string)
        params.merge!(uniq_hash: (Time.now.to_i.to_s + auth_string)) if UNIQUE_HASH_METHODS.include?(method_name)
        @savon.call METHOD_TRANSLATIONS[method_name], message: params
      else
        raise NoMethodError, "#{method_name} is not a valid api endpoint!"
      end
    end

    private

    def savon_client
      wsdl = configuration.sandbox ? sandbox_url : live_url
      Savon::Client.new wsdl: wsdl
    end

    def auth_string
      string = configuration.api_username + configuration.api_key
      string += 'sandbox' if configuration.sandbox
      Digest::SHA1.hexdigest(string)
    end

    def sandbox_url
      'https://sandbox-api.didww.com/api2/index.php?wsdl'
    end

    def live_url
      'https://api.didww.com/api2/?wsdl'
    end
  end
end
