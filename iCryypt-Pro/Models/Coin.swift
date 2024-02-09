//
//  Coin.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 29/01/24.
//

import Foundation

//16 paso : se agrega un struct ya que el json viene en una matriz , por eso se colocar[a de la siguiente manera

struct CoinArray: Decodable {
    let data : [Coin]
}

//Segundo Paso
struct Coin : Codable{
    
    let id : Int
    let name : String
    let maxSupply: Int?
    let rank : Int
    let pricingData: PricingData
    
    //noveno paso : agregar imagen por url
    var logoURL:URL? {
        return URL(string : "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    //quinceavo : enumeramos las variables si queremos que el nombre de la variable sea diferente en swift de su API
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
    
}

struct PricingData: Codable {
    let CAD: CAD
}

struct CAD: Codable {
    let price: Double
    let market_cap: Double
}
