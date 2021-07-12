//
//  ImageSelectorController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit
import YPImagePicker

class ImageSelectorController: UIViewController {
    private let imagePicker: YPImagePicker = {
        var imagePickerConfig = YPImagePickerConfiguration()
        imagePickerConfig.library.mediaType = .photo
        imagePickerConfig.shouldSaveNewPicturesToAlbum = false
        imagePickerConfig.startOnScreen = .library
        imagePickerConfig.screens = [.library]
        imagePickerConfig.hidesStatusBar = false
        imagePickerConfig.hidesBottomBar = false
        imagePickerConfig.library.maxNumberOfItems = 1
        
        let imagePicker = YPImagePicker(configuration: imagePickerConfig)
        imagePicker.modalPresentationStyle = .fullScreen
        return imagePicker
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        present(imagePicker, animated: true)
    }
}
