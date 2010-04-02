class InsertInto

  require 'rubygems'
  require 'hpricot'

  attr_reader :insert_text, :into_text, :target_tag, :type

  def initialize
    @insert_text = ""
    @into_text = Hpricot("")
    @target_tag = ""
    @type = :between
  end

  def insert insert_text
    @insert_text = insert_text
    self
  end

  def into into_text
    @into_text = Hpricot(into_text)
    self
  end

  def into_text
    @into_text.to_s.gsub(/[ \n]/,'')
  end

  def between_tag target_tag
    @target_tag = target_tag
    @type = :between
    self
  end

  def before_tag target_tag
    @target_tag = target_tag
    @type = :before
    self
  end

  def after_tag target_tag
    @target_tag = target_tag
    @type = :after
    self
  end

  def process
    return @insert_text << into_text if @target_tag.empty?
    @into_text.search(@target_tag) do |node|
      if @type == :after
        node.after insert_text
      elsif @type == :before
        node.before insert_text
      else
        node.inner_html insert_text
      end
    end
    into_text
  end

end
