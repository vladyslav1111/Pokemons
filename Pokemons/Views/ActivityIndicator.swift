//
//  ActivityIndicator.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/8/21.
//

import UIKit

class ActivityIndicator {
    let indicatorBackgoundView = UIView()

    weak var viewToShow: UIView!
    public var indicatorBackgroundAlpha: CGFloat = 0.4

    var framing: Bool = false
    var indicatorCenter: CGPoint?

    private var indicatorColor: UIColor = UIColor(red: 106 / 255,
                                                  green: 113 / 255,
                                                  blue: 125 / 255,
                                                  alpha: 1.0)

    private lazy var myActivityIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = {
            if framing {
                let indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:65, height: 65))
                indicator.style = .whiteLarge
                indicator.backgroundColor = (UIColor(white: 1.0, alpha: 0.9))
                indicator.layer.masksToBounds = true
                indicator.layer.cornerRadius = 10
                indicatorBackgroundAlpha = 0.0
                indicatorColor = UIColor.black

                return indicator
            } else {
                return UIActivityIndicatorView(style: .whiteLarge)
            }
        }()
        indicatorBackgoundView.frame = self.viewToShow.bounds
        indicatorBackgoundView.backgroundColor = UIColor.white.withAlphaComponent(indicatorBackgroundAlpha)

        indicator.color = self.indicatorColor
        indicator.center = indicatorCenter ?? indicatorBackgoundView.center
        indicator.hidesWhenStopped = true
        indicator.alpha = 1.0
        indicator.accessibilityIdentifier = "In progress"
        indicatorBackgoundView.addSubview(indicator)

        return indicator
    }()

    public init(view: UIView, color: UIColor? = nil, framing: Bool = false) {
        self.viewToShow = view
        self.framing = framing
        if let color = color {
            self.indicatorColor = color
        }
    }

    public convenience init(view: UIView, center: CGPoint?, color: UIColor? = nil) {
        self.init(view: view, color: color)
        self.indicatorCenter = center
    }

    public func show() {
        myActivityIndicator.startAnimating()
        self.viewToShow.addSubview(indicatorBackgoundView)
    }

    public func hide() {
        myActivityIndicator.stopAnimating()
        indicatorBackgoundView.removeFromSuperview()
    }

    public func isAnimating() -> Bool {
        return myActivityIndicator.isAnimating
    }
}
