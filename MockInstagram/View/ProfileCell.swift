//
//  ProfileCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/9.
//

import Foundation
import UIKit

class ProfileCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        contentView.addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    deinit {
        dataTask?.cancel()
    }
    
    override func prepareForReuse() {
        dataTask?.cancel()
    }
    
    private var dataTask: URLSessionDataTask?
    
    func configure() {
        let url = URL(string: "https://picsum.photos/200")!
        
        dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else {
                print("[DEBUG] Download image fail")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
        
        dataTask?.resume()
    }
}
