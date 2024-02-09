//
//  SceneDelegate.swift
//  iCryypt-Pro
//
//  Created by Luis Morante on 28/01/24.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        //septimo paso : establecer controlador de navegacion UI como controlador de inicio
        window.rootViewController = UINavigationController(rootViewController: HomeController())
        self.window = window
        self.window?.makeKeyAndVisible()
        //22: configuramos la cache , saber la cantidad de monedas totales y el tamaño total del disco importando SDWebImage
        print("DEBUG PRINT:", SDImageCache.shared.diskCache.totalSize())
        
        SDImageCache.shared.config.maxDiskSize = 1000000 * 20
    }

}

