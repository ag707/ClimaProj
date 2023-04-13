//
//  ViewController.swift
//  ClimaProj
//
//  Created by Yelena Gorelova on 07.03.2023.
//

import UIKit

class WeatherViewController: UIViewController {

  let backgroundView = UIImageView(image: UIImage(named: "background"))
  var stackViewButtons: UIStackView = {
    var stackViewButtons = UIStackView()

    return stackViewButtons
  }()
  var stackViewLabels = UIStackView()

  var weatherManager = WeatherManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.contentMode = .scaleAspectFill
    view.addSubview(backgroundView)
    backgroundImageConstraints()
    navButtonConstraints()
    conditionImageViewConstraints()
    navigationStackView()
    stackLabelConstraints()
    temperatureStackLabel()
    cityLabelLabelConstraints()
    serachField.delegate = self
    weatherManager.delegate = self


  }


  private lazy var navButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(systemName: "location.circle.fill")
    button.setImage(image, for: .normal)
    button.tintColor = .black


    return button
  }()

  private lazy var searchButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(systemName: "magnifyingglass")
    button.setImage(image, for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)

    return button
  }()

  private lazy var serachField: UITextField = {

    let textField = UITextField()
        textField.placeholder = "Search"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 20)
    textField.backgroundColor = .systemFill
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center



    return textField


  }()


  private func navigationStackView() {
    stackViewButtons.addArrangedSubview(navButton)
    stackViewButtons.addArrangedSubview(serachField)
    stackViewButtons.addArrangedSubview(searchButton)

    stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
    stackViewButtons.axis = .horizontal
    stackViewButtons.distribution = .fill
    stackViewButtons.spacing = 1
    serachField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6).isActive = true

  }


  private lazy var conditionImage: UIImageView = {

          let theImageView = UIImageView()
           theImageView.image = UIImage(systemName: "sun.max")
           theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
          theImageView.tintColor = .black
           return theImageView

  }()


  private lazy var temperatureLabelOne: UILabel = {

    let label = UILabel()
    label.text = "21"
    label.font = UIFont.systemFont(ofSize: 80)


    return label
  }()


  private lazy var temperatureLabelTwo: UILabel = {

    let label = UILabel()
    label.text = "°"
    label.font = UIFont.boldSystemFont(ofSize: 100)

    return label
  }()


  private lazy var temperatureLabelThree: UILabel = {

    let label = UILabel()
    label.text = "C"
    label.font = UIFont.systemFont(ofSize: 100)

    return label
  }()


  private func temperatureStackLabel() {

    stackViewLabels.addArrangedSubview(temperatureLabelOne)
    stackViewLabels.addArrangedSubview(temperatureLabelTwo)
    stackViewLabels.addArrangedSubview(temperatureLabelThree)

    stackViewLabels.translatesAutoresizingMaskIntoConstraints = false
    stackViewLabels.axis = .horizontal
  }


  private lazy var cityLabel: UILabel = {

    let label = UILabel()
    label.text = "London"
    label.font = UIFont.systemFont(ofSize: 30)
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()



  func navButtonConstraints() {

    view.addSubview(stackViewButtons)

    NSLayoutConstraint.activate([

      stackViewButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      stackViewButtons.heightAnchor.constraint(equalToConstant: 40),
      stackViewButtons.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0),
      stackViewButtons.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0)

    ])

  }

  func conditionImageViewConstraints() {

    view.addSubview(conditionImage)
    NSLayoutConstraint.activate([
      conditionImage.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0),
      conditionImage.heightAnchor.constraint(equalToConstant: 120),
      conditionImage.widthAnchor.constraint(equalToConstant: 150),
      conditionImage.topAnchor.constraint(equalTo: stackViewButtons.safeAreaLayoutGuide.topAnchor, constant: 50)


    ])
  }


  func backgroundImageConstraints() {
    NSLayoutConstraint.activate([
      backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      backgroundView.topAnchor.constraint(equalTo: view.topAnchor)

    ])


  }


  func stackLabelConstraints() {

    view.addSubview(stackViewLabels)
    NSLayoutConstraint.activate([
      stackViewLabels.topAnchor.constraint(equalTo: conditionImage.safeAreaLayoutGuide.bottomAnchor, constant: 10),
      stackViewLabels.heightAnchor.constraint(equalToConstant: 119),
      stackViewLabels.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])


  }


  func cityLabelLabelConstraints() {

    view.addSubview(cityLabel)
    NSLayoutConstraint.activate([
      cityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      cityLabel.topAnchor.constraint(equalTo: stackViewLabels.safeAreaLayoutGuide.bottomAnchor, constant: 10),
      cityLabel.widthAnchor.constraint(equalToConstant: 98),
      cityLabel.heightAnchor.constraint(equalToConstant: 36)
    ])


  }

}


// MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate {

  @objc func searchPressed(_ sender: UIButton) {
    serachField.endEditing(true)
    print(serachField.text!)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print(serachField.text!)
    return true
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Type Something"
      return false
    }
  }

  func textFieldDidEndEditing(_ textField: UITextField) {

    if let city = serachField.text {

      weatherManager.fetchWeather(cityName: city)

    }

    serachField.text = ""
  }
}

extension WeatherViewController: WeatherManagerDelegate {


  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {

    DispatchQueue.main.async {
      self.temperatureLabelOne.text = weather.temperatureString
      self.conditionImage.image = UIImage(systemName: weather.conditionName)
      self.cityLabel.text = weather.cityName
    }

  }

  func didFailWithError(error: Error) {
    printContent(error)
  }
}
