//
//  ListCollectionViewCell.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/28.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    fileprivate var data: ProductModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()

    }
    
    
    private func initView() {
        
        self.titleLabel.numberOfLines = 0
        self.itemImageView.contentMode = .scaleToFill
        
    }
    
    func setUpValue(model: ProductModel) {
        
        self.data = model
        self.titleLabel.text = model.title
        self.itemImageView.image = UIImage(named: "noimage")
        
        guard let url = URL(string: model.url) else { return }
        NetworkController.shared.fetchImage(url: url) { [weak self] (image) in
            guard let self = `self` else { return }
            DispatchQueue.main.async {
                if model.title == self.data?.title {
                    self.itemImageView.image = image
                }
            }
        }
    }
}
