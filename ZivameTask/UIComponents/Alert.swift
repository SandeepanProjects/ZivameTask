

import UIKit


final public class Alert {
    let title: String?
    let subTitle: String?
    let buttonTitles: [String]?
    let cancelTitle: String
    
    public init (title: String? = nil,
                 subTitle: String? = nil,
                 buttonTitles:[String]? = nil,
                 cancelTitle: String) {
        self.title = title
        self.subTitle = subTitle
        self.buttonTitles = buttonTitles
        self.cancelTitle = cancelTitle
    }
    
    public func presentAlert(from: UIViewController,
                             actionHandler: ((UIAlertAction, Int) -> Void)? = nil,
                                   cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: subTitle,
                                      preferredStyle: .alert)
        
        buttonTitles?.forEach {
            let action = UIAlertAction(title: $0,
                                       style: .default,
                                       handler: { [weak alert] action in
                                        let index = (alert?.actions.firstIndex(of: action) ?? ConstantNumber.noOfRows.rawValue) as Int
                                        guard let actionHandler = actionHandler else { return }
                                        actionHandler(action, index)
            })
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel,
                                         handler: { action in
                                            guard let handler = cancelHandler else { return }
                                            handler(action)
                                            
        })
        alert.addAction(cancelAction)
        from.present(alert, animated: true, completion: nil)
    }
}

