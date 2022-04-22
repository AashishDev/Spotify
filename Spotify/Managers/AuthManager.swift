//
//  AuthManager.swift
//  Spotify
//
//  Created by Aashish Tyagi on 4/22/22.
//

import Foundation

final class AuthManager {
   
    static let shared = AuthManager()
    private init() {}
    
    
    public var signInUrl:URL? {
        
        let scope = "user-read-private"
        let redirect = "http://localhost:8888/callback"
        let base = "https://accounts.spotify.com/authorize"
        let string =  "\(base)?response_type=code&client_id=\(Constant.clientID)&scope=\(scope)&redirect_uri=\(redirect)&state=123&show_dialog=TRUE"
        return URL(string: string)
    }
    
    
    var isSignIn :Bool {
        return accessToken != nil
    }
    
    private var accessToken:String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken:String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate:Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes:TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >=  expirationDate
    }
    
    
    func exchangeCodeForAccessToken(
        code:String,
        completion: @escaping ((Bool) -> Void)) {
        
            //Get Token
            guard let url = URL(string:Constant.tokenURL) else {
                completion(false)
                return
            }
            
         var components = URLComponents()
            components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            
            URLQueryItem(name: "code",
                         value: code),
            
            URLQueryItem(name: "redirect_uri",
                         value: "http://localhost:8888/callback")
            
            ]
            
            let basicToken =   Constant.clientID+":"+Constant.clientSecret
            let data =  basicToken.data(using: .utf8)
            guard let base64String =  data?.base64EncodedString() else {
                print("Error in Base64 string")
                completion(false)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody =  components.query?.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
            
           let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
               do {
                   let result = try JSONDecoder().decode(APIResponse.self, from: data)
                   self?.cacheToken(result: result)
                   completion(true)
               }
               catch {
                   print(error)
               }
            }
            task.resume()
    }
    
    func cacheToken(result:APIResponse) {
        UserDefaults.standard.set(result.access_token, forKey: "access_token")
        UserDefaults.standard.set(result.access_token, forKey: "refresh_token")
        
        let date = Date().addingTimeInterval(TimeInterval(result.expires_in))
        UserDefaults.standard.set(date, forKey: "expirationDate")
    }
    
    func refreshAccessToken() {
        
    }
    
}
