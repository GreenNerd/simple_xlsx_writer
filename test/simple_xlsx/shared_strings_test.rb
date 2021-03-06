require File.join(File.dirname(__FILE__), '..', 'test_helper')
require "rexml/document"
require 'time'

module SimpleXlsx

class SharedStringsTest < Test::Unit::TestCase

  def test_add_string
    str = ''
    io = StringIO.new str
    @content_types = ContentTypes.new(StringIO.new "")
    @relationships = Relationships.new(StringIO.new "")
    @styles = Styles.new()
    doc = Document.new io, @content_types, @relationships, @styles

    ss = SharedStrings.new(io)

    v = (ss << '<t>first test string</t>')
    assert_equal v, 0
    v = (ss << '<t>second test string</t>')
    assert_equal v, 1
    v = (ss << '<t>first test string</t>')
    assert_equal v, 0

    # it's just the fragment
    doc = REXML::Document.new "<sst>#{str}</sst>"
    si = doc.root.elements
    assert_equal 2, si.to_a.size
    assert_equal doc.root.elements['si'].elements['t'].to_a.first, 'first test string'
  end

end

end
