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
    private let tagButton = UIButton()
    private let myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 50, height: 50)
        flowLayout.minimumLineSpacing = (UIScreen.main.bounds.width - (50 * 5) - (CGFloat.defaultPadding * 2)) / 4
        flowLayout.minimumInteritemSpacing = 0
        
        return collectionView
    }()
    private let doneButton = UIButton()
    private let deleteButton = UIButton()
    
    private var dataManager = DataManager.shared
    private var index = 0
    
    // MARK: - Life Cycle
    
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
    
    // MARK: - SetUp
    
    private func setUp(){
        view.backgroundColor = .systemBackground
        setUpTextView()
        setUpTagButton()
        setUpDoneButton()
        setUpCollectionView()
        setUpKeyBoard()
    }
    
    private func setUpTextView(){
        view.addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.showsVerticalScrollIndicator = false
        textView.scrollsToTop = true
        textView.delegate = self
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.defaultPadding)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-CGFloat.defaultPadding)
        }
    }
    private func setUpTagButton(){
        textView.addSubview(tagButton)
        tagButton.layer.cornerRadius = 25
        tagButton.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
        tagButton.snp.makeConstraints{ make in
            make.width.height.equalTo(50)
            make.bottom.right.equalTo(view.safeAreaLayoutGuide).offset(-CGFloat.defaultPadding)
        }
    }
    
    private func setUpDoneButton(){
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.setTitleColor(.myPointColor, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.myPointColor, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: doneButton),UIBarButtonItem(customView: deleteButton)]
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
    // MARK: - ButtonTapped
    
    @objc func tagButtonTapped(_ sender:UIButton){
        collectionViewHidden(toggle:myCollectionView.isHidden)
    }
    
    @objc func doneButtonTapped(_ sender:UIButton){
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonTapped(_ sender:UIButton){
        print(#function)
        let alret = UIAlertController(title: "삭제", message: "메모를 삭제하시겠습니까?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .default, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
            self.dataManager.memoData.remove(at: self.index)
        })
        alret.addAction(no)
        alret.addAction(yes)
        present(alret, animated: true, completion: nil)
    }
    
    // MARK: - 메서드

    
    public func bind(data:MemoData){
        textView.text = data.context
        guard let index = dataManager.memoData.map({$0.id}).firstIndex(of: data.id) else { return }
        self.index = index
        tagButton.backgroundColor = data.tagColor.getColor
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


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TagColor.colorArys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(color: TagColor.colorArys[indexPath.row].getColor)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.tagButton.backgroundColor = TagColor.colorArys[indexPath.row].getColor
        }
        collectionViewHidden(toggle: myCollectionView.isHidden)
        dataManager.memoData[self.index].tagColor = TagColor.colorArys[indexPath.row]
        
    }
    
}

extension DetailViewController: UITextViewDelegate{
    
    //TextViewDidChange
    func textViewDidChange(_ textView: UITextView) {
        dataManager.memoData[self.index].context = textView.text
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
}
