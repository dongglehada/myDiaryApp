//
//  DetailViewController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUp(){
        view.backgroundColor = .systemBackground
        setUpTextView()
    }
    
    private func setUpTextView(){
        view.addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.showsVerticalScrollIndicator = false
        textView.scrollsToTop = true
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.defaultPadding)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-CGFloat.defaultPadding)
        }
    }
    public func bind(data:MemoData){
        textView.text = data.context
    }

}
