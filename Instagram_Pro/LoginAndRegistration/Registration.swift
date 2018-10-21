//
//  ViewController.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/15.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit
import Firebase

class Registration: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let registrationLabel: UILabel = {
        let reg = UILabel()
        reg.text = "Registration"
        reg.textColor = .black
        reg.font = UIFont.systemFont(ofSize: 30)
        reg.translatesAutoresizingMaskIntoConstraints = false
        return reg
    }()
    
    
    
    let uploadProfilePicBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(uploadProfileImgHandler), for: .touchUpInside)
        return button
    }()
    
    
    @objc func uploadProfileImgHandler() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        clickLabel.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            uploadProfilePicBtn.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            uploadProfilePicBtn.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        uploadProfilePicBtn.layer.cornerRadius = uploadProfilePicBtn.frame.width/2
        uploadProfilePicBtn.layer.masksToBounds = true
        uploadProfilePicBtn.layer.borderColor = UIColor.black.cgColor
        uploadProfilePicBtn.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
    }
    
    let clickLabel: UILabel = {
        let label = UILabel()
        label.text = "Click Button to Upload a Profile photo"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Email..."
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        tf.addTarget(self, action: #selector(validInputHandler), for: .editingChanged)
        
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Username..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(validInputHandler), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Password..."
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(validInputHandler), for: .editingChanged)
        return tf
    }()
    let repeatPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Repeat Password..."
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(validInputHandler), for: .editingChanged)
        return tf
    }()
    
    @objc func validInputHandler(){
        
        let isInputFieldsContainText = (emailTextField.text?.isEmpty)! && (usernameTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)!
        
        if isInputFieldsContainText {
            
            print("Form invalid")
            signUpButton.isEnabled = false
            
        }else {
            
            print("Valid Form")
            
            signUpButton.isEnabled = true
        }
        
    }
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textColor = .black
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.isEnabled = true
        return label
    }()

    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(signUpHandler), for: .touchUpInside)
        
        button.isEnabled = false
        
        
        return button
    }()
    
    
    @objc func signUpHandler(){
        
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let username = usernameTextField.text, !username.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        guard let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else {return}
        
        if(passwordTextField.text == repeatPasswordTextField.text){
            Auth.auth().createUser(withEmail: email, password: password, completion: {
                (user, error) in
            
                if let err = error {
                    print ("Error while creating user", err)
                
                    self.statusLabel.isEnabled = true
                    self.statusLabel.isHidden = false
                    self.statusLabel.text = err.localizedDescription.description

                
                    return
                } else {
                    self.statusLabel.isEnabled = true
                    self.statusLabel.isHidden = false
                    self.statusLabel.text = "Registered Successfully!"
                    
                    //Freeze for 1 seconds.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                        let  vc =  self.navigationController?.viewControllers.filter({$0 is Login}).first
                        self.navigationController?.popToViewController(vc!, animated: true)
                    }
                    
                    //Back to SignIn when registered succeeded.
                    print(" User created - ", Auth.auth().currentUser?.uid ?? "")
                    guard let image = self.uploadProfilePicBtn.imageView?.image else { return }
                    
                    guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
                    
                    let filename = NSUUID().uuidString
                    
                    let storageRef = Storage.storage().reference().child("profile_images").child(filename)
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                        
                        if let err = err {
                            print("Failed to upload profile image:", err)
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (downloadURL, err) in
                            if let err = err {
                                print("Failed to fetch downloadURL:", err)
                                return
                            }
                            
                            guard let profileImageUrl = downloadURL?.absoluteString else { return }
                            
                            print("Successfully uploaded profile image:", profileImageUrl)
                            
                            guard let uid = user?.user.uid else { return }
                            let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl]
                            let values = [uid: dictionaryValues]
                            
                            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                                
                                if let err = err {
                                    print("Failed to save user info into db:", err)
                                    return
                                }
                                print("Successfully saved user info to db")
                            })
                        })
                    })
                }
            }
                            
                            
        )}else {
            self.statusLabel.isEnabled = true
            self.statusLabel.isHidden = false
            self.statusLabel.text = "Passwords Mismatch!"}
    }
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.quickSetRGB(red: 17, green: 154, blue: 237)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAlreadyHaveAccount() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupAlreadyHavAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.quickSetAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupRegistrationLabel()
        
        setupUploadButton()
        
        setupClickLabel()
        
        setupInputFields()
        
        setupSignupButton()
        
        setupStatusLabel()
        
        setupAlreadyHavAccountButton()
        
    }
    
    fileprivate func setupRegistrationLabel() {
        view.addSubview(registrationLabel)
        registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    fileprivate func setupUploadButton() {
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(uploadProfilePicBtn)
        uploadProfilePicBtn.heightAnchor.constraint(equalToConstant: 180).isActive = true
        uploadProfilePicBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        uploadProfilePicBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadProfilePicBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
    }
    
    
    
    fileprivate func setupClickLabel() {
        view.addSubview(clickLabel)
        clickLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clickLabel.topAnchor.constraint(equalTo: uploadProfilePicBtn.bottomAnchor, constant: -40).isActive = true
    }
    
    
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField,repeatPasswordTextField])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.quickSetAnchor(top: uploadProfilePicBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 180)
        
    }
    
    
    fileprivate func setupSignupButton() {
        view.addSubview(signUpButton)
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 80).isActive = true
        
        
    }
    
    fileprivate func setupStatusLabel() {
        view.addSubview(statusLabel)
        statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusLabel.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 12).isActive = true
    }
    
    
}



