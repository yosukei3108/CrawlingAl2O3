# -*- coding: utf-8 -*-

# =~ で正規表現にマッチした位置 (0-origin)
"abc123" =~ /[a-z]/       # => 0
"abc123" =~ /\d/          # => 3
"abc123" =~ /\d+/         # => 3 (直前の部分式について、* は 0 回以上、+ は 1 回以上の繰り返し、? は 0 回か 1 回のいずれか)

# 正規表現にマッチした文字列
"abc123"[/\d/]            # => "1"
"abc123"[/\d+/]           # => "123"

# 以下は空文字にマッチしてしまう？ので注意 (よくわかってない)
"abc123"[/\d?/]           # => ""
"abc123"[/\d*/]           # => ""
"abc123"[/(\d)*/]         # => ""

# マッチしない場合は nil が返る
"abc"[/\d/]               # => nil

# 以下はマッチする
"123"[/\d*/]              # => "123"
"123"[/\d+/]              # => "123"
"123"[/\d?/]              # => "1"
"abc123"[/\d.?/]          # => "12"
"abc123"[/\d.*/]          # => "123"
"abc123"[/\d.+/]          # => "123"
"abc123"[/[a-z]/]         # => "a"
"abc123"[/[a-z]*/]        # => "abc"
"abc123"[/[a-z]+/]        # => "abc"

# 最初に () にマッチした文字列？
"abc123cde567"[/^[a-z]+(\d+)/, 1]   # => "123"

# でもこれでは 2 番目の数字列にマッチしない
"abc123cde567"[/^[a-z]+(\d+)/, 2]   # => nil

# 0 にしたらこうなった？？？
"abc123cde567"[/^[a-z]+(\d+)/, 0]   # => "abc123"

# 繰り返しは最左最長一致になる
# 繰り返し { , } やそれを表すメタ文字に更に ? を加えると、最短一致にできる
"abc123"[/(.?).+/, 1]                  # => "a"
"abc123"[/(.??).+/, 1]                 # => ""
"abc123"[/(.+).+/, 1]                  # => "abc12"
"abc123"[/(.+?).+/, 1]                 # => "a"

# 置換には String#sub, String#gsub を使う
"abc123".sub(/abc/, 'def')             # => "def123"
"abc123".sub(/[a-z]+/) {|s| s.upcase}  # => "ABC123" # ブロック付きメソッド呼び出し？

# HTML から最短一致でリンクを取り出す例
html = '<a href="a.html"> a </a><a href="b.html"> b </a>'
html[%r!<a href="(.+?)">(.+?)</a>!, 1] # => "a.html"

# 最長一致だとこうなっちゃう
html[%r!<a href="(.+)">(.+)</a>!, 1]   # => "a.html\"> a </a><a href=\"b.html"

# "b.html" の取り出し方がわかんない。。。。