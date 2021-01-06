//
//  PokemonInfoTableViewCell.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/6/21.
//

import UIKit

struct PokemonInfoCellItem: CellItemProtocol {
    let types: [PokemonType]?
    let stats: [Stat]?
    
    func preferedCellType() -> CellProtocol.Type {
        return PokemonInfoTableViewCell.self
    }
}

class PokemonInfoTableViewCell: UITableViewCell, CellProtocol {
    
    var cellItem: PokemonInfoCellItem!
    let collectionView: UICollectionView
    let flowLayout = UICollectionViewFlowLayout()
    
    var collectionCellItems = [CellItemProtocol]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        flowLayout.itemSize = .init(width: 180, height: 100)
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cellItem: CellItemProtocol) {
        guard let cellItem = cellItem as? PokemonInfoCellItem else {
            return
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        self.cellItem = cellItem
        configureCellItems()
        collectionCellItems.forEach {
            collectionView.register($0.preferedCellType() as! UICollectionViewCell.Type, forCellWithReuseIdentifier: $0.preferedCellType().identifier)
        }
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureCellItems() {
        if let types = cellItem.types {
            collectionCellItems = types.map { TypesCellItem(slot: $0.slot, name: $0.name) }
        } else if let stats = cellItem.stats {
            collectionCellItems = stats.map { StatsCellItem(baseStat: $0.baseStat, effort: $0.effort, name: $0.name) }
        }
    }
}

extension PokemonInfoTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItem.types?.count ?? cellItem.stats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionItem = collectionCellItems[indexPath.row]
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: collectionItem.preferedCellType().identifier, for: indexPath)
        if let item = item as? CellProtocol {
            item.configure(with: collectionItem)
        }
        return item
    }
}

extension PokemonInfoTableViewCell: UICollectionViewDelegate {

}
