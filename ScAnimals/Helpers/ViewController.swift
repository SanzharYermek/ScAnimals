//
//  ViewController.swift
//  ImageRecognation
//
//  Created by I on 12/11/18.
//  Copyright © 2018 Yerzhan. All rights reserved.
//

import UIKit
import CoreML
import AVKit
import Vision
import SnapKit

class ViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel.init()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBackground()
        setupConstrains()
        setupAVCaptures()
        setupVision()
    }

    func setupViews() -> Void {
        self.view.addSubview(self.label)
    }
    
    func setupBackground() -> Void {
        self.view.backgroundColor = UIColor.white
    }
    func setupConstrains() -> Void {
        
        self.label.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    func setupAVCaptures() -> Void {
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try?    AVCaptureDeviceInput.init(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
    
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.init(label: "videQueue"))
        captureSession.addOutput(dataOutput)
        
    }
    
    func setupVision() -> Void {
    }
}

extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate{
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else{ return }
       
        guard let model = try? VNCoreMLModel.init(for: Custom().model) else { return }
        
        let request = VNCoreMLRequest.init(model: model) { (finishReq, error) in
            
            
            guard let results = finishReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            if firstObservation.confidence > 0.5{
                DispatchQueue.main.async {
                    self.label.text = "\(firstObservation.identifier) with \(firstObservation.confidence) confidence"
                }
            }
            else{
                DispatchQueue.main.async {
                    self.label.text = "Not Found"
                }
            }
        }
        try? VNImageRequestHandler.init(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}
