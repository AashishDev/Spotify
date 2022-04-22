//
//  SceneDelegate.swift
//  Spotify
//
//  Created by Aashish Tyagi on 4/22/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window =  UIWindow(windowScene: windowScene)
        
        if AuthManager.shared.isSignIn {
            window.rootViewController =  TabBarViewController()
        }
        else {
            let navVC = UINavigationController(rootViewController: WelcomeViewController())
            navVC.navigationBar.prefersLargeTitles = true
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = navVC
        }
           
        window.makeKeyAndVisible()
        self.window = window
    }
}

