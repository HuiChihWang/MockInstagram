//
//  LoginController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/18.
//

import UIKit

class LoginController: UIViewController {
    
    private var logInVM = LogInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        initViews()
    }
    
    private func initViews() {
        createGradientView()
        createLogoImage()
        createLogInUI()
        createHelperText()
        createSignUpText()
        createInputObserver()
    }
    
    private func createLogoImage() {
        logoImageView.image = #imageLiteral(resourceName: "Instagram_logo_white")
    }

    private func createGradientView() {
        let background = IGBackgroundView(frame: view.frame)
        view.addSubview(background)
    }
    
    private func createSignUpText() {
        let customButton = TwoPartTextButton()
        customButton.setText(first: "Don't have an account?", second: "Sign Up")

        view.addSubview(customButton)
        customButton.centerX(inView: view)
        customButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 32)
        customButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }

    
    private func createHelperText() {
        let customButton = TwoPartTextButton()
        customButton.setText(first: "Forget Your Password?", second: "Get Help signing in.")

        view.addSubview(customButton)
        customButton.centerX(inView: view, topAnchor: logInButton.bottomAnchor, paddingTop: 5)
        

    }
    
    private func createLogInUI() {
        let logInStack = UIStackView(arrangedSubviews: [emailInput, passwordInput, logInButton])
        
        logInStack.spacing = 20
        logInStack.axis = .vertical
        logInStack.distribution = .fillEqually
        
        view.addSubview(logInStack)
        logInStack.centerX(inView: view, topAnchor: logoImageView.bottomAnchor, paddingTop: 30)
        
        let stackWidth = view.frame.width * 0.8
        let inputHeight: CGFloat = 50
        logInStack.anchor(width: stackWidth)
        logInStack.arrangedSubviews.forEach {$0.anchor(height: inputHeight)}
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let width = view.frame.width * 0.5
        imageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: view.frame.height * 0.05)
        imageView.setDimensions(height: width / 3, width: width)
        return imageView
    }()
    
    private func createInputObserver() {
        emailInput.addTarget(self, action: #selector(validateInput), for: .editingChanged)
        passwordInput.addTarget(self, action: #selector(validateInput), for: .editingChanged)
    }
    
    //TODO: add editing observer
    @objc private func validateInput(_ sender: UITextField) {
    }
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.8441327214, green: 0.2275986373, blue: 0.3763634861, alpha: 1)
        
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    private let emailInput = LoginTextField(fieldName: "Email")
    
    private let passwordInput = LoginTextField(fieldName: "Password", isSecure: true)
    
    @objc private func logIn() {
        print("Log In")
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    @objc private func signUp() {
        print("Sign Up")
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
}
