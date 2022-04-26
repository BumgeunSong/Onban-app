//
//  NetworkingManager.swift
//  SideDishApp
//
//  Created by Bumgeun Song on 2022/04/20.
//

import Foundation
import Alamofire

struct NetworkManager {

    func fetchProducts(of type: ProductType, completion: @escaping ([Product]?) -> Void) {

        guard let url = makeCategoryURL(of: type) else { return completion(nil) }

        AF.request(url).validate().responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let response):
                return completion(response.body)
            case .failure(let error):
                SystemLog.fault(error.localizedDescription)
                return completion(nil)
            }
        }
    }

    private func makeCategoryURL(of type: ProductType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.codesquad.kr"
        components.path = "/onban/\(type)"

        guard let url = components.url else {
            SystemLog.fault(NetworkError.wrongEndPoint.localizedDescription)
            return nil
        }

        return url
    }

    func fetchImageData(url: URL, completion: @escaping (Data?) -> Void) {

        guard let url = changeSchemeToHTTPS(url) else { return }

        AF.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                return completion(data)
            case .failure(let error):
                SystemLog.fault(error.localizedDescription)
                return completion(nil)
            }
        }
    }

    private func changeSchemeToHTTPS(_ url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }

        components.scheme = "https"

        return components.url
    }

    func fetchDetail(of hash: String, completion: @escaping (ProductDetail?) -> Void) {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.codesquad.kr"
        components.path = "/onban/detail/\(hash)"

        guard let url = components.url else {
            SystemLog.fault(NetworkError.wrongEndPoint.localizedDescription)
            return completion(nil)
        }

        AF.request(url).validate().responseDecodable(of: ProductDetail.self) { response in
            switch response.result {
            case .success(let productDetail):
                completion(productDetail)
            case .failure(let error):
                SystemLog.fault(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
