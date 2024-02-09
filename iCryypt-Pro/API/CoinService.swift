//
//  CoinService.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 7/02/24.
//

import Foundation

//20: Llamar a la API real y manejar errores

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknow error ocurred.")
    case decodingError(String = "Error parsing server response.")
}

class CoinService{
    
    //crear funcion para buscar monedas
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping(Result<[Coin], CoinServiceError>)-> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            //Nos muestra un error si la url es desconocida
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            //muestra cualquier tipo de respuesta menos 200
            if let resp = resp as? HTTPURLResponse , resp.statusCode != 200 {
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                } catch let err {
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            //cuando los datos llegan al app , lo decodificamos
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    completion(.success(coinData.data))
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
            } else {
                completion(.failure(.unknown()))
            }
        }.resume()
    }
}
