#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'pdfkit'

DEFAULT_NAME = '_output.pdf'

def title
  input = (ARGV[0] =~ URI.regexp) ? open(ARGV[0]) : File.read(ARGV[0])
  doc = Nokogiri::HTML(input)
  title = doc.title ? "#{doc.title.strip}.pdf" : DEFAULT_NAME
  puts title
  title
end

if __FILE__ == $0
  input = (ARGV[0] =~ URI.regexp) ? ARGV[0] : File.read(ARGV[0])

  pdf = PDFKit.new(input)
  begin
    pdf.to_file(title)
  rescue
    puts "warning: invalid filename. save to #{DEFAULT_NAME}"
    pdf.to_file(DEFAULT_NAME)
  end
end

