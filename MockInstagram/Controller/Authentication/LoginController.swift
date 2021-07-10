//
//  LoginController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/18.
//

import UIKit
import Firebase

protocol AuthenticationDelegate: AnyObject {
    func didAuthenticationComplete()
    func didLogout()
}

class LoginController: UIViewController {
    static func createLogInController(delegate: AuthenticationDelegate? = nil) -> UINavigationController {
        let loginController = LoginController()
        loginController.delegate = delegate
        let nav = UINavigationController(rootViewController: loginController)
        nav.modalPresentationStyle = .fullScreen
        return nav
    }
    
    private var logInVM = LogInViewModel()
    private weak var delegate: AuthenticationDelegate?
    
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
        emailInput.delegate = self
        passwordInput.delegate = self
        emailInput.keyboardType = .emailAddress
        
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
    
    @objc private func validateInput(_ sender: UITextField) {
        if sender == emailInput {
            logInVM.email = emailInput.inputText
        }
        
        if sender == passwordInput {
            logInVM.pwd = passwordInput.inputText
        }
        
        logInButton.backgroundColor = logInVM.buttonBackground
        logInButton.isEnabled = logInVM.isFormValid
        logInButton.setTitleColor(logInVM.textColor, for: .normal)
    }
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = logInVM.buttonBackground
        button.isEnabled = logInVM.isFormValid
        button.setTitleColor(logInVM.textColor, for: .normal)
        
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    private let emailInput = LoginTextField(fieldName: "Email")
    
    private let passwordInput = LoginTextField(fieldName: "Password", isSecure: true)
    
    @objc private func logIn() {
        print("[DEBUG]: LoginController Click Login Button")
        AuthService.logIn(email: emailInput.inputText, password: passwordInput.inputText) { result, error in
            if let error = error {
                print("[DEBUG] LogInController: Sign In Fail: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                return
            }
            
            print("[DEBUG] LogInController: sign in success with \(result.user)")
            
            self.delegate?.didAuthenticationComplete()
        }
    }
    
    @objc private func signUp() {
        print("[DEBUG]: LogInController Click Sign Up Button")
        let registrationController = RegistrationController()
        registrationController.delegate = delegate
        navigationController?.pushViewController(registrationController, animated: true)
    }
}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
