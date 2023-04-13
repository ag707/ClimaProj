//
//  WeatherData.swift
//  ClimaProj
//
//  Created by Yelena Gorelova on 05.04.2023.
//

import Foundation

struct WeatherData: Codable {

  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Codable {

  let temp: Double
}

struct Weather: Codable {
  let id: Int
  let description: String
}
