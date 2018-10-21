//
//  Filter.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/20.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class Filter: UIViewController {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    var originalImage: UIImage!
    
    let FilterOneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter One", for: .normal)
        button.backgroundColor = UIColor.quickSetRGB(red: 149, green: 204, blue: 244)
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(FilterOne), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    let FilterTwoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter Two", for: .normal)
        button.backgroundColor = UIColor.quickSetRGB(red: 149, green: 204, blue: 244)
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(FilterTwo), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    let FilterThreeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter Three", for: .normal)
        button.backgroundColor = UIColor.quickSetRGB(red: 149, green: 204, blue: 244)
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(FilterThree), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    let OriginalImgButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Original Image", for: .normal)
        button.backgroundColor = UIColor.quickSetRGB(red: 211, green: 211, blue: 211)
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.setTitleColor(.black, for: .normal)
        
        button.addTarget(self, action: #selector(OriginalImage), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    var brightnessValueLabel: UILabel!
    var brightnessSlider: UISlider!
    
    var contrastValueLabel: UILabel!
    var contrastSlider: UISlider!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        
        originalImage = self.imageView.image
        
        setupImageView()
        
        setupFilterButton()
        
        setupBrightnessSlider()
        
        setupContrastSlider()
        
    }
    
    fileprivate func setupImageView() {
        view.addSubview(imageView)
        imageView.quickSetAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width, height: 400)
    }
    
    fileprivate func setupFilterButton() {
        view.addSubview(FilterOneButton)
        FilterOneButton.quickSetAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 40, paddingBottom: -80, paddingRight: 0, width: 80, height: 80)
        
        view.addSubview(FilterTwoButton)
        FilterTwoButton.quickSetAnchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -80, paddingRight: 0, width: 80, height: 80)
        FilterTwoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(FilterThreeButton)
        FilterThreeButton.quickSetAnchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -80, paddingRight: 40, width: 80, height: 80)
        
        view.addSubview(OriginalImgButton)
        OriginalImgButton.quickSetAnchor(top: nil, left: nil, bottom: FilterTwoButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -30, paddingRight: 0, width: 80, height: 80)
        OriginalImgButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupBrightnessSlider() {
        brightnessValueLabel = UILabel()
        brightnessValueLabel.frame = CGRect(x:0, y:0, width: 200, height: 20)
        brightnessValueLabel.text = "Brightness"
        brightnessValueLabel.textColor = .black
        brightnessValueLabel.backgroundColor = .white
        brightnessValueLabel.textAlignment = NSTextAlignment.center
        brightnessValueLabel.numberOfLines = 2
        brightnessValueLabel.font = UIFont.systemFont(ofSize: 20)
        brightnessValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brightnessValueLabel)
        brightnessValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        brightnessValueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        
        
        brightnessSlider = UISlider(frame: CGRect(x:0, y:0,width: 300, height:20))
        brightnessSlider.center = self.view.center
        brightnessSlider.minimumValue = -0.2
        brightnessSlider.maximumValue = 0.2
        brightnessSlider.value = 0
        brightnessSlider.tintColor = UIColor.cyan
        brightnessSlider.thumbTintColor = UIColor.quickSetRGB(red: 211, green: 211, blue: 211)
        brightnessSlider.isContinuous = true
        brightnessSlider.addTarget(self, action: #selector(brightnessChanged(sender:)), for: UIControlEvents.valueChanged)
        brightnessSlider.isHidden = false
        brightnessSlider.isEnabled = true
        self.view.addSubview(brightnessSlider)
        brightnessSlider.topAnchor.constraint(equalTo: brightnessValueLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    fileprivate func setupContrastSlider() {
        contrastValueLabel = UILabel()
        contrastValueLabel.frame = CGRect(x:0, y:0, width: 200, height: 20)
        contrastValueLabel.text = "Contrast"
        contrastValueLabel.textColor = .black
        contrastValueLabel.backgroundColor = .white
        contrastValueLabel.textAlignment = NSTextAlignment.center
        contrastValueLabel.numberOfLines = 2
        contrastValueLabel.font = UIFont.systemFont(ofSize: 20)
        contrastValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contrastValueLabel)
        contrastValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contrastValueLabel.topAnchor.constraint(equalTo: brightnessSlider.bottomAnchor, constant: 50).isActive = true
        
        
        contrastSlider = UISlider(frame: CGRect(x:0, y:0,width: 300, height:20))
        contrastSlider.center = self.view.center
        contrastSlider.minimumValue = -0.1
        contrastSlider.maximumValue = 0.1
        contrastSlider.value = 0
        contrastSlider.tintColor = UIColor.cyan
        contrastSlider.thumbTintColor = UIColor.quickSetRGB(red: 211, green: 211, blue: 211)
        contrastSlider.isContinuous = true
        contrastSlider.addTarget(self, action: #selector(contrastChanged(sender:)), for: UIControlEvents.valueChanged)
        contrastSlider.isHidden = false
        contrastSlider.isEnabled = true
        self.view.addSubview(contrastSlider)
        contrastSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contrastSlider.quickSetAnchor(top: contrastValueLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height:20)
    }
    
    @objc func FilterOne(){
        let image = originalImage
        
        let sepiaImage = image?.af_imageFiltered(withCoreImageFilter: "CISepiaTone")
        
        self.imageView.image = sepiaImage
    }
    
    @objc func FilterTwo(){
        let image = originalImage
        
        let sepiaImage = image?.af_imageFiltered(withCoreImageFilter: "CIColorInvert")
        
        self.imageView.image = sepiaImage
    }
    
    @objc func FilterThree(){
        let image = originalImage
        
        let sepiaImage = image?.af_imageFiltered(withCoreImageFilter: "CIColorMonochrome")
        
        self.imageView.image = sepiaImage
    }
    
    @objc func OriginalImage(){
        self.imageView.image = originalImage
    }
    
    @objc func brightnessChanged(sender: UISlider) {
        let filterParameters = ["inputBrightness": sender.value]
        let originalImage = self.imageView.image
        
        self.imageView.image = originalImage?.af_imageFiltered(withCoreImageFilter: "CIColorControls", parameters: filterParameters)
    }
    
    @objc func contrastChanged(sender: UISlider) {
        let filterParameters = ["inputContrast": sender.value]
        let originalImage = self.imageView.image
        
        self.imageView.image = originalImage?.af_imageFiltered(withCoreImageFilter: "CIColorControls", parameters: filterParameters)
    }
    
    @objc func handleNext(){
        let postPhotoController = PostPhotoController()
        postPhotoController.selectedImage = self.imageView.image
        navigationController?.pushViewController(postPhotoController, animated: true)
    }
    
    
   
    
    
    }
    
    

