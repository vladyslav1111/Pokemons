//
//  PokemonDetailsViewController.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/5/21.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    let viewModel: PokemonDetailsViewModel
    var tableView: UITableView!
    var cellItems = [CellItemProtocol]()
    init(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        view.backgroundColor = .white
        title = viewModel.getPokemonName()
        configureCellItems()
        configureTableView()
        
        tableView.register(PokemonImageTableViewCell.self, forCellReuseIdentifier: String(describing: PokemonImageTableViewCell.self))
        tableView.register(PokemonInfoTableViewCell.self, forCellReuseIdentifier: String(describing: PokemonInfoTableViewCell.self))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configureCellItems() {
        cellItems.append(PokemonImageCellItem(frontImageString: viewModel.getFrontImage(), backImageString: viewModel.getBackImage(), name: viewModel.getPokemonName()))
        cellItems.append(PokemonInfoCellItem(types: nil, stats: viewModel.getStats()))
        cellItems.append(PokemonInfoCellItem(types: viewModel.getTypes(), stats: nil))
    }
}

extension PokemonDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = cellItems[indexPath.row]
        let item = tableView.dequeueReusableCell(withIdentifier: cellItem.preferedCellType().identifier)
        if let item = item as? CellProtocol {
            item.configure(with: cellItem)
        }
        return item ?? UITableViewCell()
    }
    
    
}

extension PokemonDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        }
        return 80
    }
}
