//
//  Extesions.swift
//  KnowThemAll
//
//  Created by Данік on 10/07/2023.
//

import Foundation
import UIKit

protocol HasApply { }

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply { }
