//
//  DataManager.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import Foundation

class DataManager{
    
    static let shared = DataManager()
    
    private var count = -1
    
    public var getID: Int{
        count += 1
        return count
    }
    
    public var memoData:[MemoData] = [
        MemoData(year: 2023, month: 8, day: 31, context: "red", tagColor: .red, id: 0),
    ]
    
    private init(){
        
    }
}
