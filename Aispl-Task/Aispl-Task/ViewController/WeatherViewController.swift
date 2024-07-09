//
//  WeatherViewController.swift
//  Aispl-Task
//
//  Created by Karthi on 08/07/24.
//

import UIKit
import Foundation
import GooglePlaces
import Alamofire
import AlamofireImage
import CoreLocation
import RealmSwift

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    var placesClient: GMSPlacesClient!
    var autocompleteResults = [GMSAutocompletePrediction]()
    var locationManager: CLLocationManager!
    var searchDetailsText: String?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var optionImage: UIImageView = {
        let optionView = UIImageView()
        optionView.contentMode = .scaleAspectFill
        optionView.image = UIImage(named: "option")
        return optionView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.delegate = self
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.center = rightView.center
        rightView.addSubview(imageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationCell")
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.black.cgColor
        return tableView
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Karachi"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var dayDateLabel: UILabel = {
        let label = UILabel()
        label.text = "MONDAY 7:00 PM"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
        let optionView = UIImageView()
        optionView.contentMode = .scaleAspectFill
        optionView.backgroundColor = .clear
        return optionView
    }()
    
    lazy var degreeAndNameView = DegreeAndNameView()
    lazy var bottomView = BottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        placesClient = GMSPlacesClient.shared()
        listTableView.isHidden = true
        setupUi()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        checkLocationAuthorization()
    }
    
    func setupUi() {
        view.addSubview(containerView)
        containerView.addSubviews(with: [optionImage, searchTextField, listTableView, locationLabel, dayDateLabel, weatherImage, degreeAndNameView, bottomView])
        containerView.bringSubviewsToFront(with: [listTableView])
        
        containerView.top == view.safeAreaLayoutGuide.topAnchor
        containerView.bottom == view.bottom
        containerView.leading == view.leading
        containerView.trailing == view.trailing
        
        optionImage.top == containerView.top + .ratioHeightBasedOniPhoneX(15)
        optionImage.leading == containerView.leading + .ratioHeightBasedOniPhoneX(15)
        optionImage.height == .ratioHeightBasedOniPhoneX(25)
        optionImage.width == .ratioHeightBasedOniPhoneX(25)
        
        searchTextField.top == containerView.top + .ratioHeightBasedOniPhoneX(15)
        searchTextField.leading == optionImage.trailing + .ratioHeightBasedOniPhoneX(15)
        searchTextField.height == .ratioHeightBasedOniPhoneX(30)
        searchTextField.trailing == containerView.trailing - .ratioHeightBasedOniPhoneX(15)
        
        listTableView.top == searchTextField.bottom
        listTableView.leading == optionImage.trailing + .ratioHeightBasedOniPhoneX(15)
        listTableView.trailing == containerView.trailing - .ratioHeightBasedOniPhoneX(15)
        listTableView.height == .ratioHeightBasedOniPhoneX(250)
        
        locationLabel.top == containerView.top + .ratioHeightBasedOniPhoneX(60)
        locationLabel.centerX == containerView.centerX
        locationLabel.height == .ratioHeightBasedOniPhoneX(50)
        locationLabel.leading == containerView.leading + .ratioHeightBasedOniPhoneX(15)
        locationLabel.trailing == containerView.leading - .ratioHeightBasedOniPhoneX(15)
        
        dayDateLabel.top == locationLabel.bottom + .ratioHeightBasedOniPhoneX(5)
        dayDateLabel.centerX == containerView.centerX
        dayDateLabel.height == .ratioHeightBasedOniPhoneX(30)
        dayDateLabel.width == .ratioHeightBasedOniPhoneX(150)
        
        weatherImage.top == dayDateLabel.bottom + .ratioHeightBasedOniPhoneX(25)
        weatherImage.centerX == containerView.centerX
        weatherImage.height == .ratioHeightBasedOniPhoneX(200)
        weatherImage.width == .ratioHeightBasedOniPhoneX(200)
        
        degreeAndNameView.height == .ratioHeightBasedOniPhoneX(200)
        degreeAndNameView.width == .ratioHeightBasedOniPhoneX(200)
        degreeAndNameView.top == weatherImage.bottom + .ratioHeightBasedOniPhoneX(10)
        degreeAndNameView.centerX == containerView.centerX
        
        bottomView.height == .ratioHeightBasedOniPhoneX(200)
        bottomView.top == degreeAndNameView.bottom + .ratioHeightBasedOniPhoneX(10)
        bottomView.leading == containerView.leading
        bottomView.trailing == containerView.trailing
        bottomView.centerX == containerView.centerX
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            fetchLastStoredPlaceFromRealm()
        @unknown default:
            fatalError("Unknown authorization status.")
        }
    }
    
    func fetchLastStoredPlaceFromRealm() {
        let realm = try! Realm()
        let recentPlaces = realm.objects(Place.self)
        if let lastPlace = recentPlaces.last {
            self.searchDetailsText = lastPlace.name
            print(lastPlace.name)
            getLocationDetails()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text, !query.isEmpty else {
            self.autocompleteResults = []
            self.listTableView.isHidden = true
            self.listTableView.reloadData()
            return
        }
        
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        
        placesClient.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error)")
                return
            }
            
            self.autocompleteResults = results ?? []
            self.listTableView.isHidden = false
            self.listTableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.searchDetailsText = searchTextField.text
        getLocationDetails()
        return true
    }
    
    func getLocationDetails() {
        
        let endPoint = "https://api.weatherapi.com/v1/current.json?key=d5d03b2aa8d94e6eb52135020242806&q=\(self.searchDetailsText ?? "")&aqi=no"
        
        GenericAPI.getRequest(url: endPoint) { (result: Result<WeatherModel, Error>) in
            switch result {
            case .success(let weatherModel):
                DispatchQueue.main.async {
                    self.locationLabel.text = weatherModel.location.name
                    self.dayDateLabel.text = weatherModel.location.localtime
                    self.degreeAndNameView.degreeLabel.text = "\(weatherModel.current.tempC)°c"
                    self.bottomView.windMeasureLabel.text = "\(weatherModel.current.windMph) m/s"
                    self.bottomView.tempMeasureLabel.text = "\(weatherModel.current.tempF)°"
                    if let iconURL = URL(string: "https:\(weatherModel.current.condition.icon)") {
                        self.weatherImage.af.setImage(withURL: iconURL)
                    }
                    self.degreeAndNameView.updateWishLabel(with: weatherModel.location.localtime)
                    let realm = try! Realm()
                    try! realm.write {
                        let place = Place()
                        place.name = weatherModel.location.name
                        realm.add(place)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.locationLabel.text = "Error fetching data"
                    self.dayDateLabel.text = ""
                    print("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let realm = try! Realm()
            let recentPlaces = realm.objects(Place.self)
            let count = min(recentPlaces.count, 3)
            return count
        case 1:
            return autocompleteResults.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationTableViewCell
        switch indexPath.section {
        case 0:
            let realm = try! Realm()
            let recentPlaces = realm.objects(Place.self)
            let index = recentPlaces.count - indexPath.row - 1
            if index >= 0 && index < recentPlaces.count {
                let place = recentPlaces[index]
                cell.headingLabel.text = place.name
                cell.subheadingLabel.text = ""
            }
        case 1:
            let result = autocompleteResults[indexPath.row]
            let placeID = result.placeID
            GMSPlacesClient.shared().lookUpPlaceID(placeID) { (place, error) in
                if let error = error {
                    print("Error fetching place details: \(error)")
                    return
                }
                if let place = place {
                    cell.headingLabel.text = place.name
                    cell.subheadingLabel.text = place.formattedAddress
                }
            }
        default:
            cell.headingLabel.text = ""
            cell.subheadingLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Recent Search"
        case 1:
            return "Suggestions"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let realm = try! Realm()
            let recentPlaces = realm.objects(Place.self)
            let index = recentPlaces.count - indexPath.row - 1
            if index >= 0 && index < recentPlaces.count {
                let place = recentPlaces[index]
                DispatchQueue.main.async {
                    self.searchTextField.text = place.name
                    self.listTableView.isHidden = true
                }
            }
            break
        case 1:
            let result = autocompleteResults[indexPath.row]
            let placeID = result.placeID
            placesClient.lookUpPlaceID(placeID) { (place, error) in
                if let error = error {
                    print("Error fetching place details: \(error.localizedDescription)")
                    return
                }
                
                if let place = place {
                    DispatchQueue.main.async {
                        self.searchTextField.text = place.name
                        self.listTableView.isHidden = true
                    }
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 35
        case 1:
            return 50
        default:
            return 55
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Error in reverse geocoding: \(error.localizedDescription)")
                    return
                }
                if let placemark = placemarks?.first, let placeName = placemark.locality {
                    DispatchQueue.main.async {
                        self.locationLabel.text = placeName
                        self.searchDetailsText = placeName
                        self.getLocationDetails()
                    }
                }
            }
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.locationLabel.text = ""
            self.showLocationAlert()
        }
    }
    
    func showLocationAlert() {
        let alertController = UIAlertController(title: "Location Services Disabled", message: "Please enable location services in Settings to get your current location.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
