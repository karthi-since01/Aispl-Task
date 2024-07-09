//
//  AppDelegate.swift
//  Aispl-Task
//
//  Created by Karthi on 08/07/24.
//

import UIKit
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey("AIzaSyAKB_B9_RXuhnNkpbGuHoYTVp60BjLbsZc")
        
        let vC = WeatherViewController()
        navigationController = UINavigationController(rootViewController: vC)
        navigationController.isNavigationBarHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }

}
