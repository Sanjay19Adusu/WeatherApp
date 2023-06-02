//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherDetails: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var latitude = 10.0
    var longitude = 10.0
    var weatherVM = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        onLoadVC()
    }
    
    func onLoadVC() {
        containerView.layer.cornerRadius = containerView.frame.width/2
        containerView.backgroundColor = .yellow
        weatherType.textColor = .blue
        weatherDetails.textColor = .gray
        weatherVM.fetchWeatherData(lat: latitude, lng: longitude) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let weatherData = data.first
                if let weatherMain = weatherData?.weather?[0] {
                    self.weatherType.text = weatherMain.main
                    self.weatherDetails.text = weatherMain.description
                }
            }
        }
    }
}
