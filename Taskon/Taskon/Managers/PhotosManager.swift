//
//  PhotosManager.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import Photos

enum AssetType {
    case camera
    case photoLibrary
    
    func description() -> String {
        switch self {
        case .camera: return "Camera"
        case .photoLibrary: return "Photo Library"
        }
    }
}

class PhotosManager: NSObject {
    
    
    // MARK: - Class Properties
    
    private var viewController: UIViewController
    public var selectedImage: ImagePickerCompletion? = nil
    
    
    // MARK: - Initialization Methods
    
    init(viewController controller: UIViewController) {
        viewController = controller
        super.init()
    }
    
    
    // MARK: - Public Methods
    
    public func start() {
        showActionSheet()
    }
    
}


// MARK: - Private Methods

extension PhotosManager {
    
    private func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.authorize(for: .camera)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.authorize(for: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    private func startCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            viewController.present(pickerController, animated: true, completion: nil)
            
        } else {
            if let viewController = viewController as? AppViewController {
                viewController.showAlert(title: Constants.appTitle, message: "Camera not available.")
            }
        }
    }
    
    private func startPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            viewController.present(pickerController, animated: true, completion: nil)
            
        } else {
            if let viewController = viewController as? AppViewController {
                viewController.showAlert(title: Constants.appTitle, message: "Photo Library not available.")
            }
        }
    }
    
    private func start(for type: AssetType) {
        switch type {
        case .camera: startCamera()
        case .photoLibrary: startPhotoLibrary()
        }
    }
    
    private func denied(for type: AssetType) {
        if let viewController = viewController as? AppViewController {
            viewController.showAlert(title: "Access Denied", message: "App does not have access to \(type.description())")
        }
    }
    
    private func restricted(for type: AssetType) {
        if let viewController = viewController as? AppViewController {
            viewController.showAlert(title: "Access Restricted", message: "App does not have access to \(type.description())")
        }
    }
    
    private func authorize(for type: AssetType) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
            
        case .authorized: start(for: type)
            
        case .denied: denied(for: type)
            
        case .restricted: restricted(for: type)
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if status == .authorized {
                        self.start(for: type)
                    } else {
                        self.denied(for: type)
                    }
                }
            }
            
        @unknown default:
            debugPrint("")
            
        }
        
    }
}


// MARK: - Image Picker Methods

extension PhotosManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage?(image)
        } else {
            debugPrint("Some Thing went wrong!")
        }
        viewController.dismiss(animated: true, completion: nil)
    }
}
