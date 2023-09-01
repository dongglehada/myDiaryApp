//
//  Models.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import Foundation
import UIKit


struct MemoData{
    var year:Int
    var month:Int
    var day:Int
    var context:String
    var tagColor:TagColor
    var id:Int
}

enum TagColor: CaseIterable{
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case purple
    
    var getColor: UIColor{
        switch self{
        case .red:
            return UIColor.systemRed
        case.orange:
            return UIColor.systemOrange
        case.yellow:
            return UIColor.systemYellow
        case.green:
            return UIColor.systemGreen
        case .blue:
            return UIColor.systemBlue
        case .indigo:
            return UIColor.systemIndigo
        case .purple:
            return UIColor.systemPurple
        }
    }

}
