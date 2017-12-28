#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'awesome_print'
require 'progress_bar'
require 'open-uri'
require 'fileutils'

PATH_PREFIX = 'imgs/'

URLS={
  'Disney': 'http://www.collectibleminifigs.com/disney-minifigures.asp',
  'Series 1': 'http://www.collectibleminifigs.com/series.asp?s=1',
  'Series 2': 'http://www.collectibleminifigs.com/series.asp?s=2',
  'Series 3': 'http://www.collectibleminifigs.com/series.asp?s=3',
  'Series 4': 'http://www.collectibleminifigs.com/series.asp?s=4',
  'Series 5': 'http://www.collectibleminifigs.com/series.asp?s=5',
  'Series 6': 'http://www.collectibleminifigs.com/series.asp?s=6',
  'Series 7': 'http://www.collectibleminifigs.com/series.asp?s=7',
  'Series 8': 'http://www.collectibleminifigs.com/series.asp?s=8',
  'Series 9': 'http://www.collectibleminifigs.com/series.asp?s=9',
  'Series 10': 'http://www.collectibleminifigs.com/series.asp?s=10',
  'Series 11': 'http://www.collectibleminifigs.com/series.asp?s=11',
  'Series 12': 'http://www.collectibleminifigs.com/series.asp?s=12',
  'Series 13': 'http://www.collectibleminifigs.com/series.asp?s=13',
  'Series 14': 'http://www.collectibleminifigs.com/series.asp?s=14',
  'Series 15': 'http://www.collectibleminifigs.com/series.asp?s=15',
  'Series 16': 'http://www.collectibleminifigs.com/series.asp?s=16',
  'Olympics': 'http://www.collectibleminifigs.com/series-teambg-olympics.asp',
  'LEGO Movie': 'http://www.collectibleminifigs.com/lego-movie-minifig-series.asp',
  'Simpsons I': 'http://www.collectibleminifigs.com/simpsons-minifigures.asp',
  'Simpsons II': 'http://www.collectibleminifigs.com/simpsons-minifigures-series-2.asp'
}


URLS.each do |collection, url|
  puts "Fetching images from collection #{collection}"
  img_directory = "#{PATH_PREFIX}/#{collection}"
  FileUtils::mkdir_p img_directory
  page = Nokogiri::HTML(open(url))
  imgs = page.css('td.small a img')
  bar = ProgressBar.new(imgs.count)
  imgs.each do |img|
    img_src = img['src']
    img_filename = File.basename(img_src)
    img_path = "#{img_directory}/#{img_filename}"
    File.open(img_path, 'wb') do |image_object|
      image_object.write open(img_src).read
      bar.increment!1
    end
  end

end
