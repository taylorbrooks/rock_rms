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
    'FinancialTransactionDetails/:id',
    'FinancialScheduledTransactionDetails/:id',
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
    content_channel: 'ContentChannels/:id',
    content_channels: 'ContentChannels',
    content_channel_item: 'ContentChannelItems/:id',
    content_channel_items: 'ContentChannelItems',
    content_channel_type: 'ContentChannelTypes/:id',
    content_channel_types: 'ContentChannelTypes',
    transaction:   'FinancialTransactions/:id',
    transactions:  'FinancialTransactions',
    defined_values:'DefinedValues',
    families:      'Groups/GetFamilies/:id',
    gateways:      'FinancialGateways',
    group:         'Groups/:id',
    group_members: 'GroupMembers',
    groups:        'Groups',
    payment_details: 'FinancialPaymentDetails',
    people_search: 'People/Search',
    person_by_alias: 'People/GetByPersonAliasId/:id',
    phone_numbers: 'PhoneNumbers',
    recurring_donation:  'FinancialScheduledTransactions/:id',
    recurring_donations: 'FinancialScheduledTransactions',
    saved_payment_methods: 'FinancialPersonSavedAccounts',
    transaction_detail:  'FinancialTransactionDetails/:id',
    transaction_details: 'FinancialTransactionDetails',
    workflow_type: 'WorkflowTypes/:id',
    workflow_types: 'WorkflowTypes',
    workflow_activity_type: 'WorkflowActivityTypes/:id',
    workflow_activity_types: 'WorkflowActivityTypes',
    workflow_action_type: 'WorkflowActionTypes/:id',
    workflow_action_types: 'WorkflowActionTypes'
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
    create_known_relationship: 'GroupMembers/KnownRelationship',
    create_transaction: 'FinancialTransactions',
    create_payment_detail: 'FinancialPaymentDetails',
    create_phone_number: 'PhoneNumbers',
    create_batch: 'FinancialBatches',
    create_recurring_donation: 'FinancialScheduledTransactions',
    create_refund: 'FinancialTransactionRefunds',
    create_refund_reason: 'DefinedValues',
    create_saved_payment_method: 'FinancialPersonSavedAccounts',
    create_transaction_detail: 'FinancialTransactionDetails',
    create_recurring_donation_detail: 'FinancialScheduledTransactionDetails',
  }.each do |json, end_point|
    post "/api/#{end_point}" do
      json_response 201, "#{json}.json"
    end
  end

  # PUT requests
  {
    group_save_address: 'Groups/SaveAddress/:group_id/:location_type_id',
  }.each do |json, end_point|
    put "/api/#{end_point}" do
      json_response 204, "#{json}.json"
    end
  end

  # PATCH requests
  [
    'ContentChannels/:id',
    'FinancialBatches/:id',
    'FinancialScheduledTransactions/:id',
    'FinancialTransactions/:id',
    'FinancialTransactionDetails/:id',
    'FinancialScheduledTransactionDetails/:id',
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
