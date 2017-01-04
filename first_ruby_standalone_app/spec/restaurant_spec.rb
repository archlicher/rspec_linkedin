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
      #can use crescent
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
      expect(Restaurant.file).to be_nil

      rest = Restaurant.new
      expect(rest.save).to be false
    end

    it 'returns false if not valid' do
      Restaurant.load_file(test_file)

      expect(Restaurant.file).not_to be_nil
      expect(subject.save).to be false
    end

    it 'calls append on @@file if valid' do
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      expect(Restaurant.file).to receive(:append).with(crescent)
      crescent.save
    end

  end

  describe '#valid?' do

    it 'returns false if name is nil' do
      crescent.name = nil
      expect(crescent.valid?).to be false
      expect(crescent.name).to eq(nil)
    end

    it 'returns false if name is blank' do
      crescent.name = ' '
      expect(crescent.valid?).to be false
      expect(crescent.name).to be_blank
    end

    it 'returns false if cuisine is nil' do
      crescent.cuisine = nil
      expect(crescent.valid?).to be false
      expect(crescent.cuisine).to eq(nil)
    end

    it 'returns false if cuisine is blank' do
      crescent.cuisine = '  '
      expect(crescent.valid?).to be false
      expect(crescent.cuisine).to be_blank
    end

    it 'returns false if price is nil' do
      crescent.price = nil
      expect(crescent.valid?).to be false
      expect(crescent.price).to be_nil
    end

    it 'returns false if price is 0' do
      crescent.price = 0
      expect(crescent.valid?).to be false
      expect(crescent.price).to eq(0)
    end

    it 'returns false if price is negative' do
      crescent.price = -1
      expect(crescent.valid?).to be false
      expect(crescent.price).to be < 0
    end

    it 'returns true if name, cuisine, price are present' do
      expect(crescent.valid?).to be true
    end

  end

end
