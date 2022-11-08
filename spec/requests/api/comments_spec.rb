require 'swagger_helper'

RSpec.describe 'api/comments', type: :request do
  # rubocop:disable Metrics/BlockLength
  path '/api/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves comments for a post' do
      produces 'application/json'
      parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
      parameter name: 'post_id', in: :path, type: :string, description: 'post_id'

      response(200, 'Comments loaded successfully') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 author_id: { type: :integer },
                 post_id: { type: :integer },
                 text: { type: :string }
               }

        let(:user_id) do
          @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                              password_confirmation: 'password')
          @post = Post.create(author: @user, title: 'post', text: 'post text')
          @user.id
        end
        let(:post_id) do
          @post.id
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
                              password_confirmation: 'password')
          @post = Post.create(author: @user, title: 'post', text: 'post text')
          @user.id
        end
        let(:post_id) do
          @post.id
        end
        run_test!
      end
    end
  end

  path '/api/users/{user_id}/posts/{post_id}/comments/create' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'post_id', in: :path, type: :string, description: 'post_id'
    parameter name: 'text', in: :query, type: :string, description: 'text'

    post 'Creates a comment' do
      produces 'application/json'
      consumes 'application/json'
      parameter name: :text, in: :body, type: :string

      response(200, 'Comment created successfully') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 author_id: { type: :integer },
                 post_id: { type: :integer },
                 text: { type: :string }
               }

        let(:user_id) do
          @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                              password_confirmation: 'password')
          @post = Post.create(author: @user, title: 'post', text: 'post text')
          @user.id
        end
        let(:post_id) do
          @post.id
        end
        let(:text) { 'comment text' }
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
                              password_confirmation: 'password')
          @post = Post.create(author: @user, title: 'post', text: 'post text')
          @user.id
        end
        let(:post_id) do
          @post.id
        end
        run_test!
      end

      response(422, 'Comment creation failed') do
        schema type: :object,
               properties: {
                 messages: { type: :string },
                 is_success: { type: :boolean },
                 data: { type: :object }
               }

        let(:user_id) do
          @user = User.create(name: 'user', email: 'user@example.com', password: 'password',
                              password_confirmation: 'password')
          @post = Post.create(author: @user, title: 'post', text: 'post text')
          @user.id
        end
        let(:post_id) do
          @post.id
        end
        let(:text) { 'comment text' }
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
