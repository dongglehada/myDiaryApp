//
//  TagCollectionViewCell.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"
    
    private let tagView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
    }
    
    private func setUp(){
        self.addSubview(tagView)
        tagView.layer.cornerRadius = 25
        tagView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    
    
    public func bind(color:UIColor){
        tagView.backgroundColor = color
    }
}
