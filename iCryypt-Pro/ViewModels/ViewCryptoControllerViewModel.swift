//
//  ViewCryptoControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 31/01/24.
//

import Foundation
import UIKit

//catorceavo : creamos un archivo llamado ViewCryptoControllerViewModel dentro de ViewModels

class ViewCryptoControllerViewModel {
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    // MARK: - Computed Properties
    var rankLabel : String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priceLabel : String {
        return "Price: $\(self.coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel : String {
        return "Market Cap: $\(self.coin.pricingData.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel : String {
        
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        }else {
            return ""
        }
        
    }
}
