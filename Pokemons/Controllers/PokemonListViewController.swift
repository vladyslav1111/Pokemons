//
//  PokemonListViewController.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import UIKit

class PokemonListViewController: UIViewController {
    var tableView: UITableView!
    var viewModel: PokemonListViewModel!
    var paginationView: PaginationView!
    var activityIndicator: ActivityIndicator!
    
    private let rowHeight: CGFloat = 100
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        activityIndicator = ActivityIndicator(view: view, center: view.center)
        view.backgroundColor = .white
        activityIndicator.show()
        viewModel.loadPokemons()
        viewModel.delegate = self
        
        title = "Pokemons"
        navigationController?.navigationBar.barTintColor = .orange
    }
    
    private func configureViews() {
        configurePaginationView()
        configureTableView()
    }
    
    private func configurePaginationView() {
        edgesForExtendedLayout = []
        paginationView = PaginationView(frame: .zero)
        paginationView.prevButtonAction = { [weak self] in
            self?.activityIndicator.show()
            self?.viewModel.loadPrevPagePokemons()
        }
        paginationView.nextButtonAction = { [weak self] in
            self?.activityIndicator.show()
            self?.viewModel.loadNextPagePokemons()
        }
        view.addSubview(paginationView)
        paginationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            paginationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            paginationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            paginationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            paginationView.heightAnchor.constraint(equalToConstant: 15)
        ])
        view.layoutIfNeeded()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: paginationView.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: String(describing: PokemonTableViewCell.self))
    }
    
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPokemons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonTableViewCell.self)) as? PokemonTableViewCell
        cell?.configure(viewModel: viewModel.getPokemonCellViewModel(forIndex: indexPath.row))
        return cell ?? UITableViewCell()
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewModel = viewModel.getDetailsViewModel(forIndex: indexPath.row) else { return }
        let controller = PokemonDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.hide()
        }
    }
}
 
