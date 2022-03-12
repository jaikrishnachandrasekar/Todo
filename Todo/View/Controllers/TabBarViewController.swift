//
//  TabBarViewController.swift
//  Todo
//
//  Created by admin on 3/10/22.
//

import UIKit
import FittedSheets

class TabBarViewController: UITabBarController, UISearchResultsUpdating, UISearchControllerDelegate, UITabBarControllerDelegate{
    
    @IBOutlet weak var tabNavigationItem: UINavigationItem!
    
    @IBAction func addNewClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CreateTodo", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "createTodo")
        let sheetController = SheetViewController(controller: vc, sizes: [ .percent(0.5), .percent(0.75), .fullscreen])
        self.present(sheetController, animated: false, completion: nil)
        
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabNavigationItem.title = item.title;
    }

    // UITabBarControllerDelegate
  //  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
  //      print("Selected view controller")
 //   }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        
        
        DataController.instance.getTodoListData(searchString: text){(data) in
            DispatchQueue.main.async {
            if(self.selectedViewController is TodoViewController){
                let todoController = self.selectedViewController as! TodoViewController
                todoController.todolistData = data;
                    todoController.todoTableView.reloadData();
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.searchTextField.autocapitalizationType = .none;
        self.navigationItem.searchController = searchController;
        
    }
    

 

}
