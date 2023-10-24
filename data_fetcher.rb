def get_data(currency_array, base)
  data = []
  url = URI("https://api.apilayer.com/exchangerates_data/latest?symbols=#{currency_array}&base=USD")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = ENV['API_KEY']

  response = https.request(request)
  response_hash = JSON.parse(response.body)

  response_hash['rates'].each do |currency, rate|
    item = [currency, rate, 0]
    data.append(item)
  end
  data
end
