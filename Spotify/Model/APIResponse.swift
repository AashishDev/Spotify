//
//  APIResponse.swift
//  Spotify
//
//  Created by Aashish Tyagi on 4/22/22.
//

import Foundation

struct APIResponse:Codable {
    
    let access_token:String
    let refresh_token:String?
    let expires_in:Int
    let scope:String
    let token_type:String
}


