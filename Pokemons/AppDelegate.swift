//
//  AppDelegate.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = PokemonListViewModel()
        let listVC = PokemonListViewController(viewModel: viewModel)
        let rootViewController = UINavigationController(rootViewController: listVC)
        rootViewController.navigationBar.prefersLargeTitles = true
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

