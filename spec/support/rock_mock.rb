require 'sinatra/base'
require 'securerandom'
require_relative './fixtures_helper'

class RockMock < Sinatra::Base
  # DELETE requests
  [
    'FinancialBatches/:id',
    'FinancialPaymentDetails/:id',
    'FinancialPersonSavedAccounts/:id',
    'FinancialTransactions/:id',
    'GroupMembers/:id'
  ].each do |end_point|
    delete "/api/#{end_point}" do
      content_type :json
      status 204
    end
  end

  # GET requests
  {
    attributes:    'Attributes',
    attribute_values: 'AttributeValues',
    batch:         'FinancialBatches/:id',
    batches:       'FinancialBatches',
    campus:        'Campuses/:id',
    transaction:   'FinancialTransactions/:id',
    transactions:  'FinancialTransactions',
    defined_values:'DefinedValues',
    families:      'Groups/GetFamilies/:id',
    gateways:      'FinancialGateways',
    group:         'Groups/:id',
    groups:        'Groups',
    payment_details: 'FinancialPaymentDetails',
    people_search: 'People/Search',
    person_by_alias: 'People/GetByPersonAliasId/:id',
    phone_numbers: 'PhoneNumbers',
    recurring_donation:  'FinancialScheduledTransactions/:id',
    recurring_donations: 'FinancialScheduledTransactions',
    saved_payment_methods: 'FinancialPersonSavedAccounts',
    transaction_detail:  'FinancialTransactionDetails/:id',
    transaction_details: 'FinancialTransactionDetails'
  }.each do |json, end_point|
    get "/api/#{end_point}" do
      json_response 200, "#{json}.json"
    end
  end

  # POST requests
  {
    create_attribute: 'Attributes',
    create_attribute_value: 'AttributeValues',
    create_group_member: 'GroupMembers',
    create_transaction: 'FinancialTransactions',
    create_payment_detail: 'FinancialPaymentDetails',
    create_batch: 'FinancialBatches',
    create_recurring_donation: 'FinancialScheduledTransactions',
    create_refund: 'FinancialTransactionRefunds',
    create_refund_reason: 'DefinedValues'
  }.each do |json, end_point|
    post "/api/#{end_point}" do
      json_response 201, "#{json}.json"
    end
  end

  # PATCH requests
  [
    'FinancialBatches/:id',
    'FinancialScheduledTransactions/:id',
    'FinancialTransactions/:id',
    'FinancialTransactionDetails/:id'
  ].each do |end_point|
    patch "/api/#{end_point}" do
      content_type :json
      status 204
    end
  end

  post '/api/Auth/Login' do
    content_type :json

    response['Cache-Control']          = 'no-cache'
    response['Content-Secuity-Policy'] = "frame-ancestors 'self'"
    response['Date']                   = Time.now.httpdate
    response['Expires']                = '-1'
    response['Pragma']                 = 'no-cache'
    response['Set-Cookie']             = [
      ".ROCK=#{SecureRandom.hex(100)}",
      "expires=#{(Time.now + 14).httpdate}",
      'path=/',
      'HttpOnly'
    ].join('; ')
    response['X-Frame-Options'] = 'SAMEORIGIN'

    status 204
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    FixturesHelper.read(file_name)
  end
end
