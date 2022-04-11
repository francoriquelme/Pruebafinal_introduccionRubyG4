require "uri"
require "net/http"
require "json"

#1 Crear el método request que reciba una url y el api_key y devuelva el hash con los resultados.
api_url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key="
api_key = "LKpqkbounBob3MeAWAeJyQbee0qAWTb0lXCo1lqZ"

def request(api_url, api_key)
    url = api_url + api_key
    url = URI(url)

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true
request = Net::HTTP::Get.new(url)

response = https.request(request)
result = JSON.parse(response.read_body)
end

data = request(api_url, api_key)

#2 Crear un método llamado build_web_page que reciba el hash de respuesta con todos los datos y construya una una página web. 

def build_web_page(data)
    images = data["photos"][0..14].map do |image|
        image["img_src"]
    end
    html = "
    <html>
    <head>
    </head>
    <body>
    <ul>
    "
    images.each do |image|
        html += "<li><img src='#{image}'></li>\n"
    end
    html += "
    </ul>
    </body>
    </html>
    "
    File.write('index.html', html)
end
build_web_page(data)


