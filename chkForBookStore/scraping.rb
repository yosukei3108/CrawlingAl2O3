# -*- coding: utf-8 -*-
require 'anemone'
require 'nokogiri'
require 'kconv'

urls = []
urls.push("https://www.amazon.co.jp/gp/bestsellers/digital-text/2293263051/ref=zg_bs_nav_kinc_2_2275256051/355-3307941-7892730")
urls.push("https://www.amazon.co.jp/gp/bestsellers/digital-text/2291657051/ref=zg_bs_nav_kinc_2_2275256051/355-3307941-7892730")
urls.push("https://www.amazon.co.jp/gp/bestsellers/books/466298/ref=zg_bs_nav_b_1_b/356-1209185-7393605")
urls.push("https://www.amazon.co.jp/gp/bestsellers/books/466290/ref=zg_bs_nav_b_1_b/356-1209185-7393605")

puts "legend"
puts "category / subcategory"
puts
puts "#Rank"
puts "Title"
puts "ASIN"

Anemone.crawl(urls, :depth_limit => 0) do |anemone|
  anemone.on_every_page do |page|

    doc = Nokogiri::HTML.parse(page.body.toutf8)

    category = doc.xpath(
      "//*[@id='zg_browseRoot']/ul/li/a").text

    sub_category_books = doc.xpath(
      "//*[@id='zg_browseRoot']/ul/ul/li/span").text

    sub_category_digital_text = doc.xpath(
      "//*[@id='zg_browseRoot']/ul/ul/ul/li/span").text

    if category == "本"
      puts "###############################################"
      puts category + " /" + sub_category_books
      puts "###############################################"
    elsif category == "Kindleストア"
      puts "###############################################"
      puts category + " /" + sub_category_digital_text
      puts "###############################################"
    else
      puts "faild to find category"
    end

    # <div class="a-section a-spacing-none aok-ralative">
    items = doc.xpath("//ol[@class=\"a-ordered-list a-vertical\"]/li/span/div")

    items.each {|item|
    # rank
    puts item.xpath("div/span/span").text

    # title
    puts item.xpath("span/a/div").text.strip

    # ASIN (Amazon Standard Identification Number)
    puts item.xpath("span/a").attribute("href").text.match(%r{dp/(.+?)/})[1]

    puts
  }
  puts
  end
end
