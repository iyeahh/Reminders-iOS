//
//  ReuseIdentifier.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import Foundation
import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
