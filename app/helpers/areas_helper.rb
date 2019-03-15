module AreasHelper
  require 'net/http'
  require 'uri'

  # 郵便番号APIにzipcodeを投げてjson形式のデータを返す
  def get_json(zip)
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?zipcode=#{zip}")
    # HTTPセッションの開始
    Net::HTTP.start(uri.host, uri.port) do |http|
      # Net::HTTPResponseのインスタンスを返す
      http.get(uri.request_uri)
    end
  end
end
