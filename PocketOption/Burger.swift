//
//  AppColor.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import Foundation
import UIKit

protocol BurgerColorHahaha {
    var rawValue: String { get }
}

extension BurgerColorHahaha {

    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

enum Burger: String, BurgerColorHahaha {
    case quizColor
    case tabbarBack
    case newsBack
}
