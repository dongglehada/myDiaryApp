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
    private var isChoiceDate = false
    private var year = Date.nowYear
    private var month = Date.nowMonth
    private var day = Date.nowDay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        if isChoiceDate {
            filterData = dataManager.memoData.filter{$0.year == year && $0.month == month && $0.day == day}
            mytableView.reloadData()
        }
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
        addButton.layer.cornerRadius = 12
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.myPointColor.cgColor
        addButton.tintColor = UIColor.myPointColor
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.snp.makeConstraints{ make in
            make.width.height.equalTo(30)
        }
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: addButton)]
    }

    @objc func addButtonTapped(_ sender:UIButton){
        print(#function)
        let addPageVC = AddMemoViewController()
        addPageVC.bind(year: year, month: month, day: day)
        navigationController?.pushViewController(addPageVC, animated: true)
    }
    private func tableviewReload(){
        UIView.transition(with: mytableView,duration: 0.3,options: .transitionCrossDissolve,animations: { self.mytableView.reloadData() })
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents else { return }
        guard let year = date.year, let month = date.month, let day = date.day else { return }
        filterData = dataManager.memoData.filter{$0.year == year && $0.month == month && $0.day == day}
        self.year = year
        self.month = month
        self.day = day
        isChoiceDate = true
        tableviewReload()
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let idArys = dataManager.memoData.map{$0.id}
            guard let target = idArys.firstIndex(of: filterData[indexPath.row].id) else { return }
            dataManager.memoData.remove(at: target)
            filterData.remove(at: indexPath.row)
            mytableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.bind(data: filterData[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
