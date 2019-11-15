//
//  LoadingButton.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 15/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class LoadingButton: UIButton {

    
    // MARK: - Class Properties
    
    private var originalButtonText: String?
    private var activityIndicator: UIActivityIndicatorView!

    
    // MARK: - Public Methods
    
    public func startLoading() {
        originalButtonText = self.titleLabel?.text
        setTitle("", for: UIControl.State.normal)

        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }

        showSpinning()
    }

    public func endLoading() {
        setTitle(originalButtonText, for: UIControl.State.normal)
        activityIndicator.stopAnimating()
    }

    
    // MARK: - Private Methods
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = currentTitleColor
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

}
