//
//  PokemonTableViewCell.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import UIKit

struct PokemonCellViewModel {
    let name: String
    let imageURL: String
}


class PokemonTableViewCell: UITableViewCell {
    private let pokemonImage: LoadedImageView
    private let nameLabel: UILabel
    private let stackView: UIStackView
    
    private let spacing: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        pokemonImage = LoadedImageView()
        nameLabel = UILabel()
        stackView = UIStackView(arrangedSubviews: [pokemonImage, nameLabel])
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = spacing
        
        pokemonImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pokemonImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        layoutIfNeeded()
    }
    
    func configure(viewModel: PokemonCellViewModel) {
        nameLabel.text = viewModel.name
        pokemonImage.load(urlString: viewModel.imageURL)
    }
}
