//
//  Camera.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/19.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit
import AVFoundation

class Camera: UIViewController, AVCapturePhotoCaptureDelegate {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "return"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "shutter"), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    @objc func handleCapturePhoto() {
        print("Capturing photo...")
        
        let settings = AVCapturePhotoSettings()
        
        #if (!arch(x86_64))
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
        
        output.capturePhoto(with: settings, delegate: self)
        #endif
    }
    
    let flashlightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "flashlight"), for: .normal)
        button.addTarget(self, action: #selector(handleFlashlight), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    @objc func handleFlashlight(){
        toggleFlash()
    }
    
    func toggleFlash() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureDevice.TorchMode.on) {
                    device?.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device?.setTorchModeOn(level: 1.0)
                    } catch {
                        print(error)
                    }
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    let output = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupCameraView()
    }
    
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        //setup inputs
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let err {
            print("Could not setup camera input:", err)
        }
        
        //setup outputs
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        //setup output preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }

    
    fileprivate func setupCameraView() {
        view.addSubview(capturePhotoButton)
        capturePhotoButton.quickSetAnchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -30, paddingRight: 0, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.quickSetAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        view.addSubview(flashlightButton)
        flashlightButton.quickSetAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 23, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 25, height: 25)
        
        drawGridView()
        
    }
    
    fileprivate func drawGridView() {
        drawDottedLine(start: CGPoint(x: view.bounds.minX, y: view.bounds.maxY/3), end: CGPoint(x: view.bounds.maxX, y: view.bounds.maxY/3), view: view)
        
        drawDottedLine(start: CGPoint(x: view.bounds.minX, y: view.bounds.maxY/3*2), end: CGPoint(x: view.bounds.maxX, y: view.bounds.maxY/3*2), view: view)
        
        drawDottedLine(start: CGPoint(x: view.bounds.maxX/3, y: view.bounds.minY), end: CGPoint(x: view.bounds.maxX/3, y: view.bounds.maxY), view: view)
        
        drawDottedLine(start: CGPoint(x: view.bounds.maxX/3*2, y: view.bounds.minY), end: CGPoint(x: view.bounds.maxX/3*2, y: view.bounds.maxY), view: view)
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)
        
        let previewImage = UIImage(data: imageData!)
        
        let containerView = PreviewPhoto()
        containerView.previewImageView.image = previewImage
        view.addSubview(containerView)
        containerView.quickSetAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
