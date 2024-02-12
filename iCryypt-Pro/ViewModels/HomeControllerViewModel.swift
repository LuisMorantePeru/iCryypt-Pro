//
//  HomeControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 7/02/24.
//

import Foundation
import UIKit

//21 : Se llama a la API para el consumo de datos

class HomeControllerViewModel {
    
    //Devolución de llamada opcional
    var onCoinsUpdated : (()->Void)?
    var onErrorMessage : ((CoinServiceError)->Void)?
    
    //Conjunto de monedas privadas para acceder a sus propiedades
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    //24 : creando una varable que guardar un array
    private(set) var filteredCoins: [Coin] = []
    
    init() {
        self.fetchCoins()
        
        //self.coins.insert(Coin, id: Int, name: String, maxSupply: String, rank: Int, princingData: Data, logoURL: URL?, at:Int)
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
            
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
    
}

//25: crear una extension para filtar las monedas cuando escribes
// MARK: - Search Functions
extension HomeControllerViewModel {
    //funcion que devuelve un valor booleano
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = allCoins
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {
                self.onCoinsUpdated?();
                return
            }
            
            //filtrar mmonedas por nombre
            self.filteredCoins = self.filteredCoins.filter({
                $0.name.lowercased().contains(searchText)
            })
        }
        
        //26: se llama a este metodo ya que permite que la busqueda de la moneda por nombre se realice
        self.onCoinsUpdated?()
    }
}
