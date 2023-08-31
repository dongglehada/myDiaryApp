//
//  AddMemoViewController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import UIKit
import SnapKit

final class AddMemoViewController: UIViewController {

    private let tagLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp(){
        view.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.tintColor = .myPointColor
        setUpTagLabel()
//        print(TagColor.getColorsAry)
    }
    private func setUpTagLabel(){
        view.addSubview(tagLabel)
        tagLabel.text = "gd"
        tagLabel.snp.makeConstraints{ make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}
