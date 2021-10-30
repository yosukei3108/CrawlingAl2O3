# -*- coding: utf-8 -*-
require 'anemone'

urls = [
  "https://www.amazon.co.jp/gp/bestsellers/books/",
  "https://www.amazon.co.jp/gp/bestsellers/digital-text/2275256051/"]

# Anemone.crawl (urls) do |anemone|
Anemone.crawl(urls, :depth_limit => 1, :skip_query_strings => true) do |anemone|
# Anemone.crawl (urls, {:depth_limit => 0, :skip_query_strings => true,}) do |anemone|


  anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(
        /\/gp\/bestsellers\/books|\/gp\/bestsellers\/digital-text/)
    }
  end

  PATTERN =
    %r[466298\/+|466290\/+|2291657051\/+|2293263051\/+]
  anemone.on_pages_like(PATTERN) do |page|
    puts page.url
  end
end
