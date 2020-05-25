//
//  ScannerViewController.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import CoreML
import Vision
import FirebaseDatabase

class ScannerViewController: UIViewController {

    private let logoImageView: UIImageView = UIImageView()
    private let scannableView: ScannableView = ScannableView()
    private let messageLabelView: UILabel = UILabel()
    private let toScannerButtonView: MainButtonView = MainButtonView()

    private var imagePickerManager: ImagePicker?
    private var referenceToDatabase: DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerManager = ImagePicker.init(presentationController: self, delegate: self)
        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension ScannerViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) -> Void {

        toScannerButtonView.setTitle("Сканировать", for: .normal)
        scannableView.scannableImage = image
    }
}

private extension ScannerViewController {

    @objc
    func toScannerPressed(_ sender: UIButton) -> Void {

        if let _ = scannableView.scannableImage {
            if let ciImage = CIImage.init(image: scannableView.scannableImage!) {
                toScannerButtonView.showLoading()
                UIApplication.shared.beginIgnoringInteractionEvents()
                recognizeImage(image: ciImage)
            }
        }
        else {
            self.imagePickerManager?.present(from: view)
        }
    }
}

private extension ScannerViewController {

    func recognizeImage(image: CIImage) {
        if let model = try? VNCoreMLModel(for: Custom().model) {
            let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    let topResult = results.first
                    DispatchQueue.main.async {
                        if let identifier = topResult?.identifier {
                            let confidenceRate = (topResult?.confidence)! * 100
                            let rounded = Int (confidenceRate * 100) / 100
                            self.findAnimal(with: identifier, rounded)

                        }
                        else{
                            self.toScannerButtonView.hideLoading()
                            self.showAlert(with: "Извините", "Мы не смогли определить животное")
                        }
                    }
                }
                else{
                    self.toScannerButtonView.hideLoading()
                    self.showAlert(with: "Извините", "Мы не смогли определить животное")
                }
            })
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    self.toScannerButtonView.hideLoading()
                    self.showAlert(with: "Извините", "Мы не смогли определить животное")
                }
            }
        }
        else {
            toScannerButtonView.hideLoading()
            UIApplication.shared.endIgnoringInteractionEvents()
            self.showAlert(with: "Извините", "Мы не смогли определить животное")
        }
    }

    func findAnimal(with name: String, _ confidence: Int) -> Void {
        referenceToDatabase.child("animals").observeSingleEvent(of: .value) { [weak self] (snapshots) in
            if let animals = snapshots.children.allObjects as? [DataSnapshot] {
                for snapshot in animals {
                    if snapshot.childSnapshot(forPath: name).exists() {
                        self?.toScannerButtonView.hideLoading()
                        UIApplication.shared.endIgnoringInteractionEvents()

                        let animalName = snapshot.childSnapshot(forPath: name).childSnapshot(forPath: "name").value as? String 
                        let model = HistoryModel(name: animalName, type: snapshot.key, confidence: confidence, image: self!.scannableView.scannableImage!.pngData()!, date: Date())
                        StoreManager.shared().setAnimalToHistory(with: model)

                        let viewController = AnimalDetailsViewController.init(with: AnimalModel.init(with: snapshot.childSnapshot(forPath: name)))
                        self?.navigationController?.pushViewController(viewController, animated: true)
                        return
                    }
                }
                self?.toScannerButtonView.hideLoading()
                self?.showAlert(with: "Извините", "Мы не смогли определить животное")
            }
            else{
                self?.toScannerButtonView.hideLoading()
                self?.showAlert(with: "Извините", "Мы не смогли определить животное")
            }
        }
    }
    
}

private extension ScannerViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)

        //logo image view
        logoImageView.image = #imageLiteral(resourceName: "ScAnimals")
        logoImageView.contentMode = .scaleAspectFit

        //message label view
        messageLabelView.numberOfLines = 0
        messageLabelView.textAlignment = .center
        messageLabelView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        messageLabelView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        messageLabelView.font = .boldSystemFont(ofSize: 17)

        //to scanner button view
        toScannerButtonView.setTitle("Выбрать", for: .normal)
        toScannerButtonView.layer.cornerRadius = 25
        toScannerButtonView.clipsToBounds = true
        toScannerButtonView.titleLabel?.font = .boldSystemFont(ofSize: 17)
        toScannerButtonView.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.8549019608, blue: 0.3921568627, alpha: 1)
    }

    func buildLayouts() -> Void {

        view.addSubviews([logoImageView, scannableView, messageLabelView, toScannerButtonView])

        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.left.equalTo(65)
            make.right.equalTo(-65)
            make.height.equalTo(65)
        }

        scannableView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
        }

        messageLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(scannableView.snp.bottom).offset(30)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }

        toScannerButtonView.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.left.equalTo(83)
            make.right.equalTo(-83)
            make.top.equalTo(messageLabelView.snp.bottom).offset(30)
        }
    }

    func buildTargets() -> Void {

        referenceToDatabase = Database.database().reference()
        scannableView.scannableImageTappedPerformer = { [weak self] in
            if let view = self?.view {
                self?.imagePickerManager?.present(from: view)
            }
        }
        toScannerButtonView.addTarget(self, action: #selector(toScannerPressed), for: .touchUpInside)
    }
}


