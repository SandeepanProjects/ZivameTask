//
//  ViewController.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 21/09/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var productList: UITableView!
    
    var productCellDisplay:[Products] = []
    let manager: StoreManager = StoreManager()
    private var productViewModel: ProductViewModel?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .medium
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setUpView()
        fetchProducts()
    }
    
    private func setUpView() {
        
        /// Setting up navigation bar
        title = NSLocalizedString("GADGETS", comment: "")
        navigationItem.largeTitleDisplayMode = .always
        
        /// Setting up Activity Indicator
        let rightBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setLeftBarButton(rightBarButton, animated: true)
        
        //Refresh Button
        let leftBarButton = UIBarButtonItem(title: NSLocalizedString("Cart", comment: ""),
                                            style: .plain,
                                            target: self,
                                            action: #selector(refreshProducts(_:)))
        navigationItem.setRightBarButton(leftBarButton, animated: true)
        
        /// Setting up table view
        productList.register(UINib(nibName: String(describing: ProductCell.self),
                                   bundle: Bundle(for: ProductCell.self)),
                             forCellReuseIdentifier: ProductCell.cellId)
        productList.tableFooterView = UIView(frame: .zero)

        productList.delegate = self
        productList.dataSource = self
        productList.rowHeight = UITableView.automaticDimension

        productList.accessibilityIdentifier = ConstantIdentifiers.newsTableViewIdentifier.rawValue
    }
    
    private func fetchProducts() {
        activityIndicator.startAnimating()
        Networking.fetchProducts { [weak self] (result) in
            guard let self = self else { return }
            if result == nil {
                DispatchQueue.main.async() {
                    let alert = Alert.init(subTitle: "Error! please try again",
                                           cancelTitle: NSLocalizedString("Cancel", comment: ""))
                    alert.presentAlert(from: self)
                }
            }
            
            if let productsItems = result.products {
                self.productViewModel = ProductViewModel(productData: productsItems)
            }
            /// Reload tableView and dismiss activity indicator
            DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.productList.reloadData()
            }
        }
        
    }
    
    /// Refresh button
    @objc private func refreshProducts(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let newsDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            guard let sortedNews = self.productViewModel?.sortDataForLessValue() else { return ConstantNumber.noOfRows.rawValue }
            return sortedNews.count
        case 1:
            guard let sortedNews = self.productViewModel?.sortDataForGreaterValue() else { return ConstantNumber.noOfRows.rawValue }
            return sortedNews.count
        default:
          return 0
        }       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch (indexPath.section) {
        case 0:
            productCellDisplay = (self.productViewModel?.sortDataForLessValue())!
            
        case 1:
            productCellDisplay = (self.productViewModel?.sortDataForGreaterValue())!
        default:
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.cellId) as? ProductCell {
            cell.show(data: productCellDisplay[indexPath.row])
            return cell
        }
        else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        var sorted: [Products] = []
        switch (indexPath.section) {
        case 0:
            sorted = (self.productViewModel?.sortDataForLessValue())!
        case 1:
            sorted = (self.productViewModel?.sortDataForGreaterValue())!
        default:
              return
        }
        
        print(sorted[indexPath.row])
        manager.storeProduct(prod: sorted[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
            case 0:return "Less Than 1000"
            case 1: return "More Than 1000"
            default :return ""
          }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let data = self.productViewModel?.sortDataForLessValue(), data.count > 0 {
            return 30
        } else { return 0}
    }
}
