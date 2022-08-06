//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이준혁 on 2022/08/06.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뒤로가기 불가
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        
        self.welcomeLabel.text = """
                                 환영합니다.
                                 \(email)님
                                 """
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        
    }
    
    @IBAction func tapProfileUpdate(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "토끼"
        changeRequest?.commitChanges{ _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            
            self.welcomeLabel.text = """
                                환영합니다.
                                \(displayName)님
                                """
        }
    }
}
