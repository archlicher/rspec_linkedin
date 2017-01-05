require 'rails_helper'

RSpec.describe Subject, type: :model do
  it "confirms 0 Subjects in db" do
  	expect(Subject.count).to eq 0
  end

  it "confirms 1 Subject in db" do
  	Subject.create(:name => 'test')
  	expect(Subject.count).to eq 1
  	expect(Subject.first.name).to eq('test')
  end
end
