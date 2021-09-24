

import UIKit

/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}

final class Networking: NSObject {
    
    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public functions
    
    public static func fetchProducts(shouldFail: Bool = false, completion: @escaping (_ eventsdata:Product) ->Void ) {
        let urlString: String? = EndPoints.prod.rawValue
        
        guard let mainUrlString = urlString,  let url = URL(string: mainUrlString) else { return }
        
        let task = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            
            if let error = error {
               // completion(error)
                print(error)
                return
            }
            
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                let json = try? decoder.decode(Product.self, from: data)
                if let res = json {
                    completion(json!)
                }
            } catch let error {
               // completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }

    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        Networking.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}

