require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
  # rubocop:disable Metrics/BlockLength
  path '/api/users/{user_id}/posts' do
    get 'Retrieves posts for a user' do
      produces 'application/json'
      parameter name: 'user_id', in: :path, type: :string

      response '200', 'Posts loaded successfully' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 author_id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string },
                 comments_counter: { type: :integer },
                 likes_counter: { type: :integer }
               }

        let(:user_id) do
          @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                              password_confirmation: 'password').id
        end
        run_test!
      end

      response(400, 'Missing Params') do
        schema type: :object,
               properties: {
                 messages: { type: :string },
                 is_success: { type: :boolean },
                 data: { type: :object }
               }

        let(:user_id) do
          @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                              password_confirmation: 'password').id
        end
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
