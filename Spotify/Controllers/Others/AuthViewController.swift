//
//  AuthViewController.swift
//  Spotify
//
//  Created by Aashish Tyagi on 4/22/22.
//

import UIKit
import WebKit

class AuthViewController: UIViewController,WKNavigationDelegate {
   
    public var completionHandler: ((Bool)-> Void)?

    private let webView:WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let config =  WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "SignIn"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signInUrl else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame =  view.bounds
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        //Exchange Code with Access token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
        
        webView.isHidden = true
        print("Code : \(code)")
        AuthManager.shared.exchangeCodeForAccessToken(code: code) { [weak self] success in
            DispatchQueue.main.async {

            self?.navigationController?.popViewController(animated: true)
            self?.completionHandler?(success)
            }
        }
        
    }
    

}

