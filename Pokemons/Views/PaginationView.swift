//
//  PaginationView.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/8/21.
//

import UIKit

class PaginationView: UIView {
    let prevButton: UIButton = UIButton()
    let nextButton: UIButton = UIButton()
    let contentStackView: UIStackView
    
    var prevButtonAction: (() -> Void)?
    var nextButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        self.contentStackView = UIStackView(arrangedSubviews: [prevButton, UIView(), nextButton])
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        prevButton.setTitle("Prev", for: .normal)
        prevButton.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        prevButton.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        prevButton.setTitleColor(.systemBlue, for: .normal)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .horizontal
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func prevButtonTapped() {
        prevButtonAction?()
    }
    
    @objc func nextButtonTapped() {
        nextButtonAction?()
    }
}
