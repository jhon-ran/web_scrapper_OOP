require_relative '../lib/marie_christmas.rb'

describe "the get_city method" do
  it "should not be nil" do
    expect(get_city()).not_to be_nil
  end

end


describe "the get_email method" do
  it "should not be nil" do
    expect(get_email("")).not_to be_nil
  end

end
