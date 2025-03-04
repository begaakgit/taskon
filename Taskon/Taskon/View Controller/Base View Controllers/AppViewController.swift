//
//  AppViewController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 05/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {

    
    public var sync: VoidCompletion? = nil
    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}


// MARK: - Public Methods

extension AppViewController {
    
    public func showAlert(title: String = Constants.appTitle,
                          message: String,
                          okButtonTitle: String = "OK",
                          completion: VoidCompletion? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: okButtonTitle, style: .default) { [weak self] action in
            guard let _ = self else { return }
            completion?()
        }
        
        alertController.addAction(actionOk)
        alertController.preferredAction = actionOk
        present(alertController, animated: true, completion: nil)
    }
    
    public func logoutUser() {
        TOUserDefaults.clearDefaults()
        let loginNavController = Storyboard.main.instantiateInitialViewController()
        view.window?.rootViewController = loginNavController
    }
    
    public func performAnimation(_ animation: @escaping VoidCompletion) {
        UIView.animate(withDuration: 0.03, animations: animation) { [weak self] _ in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    public func syncData(taskAction: TaskAction?, materials: [TaskUsedMaterial], completion: VoidCompletion? = nil) {
        performSyncDataRequest(taskAction: taskAction, materials: materials, completion: completion)
    }
    
}


// MARK: - API Request

extension AppViewController {
    
    private func performSyncDataRequest(taskAction: TaskAction?, materials: [TaskUsedMaterial], completion: VoidCompletion? = nil) {
        let request = APIClient.syncData(taskAction: taskAction, materials: materials)
        
        let success: ServiceSuccess<EmptyCodable> = { [weak self] emptyCodable in
            guard let self = self else { return }
            TOUserDefaults.gpsLogs.clear()
            self.sync?()
            completion?()
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let _ = self else { return }
            completion?()
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
}


// MARK: - Error Handler Methods

extension AppViewController: APIErrorHandler {

    var errorHandler: APIErrorHandlerCompletion { return handleServiceError() }
    
    private func handleServiceError() -> APIErrorHandlerCompletion {
        let handler: APIErrorHandlerCompletion = { [weak self] error, filter in
            guard let self = self else { return }
            
            if let toError = error as? TOError {
                
                var message = ""
                var logoutUser = false
                
                switch toError {
                case .noInternet:
                    message = "Network connection has been lost. Please check your settings and try again."
                    
                case .server(let codedError):
                    if codedError.code == ErrorCode.notAutorized.rawValue {
                        message = ErrorCode.notAutorized.description
                        logoutUser = true
                    } else if filter?(codedError) == false {
                        message = codedError.message
                    } else {
                        message = codedError.message
                    }
                    
                case .stausCode(let code):
                    if let errorCode = ErrorCode(rawValue: code) {
                        message = errorCode.description
                    }
                    
                case .unknown(let msg):
                    message = msg
                }
                
                if !message.normalize.isEmpty {
                    self.showAlert(message: message) { [weak self] in
                        guard let self = self else { return }
                        if logoutUser {
                            self.logoutUser()
                        }
                    }
                }
                
            } else {
                self.showAlert(message: error.localizedDescription)
            }
            
        }
        
        return handler
    }

}


