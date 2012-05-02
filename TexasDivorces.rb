#!/usr/bin/env ruby
require 'mechanize'
require 'open-uri'

my_agent = Mechanize.new

#this is the home of the Texas divorces index
my_page = my_agent.get "http://www.dshs.state.tx.us/vs/marriagedivorce/dindex.shtm"

#this section grabs all the links with text matching a four-digit year
#it then saves each one to your hard drive
my_page.links_with(:text => /\d\d\d\d/).each do |link|
  the_link = 'http://www.dshs.state.tx.us/' + "#{link.uri}"
  file_name = "#{link.text}" + ".zip"
  puts "Downloading #{link.text}...and saving it as #{file_name}"
  open("#{file_name}", 'wb') do |fo|
    fo.print open("#{the_link}").read
  end
end