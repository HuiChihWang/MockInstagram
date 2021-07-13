//
//  PostViewCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit
import SDWebImage

class PostViewCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStackToHandleCommentRegion()
        createSaveButton()
        createMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let post = post else {
            return
        }
        
        likesNumber.text = "\(post.likes.count) likes"
        postImageView.sd_setImage(with: URL(string: post.photoUrl))
        
        UserService.fetchUser(with: post.ownerUid) { user in
            guard let user = user else {
                return
            }
            DispatchQueue.main.async {
                self.accountImageView.sd_setImage(with: URL(string: user.imageUrl ?? ""))
                self.accountName.setTitle(user.userName, for: .normal)
            }
        }
    }
    
    private func createStackToHandleCommentRegion() {
        let buttonsStack = UIStackView()
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 15
        let buttons = [likeButton, messageButton, shareButton]
        
        buttons.forEach { button in
            button.isUserInteractionEnabled = true
            button.contentMode = .scaleAspectFill
            button.setDimensions(height: 25, width: 25)
            buttonsStack.addArrangedSubview(button)
            
        }
        
        contentView.addSubview(buttonsStack)
        buttonsStack.anchor(left: likesNumber.leftAnchor, bottom: likesNumber.topAnchor, paddingBottom: 10)
    }
    
    private func createSaveButton() {
        contentView.addSubview(saveButton)
        saveButton.anchor(bottom: likeButton.bottomAnchor, right: rightAnchor, paddingRight: 10)
        
    }
    
    private func createMoreButton() {
        contentView.addSubview(moreButton)
        let size: CGFloat = 30
        moreButton.setDimensions(height: size, width: size)
        moreButton.centerY(inView: accountImageView, leftAnchor: leftAnchor, paddingLeft: frame.width - size - 15)
        
       
    }
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        
        moreButton.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
        return moreButton
    }()
    
    private lazy var accountImageView: UIImageView = {
        let accountImageView = UIImageView()
        accountImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(accountImageView)
        
        let width: CGFloat = 50
        accountImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10, width: width, height: width)
        
        accountImageView.layer.cornerRadius = width / 2
        accountImageView.clipsToBounds = true
        
        return accountImageView
    }()
    
    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        
        contentView.addSubview(postImageView)
        postImageView.anchor(top: accountImageView.bottomAnchor, left: leftAnchor, bottom: saveButton.topAnchor, right: rightAnchor, paddingTop: 10, paddingBottom: 10)
        
        postImageView.isUserInteractionEnabled = true
        postImageView.contentMode = .scaleAspectFill
        
        return postImageView
    }()
    
    private lazy var accountName: UIButton = {
        let nameButton = UIButton()
        contentView.addSubview(nameButton)
        nameButton.centerY(inView: accountImageView, leftAnchor: accountImageView.rightAnchor, paddingLeft: 15)
        nameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nameButton.setTitleColor(.black, for: .normal)
        
        nameButton.addTarget(self, action: #selector(didTapAccount), for: .touchUpInside)
        return nameButton
    }()
    
    
    private lazy var likeButton: UIImageView = {
        let likeButtonView = UIImageView()
        likeButtonView.image = UIImage(named: "like_unselected")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likePhoto))
        
        likeButtonView.addGestureRecognizer(tapGesture)
        return likeButtonView
    }()
    
    private lazy var messageButton: UIImageView = {
        let msgButtonView = UIImageView()
        msgButtonView.image = UIImage(named: "comment")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leaveComment))
        msgButtonView.addGestureRecognizer(tapGesture)
        
        return msgButtonView
    }()
    
    private lazy var shareButton: UIImageView = {
        let shareButtonView = UIImageView()
        shareButtonView.image = UIImage(named: "send2")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sharePost))
        shareButtonView.addGestureRecognizer(tapGesture)
        
        return shareButtonView
    }()
    
    private lazy var saveButton: UIImageView = {
        let saveButton = UIImageView()
        saveButton.image = UIImage(named: "ribbon")
        
        saveButton.isUserInteractionEnabled = true
        saveButton.contentMode = .scaleAspectFill
        saveButton.setDimensions(height: 25, width: 25)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(savePost))
        
        saveButton.addGestureRecognizer(tapGesture)
        
        return saveButton
        
    }()
    
    private lazy var likesNumber: UILabel = {
        let likesLabel = UILabel()
        likesLabel.textColor = .black
        
        contentView.addSubview(likesLabel)
        likesLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 10, paddingBottom: 10)
        
        return likesLabel
    }()
    
    @objc private func didTapAccount() {
        print("Tap on the account")
    }
    
    @objc private func likePhoto() {
        print("You like this photo")
    }
    
    @objc private func leaveComment() {
        print("Comment on Post")
    }
    
    @objc private func sharePost() {
        print("Share Post")
    }
    
    @objc private func savePost() {
        print("Save Post")
    }
    
    @objc private func showMoreAction() {
        print("Show More Actions")
    }
}
