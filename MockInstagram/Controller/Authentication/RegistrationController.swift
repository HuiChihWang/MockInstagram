//
//  RegisterControllerController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/18.
//

import UIKit

class RegistrationController: UIViewController {
    
    private var registrationVM = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        createGradientView()
        createFieldsStack()
        createImageView()
        createLoginText()
    }
    
    private func createImageView() {
        view.addSubview(photoImage)
        
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        layoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        layoutGuide.bottomAnchor.constraint(equalTo: emailInput.topAnchor).isActive = true
        layoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        layoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        photoImage.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
        photoImage.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor).isActive = true
        
        let imageWidth = view.frame.width * 0.3
        photoImage.setDimensions(height: imageWidth, width: imageWidth)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(selectPhoto))
        photoImage.addGestureRecognizer(tapGesture)
        
    }
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private func createGradientView() {
        let background = IGBackgroundView(frame: view.frame)
        view.addSubview(background)
    }
    
    private func createFieldsStack() {
        let stack = UIStackView(
            arrangedSubviews: [
                emailInput,
                passwordInput,
                nameInput,
                idInput,
                signUpButton
            ]
        )
        
        stack.arrangedSubviews.forEach { view in
            guard let textField = view as? UITextField else {
                return
            }
            
            textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        }
        
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        
        let stackWidth = view.frame.width * 0.8
        let inputHeight: CGFloat = 50
        stack.center(inView: view)
        stack.anchor(width: stackWidth)
        stack.arrangedSubviews.forEach {$0.anchor(height: inputHeight)}
    }
    
    private let emailInput = LoginTextField(fieldName: "Email")
    private let passwordInput = LoginTextField(fieldName: "Password", isSecure: true)
    private let nameInput = LoginTextField(fieldName: "Full Name")
    private let idInput = LoginTextField(fieldName: "Username")
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.backgroundColor = registrationVM.buttonBackground
        button.setTitleColor(registrationVM.textColor, for: .normal)
        button.isEnabled = registrationVM.isFormValid
        
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private func createLoginText() {
        let customButton = TwoPartTextButton()
        customButton.setText(first: "Already have an account?", second: "Log in")
        
        view.addSubview(customButton)
        customButton.centerX(inView: view)
        customButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 32)
        customButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        switch sender {
        case emailInput:
            registrationVM.email = emailInput.inputText
        case passwordInput:
            registrationVM.pwd = passwordInput.inputText
        case nameInput:
            registrationVM.name = nameInput.inputText
        case idInput:
            registrationVM.idName = idInput.inputText
        default:
            return
        }
        
        signUpButton.backgroundColor = registrationVM.buttonBackground
        signUpButton.setTitleColor(registrationVM.textColor, for: .normal)
        signUpButton.isEnabled = registrationVM.isFormValid
    }
    
    @objc private func signUp() {
        print("Sign Up")
        
        let user = AuthCredentials(email: registrationVM.email, password: registrationVM.pwd, fullName: registrationVM.name, userName: registrationVM.idName, profileImage: registrationVM.profileImage)
        
        AuthService.register(with: user) { error in
            if let error = error {
                print("Registration Fail for user: \(user.userName) \(error.localizedDescription)")
            }
            print("Registration \(user.userName) sucess!!")
            
            //TODO: do segue to main view
        }
    }
    
    @objc private func logIn() {
        print("go back to login page")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func selectPhoto() {
        print("select photo")
        
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        photoController.allowsEditing = true
        
        present(photoController, animated: true, completion: nil)
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        registrationVM.profileImage = info[.editedImage] as? UIImage
        
        if let image = registrationVM.profileImage {
            photoImage.contentMode = .scaleAspectFill
            photoImage.layer.cornerRadius = photoImage.frame.width / 2
            photoImage.layer.borderColor = UIColor.white.cgColor
            photoImage.layer.borderWidth = 3
            photoImage.clipsToBounds = true
            photoImage.image = image
        }

        
        picker.dismiss(animated: true, completion: nil)
    }
}
