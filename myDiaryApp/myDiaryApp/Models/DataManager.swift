//
//  DataManager.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import Foundation

class DataManager{
    
    static let shared = DataManager()
    
    public var data:[MemoData] = [
        MemoData(year: "2023", month: "8", day: "31", context: "hihi", tagColor: .red)
    ]
    
    private init(){
        
    }
}
