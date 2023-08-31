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
    
    private let colorAry = TagColor.getColorsAry
    
    private let myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: ((UIScreen.main.bounds.width - CGFloat.defaultPadding * 2) / 5), height: 30)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        return collectionView
    }()
    
    // MARK: - LifeCycle

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
    // MARK: - 메서드

    private func setUp(){
        view.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.tintColor = .myPointColor
        setUpTagLabel()
        setUpCollectionView()
    }
    private func setUpTagLabel(){
        view.addSubview(tagLabel)
        tagLabel.text = "태그"
        tagLabel.textColor = UIColor.systemGray5
        tagLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.defaultPadding)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.defaultPadding)
            make.height.equalTo(30)
        }
    }
    private func setUpCollectionView(){
        view.addSubview(myCollectionView)
//        myCollectionView.backgroundColor = .red
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        myCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(tagLabel.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.defaultPadding)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-CGFloat.defaultPadding)
            make.height.equalTo(30)
        }
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
        cell.bind(color: colorAry[indexPath.row])
        return cell
    }
}
