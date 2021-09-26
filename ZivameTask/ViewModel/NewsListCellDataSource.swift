
import UIKit

final class ProductListCellDataSource {
    private let asset: Products?
    
    //Dependencies injection
    init(asset: Products) {
        self.asset = asset
    }
}


