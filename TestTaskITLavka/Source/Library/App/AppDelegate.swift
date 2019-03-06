//
//  AppDelegate.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 05.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let MAPKIT_API_KEY = "8dcb3eee-707f-4636-93cf-53f11647e730"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey(MAPKIT_API_KEY)
        
        return true
    }
}

