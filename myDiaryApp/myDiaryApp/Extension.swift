//
//  Extension.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import Foundation
import UIKit

extension CGFloat{
    static let defaultPadding: CGFloat = 20
}

extension UIColor{
    static let myPointColor: UIColor = .systemYellow
    static let myBackGroundColor: UIColor = .systemGray
}

extension Date{
    
    static var nowYear: Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        guard let year = Int(formatter.string(from: Date())) else { return 0}
        return year
    }
    static var nowMonth: Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        guard let month = Int(formatter.string(from: Date())) else { return 0}
        return month
    }
    static var nowDay: Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        guard let day = Int(formatter.string(from: Date())) else { return 0}
        return day
    }
    
}
