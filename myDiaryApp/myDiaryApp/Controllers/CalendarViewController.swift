//
//  ViewController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import UIKit
import SnapKit

final class CalendarViewController: UIViewController {
    
    private var dataManager = DataManager.shared
    private var filterData:[MemoData] = []
    private let mytableView = UITableView()
    private let calendarView = UICalendarView()
    private let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }

    private func setUp(){
        setUpTableView()
        setUpCalenderView()
        setUpAddButton()
    }

    private func setUpTableView(){
        view.addSubview(mytableView)
        mytableView.register(CalendarViewCell.self, forCellReuseIdentifier: CalendarViewCell.identifier)
        mytableView.delegate = self
        mytableView.dataSource = self
        mytableView.backgroundColor = .systemBackground
        
        mytableView.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpCalenderView(){
        let contentView = UIView(frame:(CGRect(x: 0, y: 0, width: view.frame.size.width, height: 400)))
        contentView.addSubview(calendarView)
        calendarView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        calendarView.tintColor = UIColor.myPointColor
        calendarView.backgroundColor = .systemBackground
        calendarView.snp.makeConstraints{ make in
            make.edges.equalTo(contentView)
        }
        mytableView.tableHeaderView = contentView
    }
    
    private func setUpAddButton(){
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = UIColor.myPointColor
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: addButton)]
    }

    @objc func addButtonTapped(_ sender:UIButton){
        print(#function)
        let addPageVC = AddMemoViewController()
        navigationController?.pushViewController(addPageVC, animated: true)
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents else { return }
        guard let year = date.year else { return }
        guard let month = date.month else { return }
        guard let day = date.day else { return }
        filterData = dataManager.memoData.filter{$0.year == year && $0.month == month && $0.day == day}
        mytableView.reloadData()
    }
    
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarViewCell",for: indexPath) as? CalendarViewCell else { return UITableViewCell() }
        cell.bind(data: filterData[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
