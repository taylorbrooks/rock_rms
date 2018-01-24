require 'sinatra/base'
require 'securerandom'
require_relative './fixtures_helper'

class RockMock < Sinatra::Base
  # DELETE requests
  [
    "FinancialTransactions/:id",
    "GroupMembers/:id"
  ].each do |end_point|
    delete "/api/#{end_point}" do
      content_type :json
      status 204
    end
  end

  # GET requests
  {
    donation:      'FinancialTransactions/:id',
    donations:     'FinancialTransactions',
    families:      'Groups/GetFamilies/:id',
    group:         'Groups/:id',
    groups:        'Groups',
    people_search: 'People/Search',
    phone_numbers: 'PhoneNumbers',
    recurring_donation: 'FinancialScheduledTransactions/:id',
    recurring_donations: 'FinancialScheduledTransactions'
  }.each do |json, end_point|
    get "/api/#{end_point}" do
      json_response 200, "#{json}.json"
    end
  end


  # PATCH requests
  {
    update_donation: 'FinancialTransactions/:id'
  }.each do |json, end_point|
    patch "/api/#{end_point}" do
      content_type :json
      status 204
    end
  end

  # POST requests
  {
    create_group_member: 'GroupMembers',
    create_donation: 'FinancialTransactions'
  }.each do |json, end_point|
    post "/api/#{end_point}" do
      json_response 201, "#{json}.json"
    end
  end

  # PATCH requests
  [
    'FinancialScheduledTransactions/:id'
  ].each do |end_point|
    patch "/api/#{end_point}" do
      content_type :json
      status 204
    end
  end

  post '/api/Auth/Login' do
    content_type :json

    response['Cache-Control'] = 'no-cache'
    response['Content-Secuity-Policy'] = "frame-ancestors 'self'"
    response['Date'] = Time.now.httpdate
    response['Expires'] = '-1'
    response['Pragma'] = 'no-cache'
    response['Set-Cookie'] = [
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
