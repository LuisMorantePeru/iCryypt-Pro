//
//  CoinError.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 1/02/24.
//

import Foundation

//17: Creamos un struct cuando devuelve un error

struct CoinError: Decodable {
    let errorCode: Int
    let erroMessage: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
    
    //decodificando los datos
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status =  try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .status)
        
        errorCode = try status.decode(Int.self, forKey: .errorCode)
        erroMessage = try status.decode(String.self, forKey: .errorMessage)
        
    }
}
