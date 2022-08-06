//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이준혁 on 2022/08/06.
//

import UIKit
import FirebaseAuth


class EnterEmailViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorMessageLabel: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        nextButton.layer.cornerRadius = 30
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        // Firebase Email/Password Auth
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // New User Create
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 이메일
                    //로그인 하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
}

extension EnterEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text != ""
        let isPasswordEmpty = passwordTextField.text != ""
        nextButton.isEnabled = isEmailEmpty && isPasswordEmpty
    }
    
}
