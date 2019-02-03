import UIKit
import XLPagerTabStrip


class MuchViewController:
    
    
ButtonBarPagerTabStripViewController {
    
    
    
    override func viewDidLoad() {
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.white
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        settings.style.buttonBarMinimumLineSpacing = 0
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let firstVC = UIStoryboard(name: "MuchSelect", bundle: nil).instantiateViewController(withIdentifier: "Friend")
        let secondVC = UIStoryboard(name: "MuchSelect", bundle: nil).instantiateViewController(withIdentifier: "Custom")
        let thirdVC = UIStoryboard(name: "MuchSelect", bundle: nil).instantiateViewController(withIdentifier: "Marry")
        let fourthVC = UIStoryboard(name: "MuchSelect", bundle: nil).instantiateViewController(withIdentifier: "Live")
        
        
        let childViewControllers:[UIViewController] = [firstVC, secondVC, thirdVC, fourthVC]
        return childViewControllers
    }
}

