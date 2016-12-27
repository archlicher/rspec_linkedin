require 'car'
require 'shared_examples/a_standard_vehicle'

describe Car do

	describe 'attributes' do
		it_behaves_like 'a standard vehicle'
		# before(:context) do
		# 	def car
		# 		@car ||= Car.new
		# 	end
		# end

		# before(:example) do
		# 	@car = Car.new
		# end

		# let(:car) { Car.new }
		# subject { Car.new }
	# xdescribe 'attributes' do
		# xit "allows reading and writing for :make" do

		# it "allows reading and writing for :make" do
		# 	# skip "No need to run it" not running
		# 	# pending("Debugging a problem") runs the code and marks it as fail
		# 	# car = Car.new
		# 	subject.make = 'Test'
		# 	expect(subject.make).to eq('Test')
		# end

		# it "allows reading and writing for :year" do
		# 	# car = Car.new
		# 	subject.year = 9999
		# 	expect(subject.year).to eq(9999)
		# end

		# it "allows reading and writing for :color" do
		# 	# car = Car.new
		# 	subject.color = 'foo'
		# 	expect(subject.color).to eq('foo')
		# end

		# it "allows reading for :wheels" do
		# 	# car = Car.new
		# 	expect(subject.wheels).to eq(4)
		# end

		#it "allows writing for :doors"

	end

	describe '.colors' do

		let(:colors) { ['blue', 'black', 'red', 'green'] }

		it "returns an array of color names" do
			expect(Car.colors).to match_array(colors)
		end
	end

	describe '#full_name' do

		it "returns a string in the expected format" do
			@peugeot = Car.new(:make => 'Peugeot', :year => 2016, :color => 'white')
			expect(@peugeot.full_name).to eq('2016 Peugeot (white)')
		end

		context 'when initialized with no arguments' do
			it 'returns a string using default values' do
				car = Car.new
				expect(car.full_name).to eq('2007 Volvo (unknown)')
			end
		end

	end

end