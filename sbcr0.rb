# -*- coding: utf-8 -*-

# irb

page_source = open("samplepage.html", &:read)
# => "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\d\">\n<!--...

dates = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)
# => [["2014", "2", "21"], ["2014", "2", "20"], ["2014", "2", "14"], ["2014", "2", "12"], ["2014", "2", "6"], ["2014", "1", "27"], ["], ["2014...

dates[0, 4]
# => [["2014", "2", "21"], ["2014", "2", "20"], ["2014", "2", "14"], ["2014", "2", "12"]]

url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)
# => [["http://www.sbcr.jp/topics/11719/", "最強の布陣で挑む！ GA文庫電子版【俺TUEEEEE】キャンペーン開催中"], ["http://www...

url_titles[0, 4]
# => [["http://www.sbcr.jp/topics/11719/", "最強の布陣で挑む！ GA文庫電子版【俺TUEEEEE】キャンペーン開催中"], ["http://www.sbcr.jp/topics/11712/", "【新刊情報】2014年2月17日～23日　「コンセプト」の作り方がわかるビジネス書など12点"], ["http://www.sbcr.jp/topics/11710/", "『数学ガール』電子書籍版がAmazon Kindleで配信開始！ キャンペーンも同時開催！！"], ["http://www.sbcr.jp/topics/11703/", "【新刊情報】2014年2月10日～16日　アニメ化決定『ワルブレ』最新刊など11点"]]

dates.length
# => 68

url_titles.length
# => 68

dates[0, 4].zip(url_titles[0, 4])
=begin
=> [[["2014", "2", "21"], ["http://www.sbcr.jp/topics/11719/", "最強の布陣で挑む！ GA文庫電子版【俺TUEEEEE】キャンペーン開催
中"]], [["2014", "2", "20"], ["http://www.sbcr.jp/topics/11712/", "【新刊情報】2014年2月17日～23日　「コンセプト」の作り方が
わかるビジネス書など12点"]], [["2014", "2", "14"], ["http://www.sbcr.jp/topics/11710/", "『数学ガール』電子書籍版がAmazon Kindleで配信開始！ キャンペーンも同時開催！！"]], [["2014", "2", "12"], ["http://www.sbcr.jp/topics/11703/", "【新刊情報】2014年
2月10日～16日　アニメ化決定『ワルブレ』最新刊など11点"]]]
=end

Time.local 2014, 2, 20
# => 2014-02-20 00:00:00 +0900

require 'cgi'
# => true

CGI.unescapeHTML "&lt;A&amp;B&gt;"
# => "<A&B>"