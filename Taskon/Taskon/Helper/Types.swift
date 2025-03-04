//
//  Types.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

typealias VoidCompletion = () -> Void
typealias FilterCompletion = (Filter) -> Void
typealias ErrorCodeTuple = (code: Int, message: String)
typealias ErrorCodeFilter = (ErrorCodeTuple) -> Bool
typealias APIErrorHandlerCompletion = (Error, ErrorCodeFilter?) -> Void
typealias ServiceFailure = (Error) -> Void
typealias ServiceSuccess<T> = (T) -> Void
typealias DateCompletion = (Date) -> Void
typealias CustomerCompletion = (Customer) -> Void
typealias ImagePickerCompletion = (UIImage, CLLocation?) -> Void
typealias AddressCompletion = (CLPlacemark?) -> Void
typealias AddUser = (StaticUser) -> Void
typealias TextCompletion = (String) -> Void
