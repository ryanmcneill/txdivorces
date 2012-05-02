#!/usr/bin/env ruby
require 'mechanize'
require 'open-uri'

#change this to the directory where you'd like to store the files
my_directory = 'E:/Data/DSHS/Divorces/'

#initiate mechanize and get the page
my_agent = Mechanize.new
my_page = my_agent.get "http://www.dshs.state.tx.us/vs/marriagedivorce/dindex.shtm"

#some directory handling here
Dir.chdir(my_directory)

#this section grabs all the links with text matching a four-digit year
#it then saves each one to your hard drive
my_page.links_with(:text => /\d\d\d\d/).each do |link|
  the_link = 'http://www.dshs.state.tx.us/' + "#{link.uri}"
  file_name = "#{my_directory}" + "#{link.text}" + ".zip"
    if File.exists?(file_name)
      puts "File exists --- Will not download #{file_name}"
    else
      puts "No such file"
      puts "Downloading #{link.text}...and saving it as #{file_name}"   
      open("#{file_name}", 'wb') do |fo|
        fo.print open("#{the_link}").read
      end    
    end
end

