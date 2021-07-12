//
//  UploadPostViewController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/12.
//

import Foundation
import UIKit

class UploadPostViewController: UIViewController {
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        return spinner
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
        
        shareButton.isEnabled = false
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func configureUI() {
        view.addSubview(postImageView)
        view.addSubview(descriptionView)
        
        let imageSize = view.frame.width * 0.7
        postImageView.setDimensions(height: imageSize, width: imageSize)
        postImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        
        let textWidth = view.frame.width * 0.9
        descriptionView.setDimensions(height: textWidth * 0.6, width: textWidth)
        descriptionView.centerX(inView: view, topAnchor: postImageView.bottomAnchor, paddingTop: 20)
        descriptionView.delegate = self
        
        view.addSubview(spinner)
        spinner.centerX(inView: view, topAnchor: descriptionView.bottomAnchor, paddingTop: 50)
    }
        
    @objc private func cancel() {
        print("[DEBUG] UploadPostViewController: cancel upload post")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func sharePost() {
        guard let image = postImageView.image else {
            print("[DEBUG] UploadPostViewController: no post image")
            return
        }
        
        spinner.startAnimating()
        descriptionView.isUserInteractionEnabled = false
        
        PostService.uploadPost(description: descriptionView.text, photo: image) { error in
            if let error = error {
                print("[DEBUG] UploadPostViewController: post upload error: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.descriptionView.isUserInteractionEnabled = true
                self.dismiss(animated: true)
            }
            
            print("[DEBUG] UploadPostViewController: share post sucess")
        }
    }

}

extension UploadPostViewController: DesciptionTextViewDelegate {
    func didTextChanged(text: String) {
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        }
    }
}
