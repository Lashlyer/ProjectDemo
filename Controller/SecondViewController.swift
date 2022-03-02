
import UIKit

class SecondViewController: UIViewController {
    
    private let productViewModel = ProductViewModel(ProductRespository(HttpRequest.shared))
    private var productDatas: [ProductModel] = []
    fileprivate var loadingView: UIView?
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.bindViewModel()
    }
    deinit {
        print("dadjoajdaojda")
    }
    private func bindViewModel() {
        
        self.productViewModel.prepareRequests { [weak self] result in
            switch result {
            case .data(let data):
                self?.productDatas = data
                self?.listCollectionView.reloadData()
                
                UIView.animate(withDuration: 0.5) {
                    self?.loadingView?.alpha = 0
                } completion: {_ in
                    self?.loadingView?.isHidden = true
                    
                }
            case .error(let error):
                print(error)
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
        return self.productDatas.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        item.setUpValue(model: self.productDatas[indexPath.row] )
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailVC.setValue(model: self.productDatas[indexPath.row] )
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
}


extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (self.listCollectionView.bounds.size.width / 4), height: (self.listCollectionView.bounds.size.width / 4))
    }
}

