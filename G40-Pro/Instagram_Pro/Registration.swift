//
//  ViewController.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/15.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit

class Registration: UIViewController {
    
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
        return button
    }()
    
    let clickLabel: UILabel = {
        let label = UILabel()
        label.text = "Click Button to Upload a Profile photo"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter Email..."
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let fullNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Username..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
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
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupRegistrationLabel()
        
        setupUploadButton()
        
        setupClickLabel()
        
        setupInputFields()
        
        setupSignupButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    fileprivate func setupUploadButton() {
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(uploadProfilePicBtn)
        uploadProfilePicBtn.heightAnchor.constraint(equalToConstant: 180).isActive = true
        uploadProfilePicBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        uploadProfilePicBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadProfilePicBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
    }
    
    fileprivate func setupRegistrationLabel() {
        view.addSubview(registrationLabel)
        registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
    }
    
    fileprivate func setupClickLabel() {
        view.addSubview(clickLabel)
        clickLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clickLabel.topAnchor.constraint(equalTo: uploadProfilePicBtn.bottomAnchor, constant: -40).isActive = true
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, fullNameTextField, passwordTextField])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: uploadProfilePicBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 160)
        
    }
    
    fileprivate func setupSignupButton() {
        view.addSubview(signUpButton)
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180).isActive = true
        
        
    }
    
    
}
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

