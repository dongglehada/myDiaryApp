//
//  AddMemoViewController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/31.
//

import UIKit
import SnapKit

final class AddMemoViewController: UIViewController {
    
    private let tagButton = UIButton()
    private let doneButton = UIButton()
    private let textView = UITextView()
    
    private var dataManager = DataManager.shared
    private let colorAry = TagColor.allCases
    private var year = 0
    private var month = 0
    private var day = 0
    private var myTag:TagColor = .red
    
    private let myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 50, height: 50)
        flowLayout.minimumLineSpacing = (UIScreen.main.bounds.width - (50 * 5) - (CGFloat.defaultPadding * 2)) / 4
        flowLayout.minimumInteritemSpacing = 0
        
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpKeyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - setUp
    
    private func setUp(){
        view.backgroundColor = UIColor.systemBackground
        setUpNavigaiton()
        setUpDoneButton()
        setUpTextView()
        setUpTagButton()
        setUpCollectionView()
    }
    
    private func setUpNavigaiton(){
        navigationController?.navigationBar.tintColor = .myPointColor
        navigationItem.title = "새로운 메모"
        navigationItem.titleView?.tintColor = .myPointColor
    }
    
    private func setUpDoneButton(){
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.myPointColor, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    
    private func setUpTextView(){
        view.addSubview(textView)
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.showsVerticalScrollIndicator = false
        textView.text = "택스트를 입력해주세요."
        textView.textColor = UIColor.systemGray4
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(CGFloat.defaultPadding)
        }
    }
    
    private func setUpTagButton(){
        textView.addSubview(tagButton)
        tagButton.layer.cornerRadius = 25
        tagButton.backgroundColor = .systemRed
        tagButton.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
        tagButton.snp.makeConstraints{ make in
            make.width.height.equalTo(50)
            make.bottom.right.equalTo(view.safeAreaLayoutGuide).offset(-CGFloat.defaultPadding)
        }
    }
    
    private func setUpCollectionView(){
        textView.addSubview(myCollectionView)
        myCollectionView.isHidden = true
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.delegate = self
        myCollectionView.isPagingEnabled = true
        myCollectionView.dataSource = self
        myCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        myCollectionView.snp.makeConstraints{ make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(CGFloat.defaultPadding)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - 메서드
    
    public func bind(year:Int,month:Int,day:Int){
        self.year = year
        self.month = month
        self.day = day
    }
    
    @objc func tagButtonTapped(_ sender:UIButton){
        print(#function)
        collectionViewHidden(toggle:myCollectionView.isHidden)
    }
    @objc func doneButtonTapped(_ sender:UIButton){
        print(#function)
        guard let text = textView.text else { return }
        dataManager.memoData.append(MemoData(year: year, month: month, day: day, context: text, tagColor: myTag, id: dataManager.getID))
        navigationController?.popViewController(animated: true)
    }
    
    private func collectionViewHidden(toggle:Bool){
        UIView.transition(with: myCollectionView, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            if toggle{
                self?.myCollectionView.alpha = 1
            } else {
                self?.myCollectionView.alpha = 0
            }
        })
        myCollectionView.isHidden.toggle()
    }
    
    
    
    // MARK: - 키보드 대응
    private func setUpKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            textView.snp.remakeConstraints{ make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.left.right.equalTo(view.safeAreaLayoutGuide).inset(CGFloat.defaultPadding)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(keyboardSize.height)
            }
            tagButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            myCollectionView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification){
        
        textView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(CGFloat.defaultPadding)
        }
        tagButton.transform = CGAffineTransform(translationX: 0, y: 0)
        myCollectionView.transform = CGAffineTransform(translationX: 0, y: 0)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

extension AddMemoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(color: colorAry[indexPath.row].getColor)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.tagButton.backgroundColor = self?.colorAry[indexPath.row].getColor
        }
        myTag = colorAry[indexPath.row]
        collectionViewHidden(toggle: myCollectionView.isHidden)
    }
    
}

extension AddMemoViewController: UITextViewDelegate{
    
    //TextViewDidChange
    func textViewDidChange(_ textView: UITextView) {
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "택스트를 입력해주세요." {
            textView.textColor = .black
            textView.text = ""
        }
    }
}
