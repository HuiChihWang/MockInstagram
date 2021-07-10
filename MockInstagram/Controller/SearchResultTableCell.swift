//
//  SearchResultTableCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/10.
//

import Foundation
import UIKit

class SearchResultTableCell: UITableViewCell {
    
    private var dataTask: URLSessionDataTask?
    private var user: User? {
        didSet {
            configure()
        }
    }
    
    override func prepareForReuse() {
        dataTask?.cancel()
        user = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        dataTask?.cancel()
    }
    
    private func configureUI() {
        contentView.addSubview(profileImageview)
        profileImageview.anchor(top: contentView.topAnchor, left:contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 12, paddingLeft: 30, paddingBottom: 12)
        
        let labelStack = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        
        contentView.addSubview(labelStack)
        labelStack.centerY(inView: contentView, leftAnchor: profileImageview.rightAnchor, paddingLeft: 20)
    }
    
    private let profileImageview: UIImageView = {
       let imageView = UIImageView()
        let imageSize: CGFloat = 65
        imageView.setDimensions(height: imageSize, width: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.text = "testUserName"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
         label.text = "testFullName"
         label.textColor = .gray
         label.font = UIFont.systemFont(ofSize: 15)
         return label
    }()
    
    
    private func configure() {
        if let testURL = URL(string: "https://picsum.photos/200") {
            dataTask = URLSession.shared.dataTask(with: testURL) { data, res, err in
                guard let data = data else {
                    print("[DEBUG] SearchResultViewCell: Download image fail")
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.profileImageview.image = UIImage(data: data)
                }
            }
        }
        
        dataTask?.resume()
    }
}
