describe 'String' do

	describe "#titleize" do

		it "capitalizes each word in a string" do
            expect("this is test string".titleize).to eq("This Is Test String")
        end

		it "works with single-word strings" do
            expect("test".titleize).to eq("Test")
        end

		it "capitalizes all uppercase strings" do
            expect("THIS IS TEST STRING".titleize).to eq("This Is Test String")
        end

		it "capitalizes mixed-case strings" do
            expect("ThIs iS TesT sTRING".titleize).to eq("This Is Test String")
        end

	end

	describe '#blank?' do

		it "returns true if string is empty" do
            empty_string = ""
            expect(empty_string).to be_blank
        end

		it "returns true if string contains only spaces" do
            empty_string = "    "
            expect(empty_string).to be_blank
        end

		it "returns true if string contains only tabs" do
		# Get a tab using a double-quoted string with \t
		# example: "\t\t\t"
            empty_string = "\t\t\t"
            expect(empty_string).to be_blank
        end

		it "returns true if string contains only spaces and tabs" do
            empty_string = "\t  \t \t  "
            expect(empty_string).to be_blank
        end

		it "returns false if string contains a letter" do
            expect("a").not_to be_blank
        end

		it "returns false if string contains a number" do
            expect("1").not_to be_blank
        end

	end

end
