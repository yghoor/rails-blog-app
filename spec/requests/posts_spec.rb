require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET #index' do
    before(:example) { get user_posts_path(1) }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders \'index\' template' do
      expect(response).to render_template('index')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  context 'GET #show' do
    before(:example) { get user_post_path(1, 1) }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders \'show\' template' do
      expect(response).to render_template('show')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a post from a user')
    end
  end
end
