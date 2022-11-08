require 'swagger_helper'

RSpec.describe 'api/registrations', type: :request do
  # rubocop:disable Metrics/BlockLength
  path '/api/sign_up' do
    parameter name: 'name', in: :query, type: :string, description: 'name'
    parameter name: 'email', in: :query, type: :string, description: 'email'
    parameter name: 'password', in: :query, type: :string, description: 'password'
    parameter name: 'password_confirmation', in: :query, type: :string, description: 'password_confirmation'

    post 'Creates a user' do
      produces 'application/json'
      consumes 'application/json'
      parameter name: :name, in: :body, type: :string
      parameter name: :email, in: :body, type: :string
      parameter name: :password, in: :body, type: :string
      parameter name: :password_confirmation, in: :body, type: :string
  
      response(200, 'Signed up successfully') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string }
               }
  
        let(:name) { 'apple' }
        let(:email) { 'apple@example.com' }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password' }
        run_test!
      end
    end
  end

  path '/api/sign_up' do
    post 'Creates a user' do
      produces 'application/json'
      consumes 'application/json'
  
      response(400, 'Missing Params') do
        schema type: :object,
               properties: {
                 messages: { type: :string },
                 is_success: { type: :boolean },
                 data: { type: :object }
               }
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
