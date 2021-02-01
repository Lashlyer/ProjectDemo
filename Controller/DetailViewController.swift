//
//  DetailViewController.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/30.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var listTabelView: UITableView!
    
    fileprivate var detailData: OkModel?
    
    fileprivate var scrollView: UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initView()
    }
    
    
    
    func setValue(model: OkModel) {
        
        self.detailData = model
        
    }
    
    
    private func initView() {
        
        self.listTabelView.delegate = self
        self.listTabelView.dataSource = self
        self.listTabelView.separatorStyle = .none
        self.listTabelView.rowHeight = UITableView.automaticDimension
        self.listTabelView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
    }
    
}


extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell else {return UITableViewCell()}
        
        cell.setValue(model: self.detailData ?? OkModel())
        return cell
    }
    
    
    
}

