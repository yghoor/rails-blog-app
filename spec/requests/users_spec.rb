require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'GET #index' do
    before(:example) { get users_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders \'index\' template' do
      expect(response).to render_template('index')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a list of users')
    end
  end

  context 'GET #show' do
    before(:example) { get user_path(1) }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders \'show\' template' do
      expect(response).to render_template('show')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a user')
    end
  end
end
