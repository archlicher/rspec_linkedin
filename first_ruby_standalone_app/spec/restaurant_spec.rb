require 'restaurant'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurants_test.txt' }
  let(:crescent) { Restaurant.new(:name => 'Crescent', :cuisine => 'paleo', :price => '321') }

  describe 'attributes' do

    it "allow reading and writing for :name" do
      expect(crescent.name).to eq('Crescent')

      crescent.name = 'Test'
      expect(crescent.name).to eq('Test')

      crescent.name = 'Crescent'
      expect(crescent.name).to eq('Crescent')
    end

    it "allow reading and writing for :cuisine" do
      expect(crescent.cuisine).to eq('paleo')

      crescent.cuisine = 'test'
      expect(crescent.cuisine).to eq('test')

      crescent.cuisine = 'paleo'
      expect(crescent.cuisine).to eq('paleo')
    end

    it "allow reading and writing for :price" do
      expect(crescent.price).to eq('321')

      crescent.price = '123.2'
      expect(crescent.price).to eq('123.2')

      crescent.price = '321'
      expect(crescent.price).to eq('321')
    end

  end

  describe '.load_file' do

    it 'does not set @@file if filepath is nil' do
      no_output { Restaurant.load_file(nil) }
      expect(Restaurant.file).to be_nil
    end

    it 'sets @@file if filepath is usable' do
      no_output { Restaurant.load_file(test_file) }
      expect(Restaurant.file).not_to be_nil
      expect(Restaurant.file.class).to be(RestaurantFile)
      expect(Restaurant.file).to be_usable
    end

    it 'outputs a message if filepath is not usable' do
      expect do
        Restaurant.load_file(nil)
      end.to output(/not usable/).to_stdout
    end

    it 'does not output a message if filepath is usable' do
      expect do
        Restaurant.load_file(test_file)
      end.not_to output.to_stdout
    end

  end

  describe '.all' do

    it 'returns array of restaurant objects from @@file' do
      Restaurant.load_file(test_file)
      restaurants = Restaurant.all
      expect(restaurants.class).to eq(Array)
      expect(restaurants.length).to eq(6)
      expect(restaurants.first.class).to eq(Restaurant)
    end

    it 'returns an empty array when @@file is nil' do
      no_output { Restaurant.load_file(nil) }
      restaurants = Restaurant.all
      expect(restaurants).to eq([])
    end

  end

  describe '#initialize' do

    context 'with no options' do
      # subject would return the same thing
      let(:no_options) { Restaurant.new }

      it 'sets a default of "" for :name' do
        expect(no_options.name).to eq("")
      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(no_options.cuisine).to eq("unknown")
      end

      it 'does not set a default for :price' do
        expect(no_options.price).to eq(nil)
      end
    end

    context 'with custom options' do

      it 'allows setting the :name' do
        rest = Restaurant.new({:name => 'test'})
        expect(rest.name).to eq('test')
      end

      it 'allows setting the :cuisine' do
        rest = Restaurant.new({:cuisine => 'test'})
        expect(rest.cuisine).to eq('test')
      end

      it 'allows setting the :price' do
        rest = Restaurant.new({:price => '123'})
        expect(rest.price).to eq('123')
      end

    end

  end

  describe '#save' do

    it 'returns false if @@file is nil' do
      Restaurant.load_file(nil)
      rest = Restaurant.new
      expect(rest.save).to be false
    end

    it 'returns false if not valid' do
      rest = Restaurant.new({:name => nil})
      expect(rest.save).to be false
    end

    it 'calls append on @@file if valid' do
      rest = Restaurant.new({:name => 'test', :price => '123'})
      allow(rest).to receive(:append).exactly(1)
      rest.save
      expect(rest).to have_received(:append).exactly(1)
    end

  end

  describe '#valid?' do

    it 'returns false if name is nil'

    it 'returns false if name is blank'

    it 'returns false if cuisine is nil'

    it 'returns false if cuisine is blank'

    it 'returns false if price is nil'

    it 'returns false if price is 0'

    it 'returns false if price is negative'

    it 'returns true if name, cuisine, price are present'

  end

end
