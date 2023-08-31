//
//  CalendarViewCell.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import UIKit

class CalendarViewCell: UITableViewCell {

    static let identifier = "CalendarViewCell"
    
    private let trailView = UIView()
    private let tagView = UIView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        setUpTagView()
        setUpTitle()
    }

    private func setUpTagView(){
        self.addSubview(tagView)
        tagView.layer.cornerRadius = 5
        tagView.snp.makeConstraints{ make in
            make.width.height.equalTo(10)
            make.left.equalTo(self.snp.left).offset(CGFloat.defaultPadding)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    private func setUpTitle(){
        self.addSubview(titleLabel)
        titleLabel.text = "안녕하세요~"
        titleLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(tagView.snp.right).offset(CGFloat.defaultPadding)
            make.right.equalTo(self.snp.right).offset(-CGFloat.defaultPadding)
        }
    }
    
    public func bind(data:MemoData){
        tagView.backgroundColor = data.tagColor.getColor
        titleLabel.text = data.context
    }

}
