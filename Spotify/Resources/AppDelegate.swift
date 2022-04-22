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
        
        if AuthManager.shared.isSignIn {
            window.rootViewController =  TabBarViewController()

        }
        else {
            let navVC = UINavigationController(rootViewController: WelcomeViewController())
            navVC.navigationBar.prefersLargeTitles = true
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = navVC
        }
        
        print(AuthManager.shared.signInUrl?.absoluteString)
                        
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

