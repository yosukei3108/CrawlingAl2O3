# -*- coding: utf-8 -*-
require 'cgi'

def parse(page_source)
  dates = page_source.scan(
    %r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!
  )
  url_titles = page_source.scan(
    %r!^<a href="(.+?)">(.+?)</a><br />!
  )
  url_titles.zip(dates).map{|(aurl, atitle),
  ymd|[CGI.unescapeHTML(aurl),
    CGI.unescapeHTML(atitle), Time.local(*ymd)]
  }
end

x = parse(open("samplepage.html", &:read))
x[0, 4]

# puts(x[0, 4])
=begin
http://www.sbcr.jp/topics/11719/
最強の布陣で挑む！ GA文庫電子版【俺TUEEEEE】キャンペーン開催中
2014-02-21 00:00:00 +0900
http://www.sbcr.jp/topics/11712/
【新刊情報】2014年2月17日～23日　「コンセプト」の作り方がわかるビジネス書など12点
2014-02-20 00:00:00 +0900
http://www.sbcr.jp/topics/11710/
『数学ガール』電子書籍版がAmazon Kindleで配信開始！ キャンペーンも同時開催！！
2014-02-14 00:00:00 +0900
http://www.sbcr.jp/topics/11703/
【新刊情報】2014年2月10日～16日　アニメ化決定『ワルブレ』最新刊など11点
2014-02-12 00:00:00 +0900
=end

def format_text(title, url, url_title_time_ary)
  s = "Title: #{title}\nURL: #{url}\n\n"
  url_title_time_ary.each do |aurl, atitle, atime|
    s << "* (#{atime})#{atitle}\n"
    s << "    #{aurl}\n"
  end
  s
end

puts format_text("WWW.SBCR.JP トピックス",
  "https://crawler.sbcr.jp/samplepage.html",
  parse(open("samplepage.html", &:read)))
