//
//  PostViewCell.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit
import SDWebImage

class PostViewCell: UICollectionViewCell {
    var viewModel: PostViewCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModel.delegate = self
                configurePost()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePost() {
        likesNumber.text = viewModel?.likeLabel
        dateLabel.text = viewModel?.dateLabel
        postImageView.sd_setImage(with: URL(string: viewModel?.photoUrl ?? ""))
        likeButton.setImage(viewModel?.likeButtonImage, for: .normal)
        saveButton.setImage(viewModel?.saveButtonImage, for: .normal)
    }
    
    private func configureUI() {
        configureAccountView()
        configureCommentRegion()
        configureButtons()
        configurePostImage()
    }
    
    private func configurePostImage() {
        contentView.addSubview(postImageView)
        postImageView.anchor(top: accountImageView.bottomAnchor, left: contentView.leftAnchor, bottom: saveButton.topAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingBottom: 10)
    }
    
    private func configureAccountView() {
        contentView.addSubview(accountImageView)
        accountImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 10, paddingLeft: 10)
        
        contentView.addSubview(accountName)
        accountName.centerY(inView: accountImageView, leftAnchor: accountImageView.rightAnchor, paddingLeft: 15)
        
        contentView.addSubview(moreButton)
        moreButton.centerY(inView: accountImageView)
        moreButton.anchor(right: contentView.rightAnchor, paddingRight: 10)
        
        accountName.addTarget(self, action: #selector(didTapAccount), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
    }
    
    private func configureCommentRegion() {
        contentView.addSubview(dateLabel)
        dateLabel.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingLeft: 10)
        
        contentView.addSubview(likesNumber)
        likesNumber.anchor(left: dateLabel.leftAnchor, bottom: dateLabel.topAnchor, paddingBottom: 10)
    }
    
    private func configureButtons() {
        let buttonsStack = UIStackView(arrangedSubviews: [likeButton, messageButton, shareButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 15
        
        contentView.addSubview(buttonsStack)
        buttonsStack.anchor(left: likesNumber.leftAnchor, bottom: likesNumber.topAnchor, paddingBottom: 10)
        
        contentView.addSubview(saveButton)
        saveButton.anchor(top: buttonsStack.topAnchor, right: moreButton.rightAnchor)
        
        likeButton.addTarget(self, action: #selector(likePhoto), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(leaveComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(sharePost), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(savePost), for: .touchUpInside)
    }
    
    private let accountImageView: UIImageView = {
        let accountImageView = UIImageView()
        let width: CGFloat = 50
        accountImageView.setDimensions(height: width, width: width)
        accountImageView.layer.cornerRadius = width / 2
        accountImageView.contentMode = .scaleAspectFill
        accountImageView.clipsToBounds = true
        return accountImageView
    }()
    
    private let accountName: UIButton = {
        let nameButton = UIButton()
        nameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nameButton.setTitleColor(.black, for: .normal)
        
        nameButton.addTarget(self, action: #selector(didTapAccount), for: .touchUpInside)
        return nameButton
    }()
    
    private let postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.isUserInteractionEnabled = true
        postImageView.contentMode = .scaleAspectFill
        return postImageView
    }()
    
    private let likeButton: UIButton = {
        let likeButtonView = UIButton()
        likeButtonView.tintColor = .red
        return likeButtonView
    }()
    
    private let messageButton: UIButton = {
        let msgButtonView = UIButton()
        msgButtonView.setDimensions(height: 25, width: 25)
        msgButtonView.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        return msgButtonView
    }()
    
    private let shareButton: UIButton = {
        let shareButtonView = UIButton()
        shareButtonView.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        shareButtonView.setDimensions(height: 25, width: 25)
        return shareButtonView
    }()
    
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setDimensions(height: 25, width: 25)
        return saveButton
        
    }()
    
    private let moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.contentMode = .scaleAspectFill
        moreButton.tintColor = .black
        moreButton.setDimensions(height: 25, width: 25)
        return moreButton
    }()
    
    private let likesNumber: UILabel = {
        let likesLabel = UILabel()
        likesLabel.textColor = .black
        likesLabel.font = UIFont.systemFont(ofSize: 14)
        return likesLabel
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    @objc private func didTapAccount() {
        print("Tap on the account")
    }
    
    @objc private func likePhoto() {
        viewModel?.likePhoto()
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

extension PostViewCell: PostViewCellViewModelDelegate {
    func didPostLikeStatusChanged() {
        DispatchQueue.main.async {
            self.likeButton.setImage(self.viewModel?.likeButtonImage, for: .normal)
            self.likesNumber.text = self.viewModel?.likeLabel
        }
    }
    
    func didUserFetched(user: User) {
        DispatchQueue.main.async {
            self.accountImageView.sd_setImage(with: URL(string: user.imageUrl ?? ""))
            self.accountName.setTitle(user.userName, for: .normal)
        }
    }
}
