//
//  CellViewModel.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/6/21.
//

import Foundation

protocol CellProtocol {
    static var identifier: String { get }
    func configure(with cellItem: CellItemProtocol)
}

extension CellProtocol {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
