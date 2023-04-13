//
//  WeatherManager.swift
//  ClimaProj
//
//  Created by Yelena Gorelova on 04.04.2023.
//

import Foundation


protocol WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  func didFailWithError(error: Error)
}

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4fce55a4c1fa801c2176c5cbbf45a10a&units=metric"

  var delegate: WeatherManagerDelegate?

  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    perfomRequest(with: urlString)
  }


  func perfomRequest(with urlString: String) {
    //1. Create a URL

    if let url = URL(string: urlString) {
      //2. Create a URLSession

      let session = URLSession(configuration: .default)

      //3. Give the session a task

      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          self.delegate?.didFailWithError(error: error!)
          return
        }

        if let safeData = data {
          if let weather = self.parseJSON(safeData) {
            self.delegate?.didUpdateWeather(self, weather: weather)
          }
        }
      }
      //4. Start the task

      task.resume()
    }
  }


  func parseJSON(_ weatherData: Data) -> WeatherModel? {

    let decoder = JSONDecoder()

    do {

     let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
      let id = decodedData.weather[0].id
      let temp = decodedData.main.temp
      let name = decodedData.name

      let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weather

      print(weather.temperatureString)
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }


}
