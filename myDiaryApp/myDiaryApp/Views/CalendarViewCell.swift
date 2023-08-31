//
//  CalendarViewCell.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import UIKit

class CalendarViewCell: UITableViewCell {

    static let identifier = "CalendarViewCell"
    
    lazy var cellView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp(){
        self.addSubview(cellView)
        cellView.backgroundColor = .blue
        cellView.layer.cornerRadius = 5
        cellView.snp.makeConstraints{ make in
            make.width.height.equalTo(10)
            make.left.equalTo(self.snp.left)
            make.centerY.equalTo(self.snp.centerY)
        }
    }

}
