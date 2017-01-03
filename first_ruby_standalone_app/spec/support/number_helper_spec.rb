# encoding: UTF-8

describe 'NumberHelper' do

    include NumberHelper

	describe '#number_to_currency' do

		context 'using default values' do

			it "correctly formats an integer" do
                expect(number_to_currency(2000)).to eq('$2,000.00')
                expect(number_to_currency(200)).to eq('$200.00')
                expect(number_to_currency(20)).to eq('$20.00')
                expect(number_to_currency(2)).to eq('$2.00')
            end

			it "correctly formats a float" do
                expect(number_to_currency(2.6)).to eq('$2.60')
                expect(number_to_currency(20.5)).to eq('$20.50')
                expect(number_to_currency(200.8)).to eq('$200.80')
                expect(number_to_currency(2000.911)).to eq('$2,000.91')
            end

			it "correctly formats a string" do
                expect(number_to_currency('2')).to eq('$2.00')
                expect(number_to_currency('20.11')).to eq('$20.11')
                expect(number_to_currency('2000.119')).to eq('$2,000.11')
            end

			it "uses delimiters for very large numbers" do
                expect(number_to_currency(1234567890)).to eq('$1,234,567,890.00')
                expect(number_to_currency('1234567890.119')).to eq('$1,234,567,890.11')
            end

			it "does not have delimiters for small numbers" do
                expect(number_to_currency(99)).to eq('$99.00')
                expect(number_to_currency(1)).to eq('$1.00')
                expect(number_to_currency('100.11')).to eq('$100.11')
            end

		end

		context 'using custom options' do

			it 'allows changing the :unit' do
                expect(number_to_currency(99, {:unit => '%'})).to eq('%99.00')
                expect(number_to_currency(99, {:unit => '#'})).to eq('#99.00')
                expect(number_to_currency(99, {:unit => '?'})).to eq('?99.00')
            end

			it 'allows changing the :precision' do
                expect(number_to_currency(99, {:precision => 3})).to eq('$99.000')
                expect(number_to_currency(99.0004, {:precision => 4})).to eq('$99.0004')
            end

			it 'omits the separator if :precision is 0' do
                expect(number_to_currency(99, {:precision => 0})).to eq('$99')
            end

			it 'allows changing the :delimiter' do
                expect(number_to_currency(9999, {:delimiter => '|'})).to eq('$9|999.00')
                expect(number_to_currency(11119999, {:delimiter => '*'})).to eq('$11*119*999.00')
            end

			it 'allows changing the :separator' do
                expect(number_to_currency(111.19999, {:separator => ';'})).to eq('$111;19')
                expect(number_to_currency(111.20, {:separator => '!'})).to eq('$111!20')
            end

			it 'correctly formats using multiple options' do
                expect(number_to_currency(999555111.123456, {:unit => '%', :precision => 5, :delimiter => '|', :separator => '~'})).to eq('%999|555|111~12345')
            end

		end

	end

end
