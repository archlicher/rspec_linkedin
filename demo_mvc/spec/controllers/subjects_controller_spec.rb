require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do

	let(:subjects) { Subject.sorted }
	# commented out the check for logged in user
	before(:example) { get :index }

	describe 'GET index' do

		it "assigns all subjects sorted to @subjects" do
			expect(assigns(:subjects)).to eq(subjects)
		end

		it "verifies correct template is readered" do
			expect(response).to render_template('subjects/index')
		end

		it "is a success" do
			expect(response).to have_http_status(:ok)
		end
	end
end
