//
//  UploadPostViewController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/12.
//

import Foundation
import UIKit

class UploadPostViewController: UIViewController {
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private let descriptionView = DesciptionTextView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavBar()
        configureUI()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Upload Post"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let shareButton = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(sharePost))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = shareButton
        
    }
    private func configureUI() {
        view.addSubview(postImageView)
        view.addSubview(descriptionView)
        
        let imageSize = view.frame.width * 0.7
        postImageView.setDimensions(height: imageSize, width: imageSize)
        postImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        let textWidth = view.frame.width * 0.9
        descriptionView.setDimensions(height: textWidth * 0.6, width: textWidth)
        descriptionView.centerX(inView: view, topAnchor: postImageView.bottomAnchor, paddingTop: 20)
    }
        
    @objc private func cancel() {
        print("[DEBUG] UploadPostViewController: cancel upload post")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func sharePost() {
        print("[DEBUG] UploadPostViewController: share post")
//        self.dismiss(animated: true, completion: nil)
    }

}
