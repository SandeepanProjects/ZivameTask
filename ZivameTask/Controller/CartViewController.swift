//
//  CartViewController.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 22/09/21.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    fileprivate let teamCellIdentifier = "teamCellReuseIdentifier"
    
    let manager: StoreManager = StoreManager()
    var productCellDisplay:[Products] = []

//    private lazy var activityIndicator: UIActivityIndicatorView = {
//        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
//        //activityIndicator.center = self.view.center
//        activityIndicator.color = UIColor.black
//
//        return activityIndicator
//    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .gray
        return activityIndicator
    }()
    
   // lazy var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        /// Setting up Activity Indicator
        let rightBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        activityIndicator.startAnimating()
        //self.title = "CART"
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        if let cart = manager.getAll(), cart.count > 0 {
            print(cart)
            productCellDisplay = cart
            setup()
        } else {
            cartTableView.tableFooterView = UIView()
            productCellDisplay = []
            alert(str:"There are no records.")
        }
        reloadtableView()
    }
    
    @IBAction func cartCheckOut(_ sender: Any) {
        
//        self.activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
//        self.view.addSubview(activityIndicator)
        
        if productCellDisplay.count <= 0 {
            alert(str: "You need to add some products to continue.")
            return
        }
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let newsDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController { 
                self?.navigationController?.pushViewController(newsDetailViewController, animated: true)
            }
        })
    }

}

extension CartViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCellDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.cellId) as? ProductCell {
            cell.show(data: productCellDisplay[indexPath.row])
            return cell
        }
        else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CartViewController {
    func alert(str:String) {
        DispatchQueue.main.async() {
            let alert = Alert.init(subTitle: str,
                                   cancelTitle: NSLocalizedString("Cancel", comment: ""))
            alert.presentAlert(from: self)
        }
    }
    
    func reloadtableView() {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
            self.cartTableView.reloadData()
        }
    }
    
    func setup() {
      
         /// Setting up table view
         cartTableView.register(UINib(nibName: String(describing: ProductCell.self),
                                    bundle: Bundle(for: ProductCell.self)),
                              forCellReuseIdentifier: ProductCell.cellId)
         cartTableView.delegate = self
         cartTableView.dataSource = self
         cartTableView.rowHeight = UITableView.automaticDimension
         cartTableView.accessibilityIdentifier = ConstantIdentifiers.newsTableViewIdentifier.rawValue
         cartTableView.tableFooterView = UIView()

     }
}
