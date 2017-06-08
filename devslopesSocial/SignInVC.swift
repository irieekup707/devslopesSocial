//
//  ViewController.swift
//  devslopesSocial
//
//  Created by Ryan  Martino on 6/6/17.
//  Copyright © 2017 Ryan  Martino. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var pwdField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let  _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
   
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                
                print("RYAN: Unable to Authinticate with Facebook: \(String(describing: error))")
            
            }else if result?.isCancelled == true {
                
                print("Ryan: User Cancled Facebook Authintication")
                
            }else {
                
                print("Ryan: Succesfully Authinticated with Facebook")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
        }
        
    }
    
    func firebaseAuth(_ credintial: AuthCredential) {
        Auth.auth().signIn(with: credintial) { (user, error) in
        
            if error != nil {
                
                print("Ryan: Unable to Authenticate with Firebase: \(String(describing: error))")
            
            }else {
                
                print("Ryan: Succesfully Authenticated with Firebase")
                
                if let user = user {
                    let userData = ["provider": credintial.provider]
                
                    self.completeSignIn(id: user.uid, userData: userData)
                
                }
            }
        }
        
    }
    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Ryan: Email User Authenticated With Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                }else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Ryan: Unable To Authenticate With Firebase Using Email - \(String(describing: error))")
                        }else {
                            print("Ryan: Successfully Authenticated With Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                        }
                    })
                }
            })
        }
        
    }
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
            DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        
        print("Ryan: Keychain Successfully Saved \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
}

