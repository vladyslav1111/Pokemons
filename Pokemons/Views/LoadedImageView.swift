//
//  LoadedImageView.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/5/21.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

class LoadedImageView: UIImageView {
    var dataTask: URLSessionDataTask?
    let spiner = UIActivityIndicatorView(style: .gray)
    
    init() {
        super.init(frame: .zero)
        addSubview(spiner)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func load(urlString: String) {
        image = nil
        guard let url = URL(string: urlString) else { return }
        spiner.startAnimating()
        dataTask?.cancel()
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
        }
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, _, _) in
            if let data = data, let newImage = UIImage(data: data) {
                imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
                DispatchQueue.main.async {
                    self?.image = newImage
                    self?.spiner.stopAnimating()
                }
            }
        })
        dataTask?.resume()
    }
    
    override func layoutSubviews() {
        spiner.center = center
        super.layoutSubviews()
    }
}
