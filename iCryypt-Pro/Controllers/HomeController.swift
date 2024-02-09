//
//  ViewController.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 28/01/24.
//

import UIKit

//Tercer paso : refactorizar el nombre de viewcontroller a homecontroller cambiando el nombre

class HomeController: UIViewController {
   
    //aqui probamos si ejecuta bien el proyecto
    
    //MARK: - VARIABLES
    private let viewModel : HomeControllerViewModel
    
    //MARK: - UI Components
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    //MARK: - LifeCycle
    //Inicializando ViewModel en HomeController
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //recargar la vista de la tabla
        self.viewModel.onCoinsUpdated = { [weak self] in
            //empleamos el hilo principal para recargar los datos de la tabla (es asíncrono)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        //mostramos mensaje de error en el app
        self.viewModel.onErrorMessage = { [weak self] error in
            //tenemos 3 diferentes tipos de errores mediante la cual se encuentran en enums y se mostrarán en alertas
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.erroMessage
                    
                case .unknown(let string):
                alert.title = "Error Fetching Coins"
                alert.message = string
                    
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                self?.present(alert, animated: true, completion: nil)
                
            }
       
        }
    
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        self.navigationItem.title = "iCryyptPro"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

        ])
    }
    
    //MARK: - Selectors

}

//MARK: - TableView Functions

extension HomeController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier , for:indexPath) as? CoinCell else {
                fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        let coin = self.viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        
        return cell
        
    }
    
    //Altura para las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    //filas
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        //Se pasa los datos al siguiente layout ViewCryptoController donde se muestra el detalle de cada celda
        let coin = self.viewModel.coins[indexPath.row]
        let vm = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

