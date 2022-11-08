require 'swagger_helper'

RSpec.describe 'api/registrations', type: :request do
  # rubocop:disable Metrics/BlockLength
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

      let(:name) { 'user' }
      let(:email) { 'user@example.com' }
      let(:password) { 'password' }
      let(:password_confirmation) { 'password' }
      run_test!
    end

    response(400, 'Missing Params') do
      schema type: :object,
             properties: {
               messages: { type: :string },
               is_success: { type: :boolean },
               data: { type: :object }
             }

      let(:email) { 'user@example.com' }
      let(:password) { 'password' }
      let(:password_confirmation) { 'password' }
      run_test!
    end

    response(422, 'Sign Up Failed') do
      schema type: :object,
             properties: {
               messages: { type: :string },
               is_success: { type: :boolean },
               data: { type: :object }
             }

      let(:name) { 'user' }
      let(:email) { 'user@example.com' }
      let(:password) { 'password' }
      let(:password_confirmation) { 'password' }
      run_test!
    end
  end
  # rubocop:enable Metrics/BlockLength
end
