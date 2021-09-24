//
//  ProductCell.swift
//  ZivameTask
//
//  Created by Sandeepan Swain on 21/09/21.
//

import UIKit


public protocol ProductListCellData {
    var title: UIElementValue<String> { get }
    var body: UIElementValue<String> { get }
    var footer: UIElementValue<String> { get }
    var icon: UIElementValue<String> { get }
    var cellValue: UIElementValue<String> { get }
}

class ProductCell: UITableViewCell {

    public static let cellId = "ProductListCellId"

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productprice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView?.image = nil
        productprice.text = nil
        productName.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func show(data: Products) {
        productName.text = data.name
        if let price = data.price {
            productprice.text = "\(price)"
        }
        productImageView.loadThumbnail(urlSting: data.image_url!)
    }
}
