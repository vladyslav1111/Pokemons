//
//  PokemonIMageTableViewCell.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/6/21.
//

import UIKit

struct PokemonImageCellItem: CellItemProtocol {
    var frontImageString: String
    var backImageString: String
    var name: String
    
    func preferedCellType() -> CellProtocol.Type {
        return PokemonImageTableViewCell.self
    }
}

class PokemonImageTableViewCell: UITableViewCell, CellProtocol {

    let frontImageView = LoadableImageView()
    let backImageView = LoadableImageView()
    let nameLabel = UILabel()
    let imageStackView: UIStackView
    let contentStackView: UIStackView
    
    let nameTextColor: UIColor = UIColor.black
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        imageStackView = UIStackView(arrangedSubviews: [frontImageView, backImageView])
        contentStackView = UIStackView(arrangedSubviews: [imageStackView, nameLabel])
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        imageStackView.axis = .horizontal
        imageStackView.distribution = .fillEqually
        imageStackView.spacing = 0
        
        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        
        frontImageView.contentMode = .scaleAspectFit
        backImageView.contentMode = .scaleAspectFit
        
        nameLabel.textColor = nameTextColor
        nameLabel.font = nameLabel.font.withSize(25)
        
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        imageStackView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    func configure(with cellItem: CellItemProtocol) {
        guard let cellItem = cellItem as? PokemonImageCellItem else { return }
        frontImageView.load(urlString: cellItem.frontImageString)
        backImageView.load(urlString: cellItem.backImageString)
        nameLabel.text = cellItem.name
    }
}
