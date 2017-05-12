require 'net/http'
require 'uri'
require 'json'

class Codic

  @@API_URL = "https://api.codic.jp/v1/engine/translate.json"

  # コンストラクタ
  # CodicAPIのキーで生成 指定がない場合環境変数を参照する
  def initialize(api_key = nil)
    @api_key = api_key || ENV['CODICAPI']
    request(@@API_URL, {:text => '認証'})
  end

  # 翻訳する
  # 指定した日本語に基いて、Codicを用いて翻訳した結果を戻す
  def translate(text)
    result = request(@@API_URL, {:text => text})
    result[0]["translated_text"] if result.count > 0 && result[0].include?("translated_text")
  end

  private
    # HTTPリクエストを送信し、レスポンスJSONを戻す
    def request(url, params = {})
      uri = URI.parse(appendQueryString(url, params))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Get.new(uri.request_uri)
      req["Authorization"] = "Bearer #{@api_key}"
      res = https.request(req)
      JSON.parse(res.body)
    end
    # URLにクエリストリングを付与する
    def appendQueryString(url, params = {})
      query_string = params.map {|key, val| "#{key}=#{URI.escape(val)}"}.join("&")
      url += "?#{query_string}" if query_string
      return url
    end

end
