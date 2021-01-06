//
//  TypesCollectionViewCell.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/6/21.
//

import UIKit

struct TypesCellItem: CellItemProtocol {
    let slot: Int
    let name: String
    func preferedCellType() -> CellProtocol.Type {
        return TypesCollectionViewCell.self
    }
}

class TypesCollectionViewCell: UICollectionViewCell, CellProtocol {
    let slotLabel = UILabel()
    let slotValueLabel = UILabel()
    let nameLabel = UILabel()
    let nameValueLabel = UILabel()
    
    let contentStackView: UIStackView
    let slotStachView: UIStackView
    let nameStackView: UIStackView
    
    override init(frame: CGRect) {
        slotStachView = UIStackView(arrangedSubviews: [slotLabel, slotValueLabel])
        nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameValueLabel])
        contentStackView = UIStackView(arrangedSubviews: [slotStachView, nameStackView])
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cellItem: CellItemProtocol) {
        guard let cellItem = cellItem as? TypesCellItem else {
            return
        }
        slotValueLabel.text = String(cellItem.slot)
        nameValueLabel.text = cellItem.name
    }
    
    private func setupViews() {
        slotLabel.text = "Slot:"
        nameLabel.text = "Name:"
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        slotStachView.axis = .horizontal
        slotStachView.distribution = .fillEqually
        
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fillEqually
        
        contentStackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        slotStachView.heightAnchor.constraint(equalTo: nameStackView.heightAnchor, multiplier: 1).isActive = true
    }
}
