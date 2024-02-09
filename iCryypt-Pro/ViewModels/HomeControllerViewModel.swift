//
//  HomeControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 7/02/24.
//

import Foundation

//21 : Se llama a la API para el consumo de datos

class HomeControllerViewModel {
    
    //Devolución de llamada opcional
    var onCoinsUpdated : (()->Void)?
    var onErrorMessage : ((CoinServiceError)->Void)?
    
    //Conjunto de monedas privadas para acceder a sus propiedades
    private(set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    init() {
        self.fetchCoins()
        
        //self.coins.insert(Coin, id: Int, name: String, maxSupply: String, rank: Int, princingData: Data, logoURL: URL?, at:Int)
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
            
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
    
}
