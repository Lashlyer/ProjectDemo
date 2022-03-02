
import UIKit

class ViewController: UIViewController {
    


    @IBAction func changeNextPageButton(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HomeView"
        
        
    }


}

