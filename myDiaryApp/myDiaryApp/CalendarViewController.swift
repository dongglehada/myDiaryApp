//
//  ViewController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {

    let a = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    private func setUp(){
        view.addSubview(a)
        a.snp.makeConstraints{ make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

