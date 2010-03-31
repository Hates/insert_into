require 'spec_helper'

describe InsertInto do

  it "should initialize insert text as an empty string" do
    ii = InsertInto.new
    ii.insert_text.should == ""
  end

  it "should initialize the text to be inserted" do
    ii = InsertInto.new.insert("test")
    ii.insert_text.should == "test"
  end

  it "should initialize into text as an empty string" do
    ii = InsertInto.new
    ii.into_text.should == ""
  end

  it "should initialize the text to be inserted into" do
    ii = InsertInto.new.into("<into/>")
    ii.into_text.should == "<into/>"
  end

  it "should initialize the target tag as an empty string" do
    ii = InsertInto.new
    ii.target_tag.should == ""
  end

  it "should initialize the target tag to be inserted into" do
    ii = InsertInto.new.between_tag("test")
    ii.target_tag.should == "test"
  end

  it "should initialize multiple values" do
    ii = InsertInto.new.insert("insert").into("<into/>").between_tag("tag")
    ii.insert_text.should == "insert"
    ii.into_text.should == "<into/>"
    ii.target_tag.should == "tag"
  end

  it "should insert text into an empty string" do
    result = InsertInto.new.insert("insert").into("").process
    result.should == "insert"
  end

  it "should insert text before a string if no target tag is supplied" do
    result = InsertInto.new.insert("insert").into("<into/>").process
    result.should == "insert<into/>"
  end

  it "should insert text into a string if target tag is supplied" do
    result = InsertInto.new.insert("insert").into("<into/>").between_tag("into").process
    result.should == "<into>insert</into>"
  end

  it "should insert text multiple times into a string if target tag is supplied" do
    result = InsertInto.new.insert("insert").into("<wrapper><into/><into/></wrapper>").between_tag("into").process
    result.should == "<wrapper><into>insert</into><into>insert</into></wrapper>"
  end

end
