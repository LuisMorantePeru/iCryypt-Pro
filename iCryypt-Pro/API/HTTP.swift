//
//  HTTP.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 7/02/24.
//

import Foundation

//17 : Crear un archivo http y crear un enum
enum HTTP {
    
    enum Method : String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
