class InsertInto

  require 'rubygems'
  require 'nokogiri'

  attr_reader :insert_text, :into_text, :target_tag

  def initialize
    @insert_text = ""
    @into_text = Nokogiri::XML.parse("")
    @target_tag = ""
  end

  def insert insert_text
    @insert_text = insert_text
    self
  end

  def into into_text
    @into_text = Nokogiri::XML.parse(into_text)
    self
  end

  def into_text
    @into_text.root.to_s.gsub(/[ \n]/,'')
  end

  def between_tag target_tag
    @target_tag = target_tag
    self
  end

  def process
    return @insert_text << into_text if @target_tag.empty?
    @into_text.search("//#{@target_tag}").each do |node|
      node.content = @insert_text
    end
    into_text
  end

end
