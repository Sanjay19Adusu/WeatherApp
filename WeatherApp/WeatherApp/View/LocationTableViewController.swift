//
//  LocationTableViewController.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import UIKit
import CoreLocation

class LocationTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var locationVM = LocationViewModel()
    var locationData = [LocationModel]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchLocations(keyword: locationVM.fetchSearchedKey())
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
        cell.name.text = locationData[indexPath.row].name
        cell.address.text = "\(locationData[indexPath.row].state), \(locationData[indexPath.row].country)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let weatherVC = storyBoard.instantiateViewController(withIdentifier: "weatherVC") as! WeatherViewController
        if let latitude = locationData[indexPath.row].lat, let longitude = locationData[indexPath.row].lon {
            weatherVC.latitude = latitude
            weatherVC.longitude = longitude
        }
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
    
    //Search Bar for sending the location keyword
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text {
            fetchLocations(keyword: keyword)
        }
    }
    
    func fetchLocations(keyword: String) {
        locationVM.fetchLocations(keyword: keyword, limit: 10) { data in
            self.locationData = data
            self.tableView.reloadData()
            self.locationVM.storeSearchedKey(keyword: keyword)
        }
    }
}
