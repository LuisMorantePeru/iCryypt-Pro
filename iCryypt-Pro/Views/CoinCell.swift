//
//  CoinCell.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 29/01/24.
//

//cuarto paso , crear una archivo llamado coincell ,creando las variables , componentes y setup
import UIKit
import SDWebImage

class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCell"
    
    //MARK: - Variables
    private(set) var coin : Coin!
    
    //MARK: - UI Components
    
    private let coinLogo : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    
    private let coinName : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "error"
        return label
    }()
    
    //Quinto paso : inicializando para llamar a la interfaz de usuario setupUI
    //MARK: -Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Sexto paso : setear datos con la variable coin
    
    public func configure(with coin:Coin) {
        self.coin = coin
        self.coinName.text = coin.name
        
        //con la libreria SDWebImage se redujo a una sola linea
        self.coinLogo.sd_setImage(with: coin.logoURL)
        
        /*
        DispatchQueue.global().async {
            //decimo paso : crear una variable para que la imagen llegue por URL
            let imageData = try? Data(contentsOf: self.coin.logoURL!)
            
            //onceavo paso : si dejamos que las imagenes pasen , se empleará el flujo en el hilo principal asíncrono
            if let imageData = imageData {
                DispatchQueue.main.async { [weak self] in
                    self?.coinLogo.image = UIImage(data: imageData)
                }
                
            }
        }
        */
    }
    
    //TODO: PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinName.text = nil
        self.coinLogo.image = nil
    }
    
    //MARK: -UI Setup
    
    private func setupUI() {
        self.addSubview(coinLogo)
        self.addSubview(coinName)
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        //ubicar la celda
        
        NSLayoutConstraint.activate([
            
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),

        ])
    }
}
