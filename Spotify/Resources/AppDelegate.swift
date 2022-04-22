//
//  AppDelegate.swift
//  Spotify
//
//  Created by Aashish Tyagi on 4/22/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window =  UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController =  TabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

