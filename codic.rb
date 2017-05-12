require 'net/http'
require 'uri'

class Codic

  @@API_URL = URI.parse("https://api.codic.jp/v1/engine/translate.json")

  # コンストラクタ
  # CodicAPIのキーで生成 指定がない場合環境変数を参照する
  def initialize(api_key = nil)
    @api_key = api_key || ENV['CODICAPI']
  end

  private
    # HTTPリクエストを送信し、レスポンスJSONを戻す
    def request(url, params = {})
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.request_uri)
      res = https.request(req)
      puts res.body
    end

end
