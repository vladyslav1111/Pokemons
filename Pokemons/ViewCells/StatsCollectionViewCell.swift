//
//  StatsCollectionViewCell.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/6/21.
//

import UIKit
struct StatsCellItem: CellItemProtocol {
    let baseStat: Int
    let effort: Int
    let name: String
    func preferedCellType() -> CellProtocol.Type {
        return StatsCollectionViewCell.self
    }
}
class StatsCollectionViewCell: UICollectionViewCell, CellProtocol {
    let baseStatLabel = UILabel()
    let baseStatValueLabel = UILabel()
    let effortLabel = UILabel()
    let effortValueLabel = UILabel()
    let nameLabel = UILabel()
    let nameValueLabel = UILabel()
    
    let contentStackView: UIStackView
    let baseStatStackView: UIStackView
    let effortStackView: UIStackView
    let nameStackView: UIStackView
    
    override init(frame: CGRect) {
        baseStatStackView = UIStackView(arrangedSubviews: [baseStatLabel, baseStatValueLabel])
        effortStackView = UIStackView(arrangedSubviews: [effortLabel, effortValueLabel])
        nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameValueLabel])
        contentStackView = UIStackView(arrangedSubviews: [baseStatStackView, effortStackView, nameStackView])
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cellItem: CellItemProtocol) {
        guard let cellItem = cellItem as? StatsCellItem else {
            return
        }
        baseStatValueLabel.text = String(cellItem.baseStat)
        effortValueLabel.text = String(cellItem.effort)
        nameValueLabel.text = cellItem.name
    }
    
    private func setupViews() {
        baseStatLabel.text = "Base stat:"
        effortLabel.text = "Effort:"
        nameLabel.text = "Name:"
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        baseStatStackView.axis = .horizontal
        baseStatStackView.distribution = .fillEqually
        
        effortStackView.axis = .horizontal
        effortStackView.distribution = .fillEqually
        
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fillEqually
        
        contentStackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        baseStatStackView.heightAnchor.constraint(equalTo: effortStackView.heightAnchor, multiplier: 1).isActive = true
        effortStackView.heightAnchor.constraint(equalTo: nameStackView.heightAnchor, multiplier: 1).isActive = true
    }
}
