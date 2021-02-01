//
//  SecondViewController.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/28.
//

import UIKit

class SecondViewController: UIViewController {
    
    private let productViewModel = ProductViewModel()
    
    fileprivate var loadingView: UIView?
        
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productViewModel.prepareRequest()
        self.bindViewModel()
        self.initView()
    }
    
    private func bindViewModel() {
        
        productViewModel.onRequestEnd = { [weak self] in
            
            guard let self = `self` else { return }
            
            DispatchQueue.main.async {
                
                self.listCollectionView.reloadData()
                
                UIView.animate(withDuration: 0.5) {
                    self.loadingView?.alpha = 0
                } completion: {_ in
                    self.loadingView?.isHidden = true
                    
                }
            }
        }
    }
    
    
    private func initView() {
        
        self.title = "SecondView"
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
        self.listCollectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let width = Int(self.listCollectionView.bounds.size.width)
        layout.itemSize = CGSize(width: (width / 4), height: (width / 4))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = .zero
        self.listCollectionView.collectionViewLayout = layout
        
        self.loadingView = LoadingView(uiview: self.view, color: .white, alpha: 1)
        self.view.addSubview(loadingView ?? UIView())

    }
    
    
}


extension SecondViewController: UICollectionViewDelegate {
    
    
}


extension SecondViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productViewModel.productData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        item.setUpValue(model: self.productViewModel.productData?[indexPath.row] ?? ProductModel())

        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailVC.setValue(model: self.productViewModel.productData?[indexPath.row] ?? ProductModel())
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
}


extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (self.listCollectionView.bounds.size.width / 4), height: (self.listCollectionView.bounds.size.width / 4))
    }
}

