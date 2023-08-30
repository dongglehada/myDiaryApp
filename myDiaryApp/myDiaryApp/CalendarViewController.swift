//
//  ViewController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {

    private let mytableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    
    private let calendarView = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.myBackgroundColor
        setUp()
    }

    private func setUp(){
        setUpTableView()
        setUpCalenderView()
    }

    private func setUpTableView(){
        view.addSubview(mytableView)
        mytableView.register(CalendarViewCell.self, forCellReuseIdentifier: CalendarViewCell.identifier)
        mytableView.delegate = self
        mytableView.dataSource = self
        mytableView.backgroundColor = UIColor.myBackgroundColor
        mytableView.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpCalenderView(){
        let contentView = UIView(frame:(CGRect(x: 0, y: 0, width: view.frame.size.width, height: 450)))
        contentView.addSubview(calendarView)
        contentView.backgroundColor = UIColor.myBackgroundColor
        calendarView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        calendarView.backgroundColor = .systemBackground
        calendarView.layer.cornerRadius = 12
        calendarView.tintColor = UIColor.myBackgroundColor
        calendarView.snp.makeConstraints{ make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(CGFloat.defaultPadding)
            make.right.equalTo(contentView).offset(-CGFloat.defaultPadding)
            make.bottom.equalTo(contentView).offset(-CGFloat.defaultPadding)
        }
        mytableView.tableHeaderView = contentView
    }

}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents else { return }
        print(date)
    }
    
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarViewCell",for: indexPath) as? CalendarViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
