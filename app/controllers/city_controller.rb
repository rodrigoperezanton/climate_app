class CityController < ApplicationController
  def results
    @city = params[:city] || "miami"

    weather = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=c38d29204353577f04f9a8b861e3c70e")

    weather = JSON.parse(weather.body)
    if weather["cod"] === "502"
      @is_not_found = true
      @not_found = weather["message"]
    else
      @weather_description = weather["weather"][0]["description"]
      weather_input = @weather_description.gsub!(' ','+')
      @weather_description = @weather_description.gsub!('+',' ').upcase

      weather_temp_current = weather["main"]["temp"] - 273.15
      @weather_temp_current = weather_temp_current.to_i
      # weather_temp_min = weather["main"]["temp_min"] - 273.15
      # weather_temp_max = weather["main"]["temp_max"] - 273.15
      @country_code = weather["sys"]["country"]


      giphy = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{weather_input}&api_key=dc6zaTOxFJmzC")
      giphy = JSON.parse(giphy.body)
      # A) Esta opcion da un random - "sample"- de los gifs
      # giphy = giphy['data'].sample
      # giphy = giphy['images']['original']['url']
      #B) Esta opcion esta asociada siempre al 1er Gif (posicion 0)
      @giphy = giphy['data'][0]['images']['original']['url']
    end

  end
end
