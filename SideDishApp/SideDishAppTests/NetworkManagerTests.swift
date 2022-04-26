//
//  NetworkManagerTests.swift
//  SideDishAppTests
//
//  Created by Bumgeun Song on 2022/04/20.
//

import XCTest
@testable import SideDishApp

class NetworkManagerTests: XCTestCase {

    let networkManager = NetworkManager()

    func testExample() throws {
        let two = 2
        XCTAssertEqual(1+1, two)
    }

    func testFetchProducts() throws {
        let promise = XCTestExpectation(description: "Fetch products success")

        networkManager.fetchProducts(of: ProductType.main) { products in
            XCTAssertNotNil(products)
            promise.fulfill()
        }

        wait(for: [promise], timeout: 1)
    }

    func testFetchImageData() throws {
        let promise = XCTestExpectation(description: "Fetch Image data success")

        // Prepare Stub
        let fileName = "1155_ZIP_P_0081_T"
        let fileExtension = "jpg"

        guard let localImageURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let localImageData = try? Data(contentsOf: localImageURL) else {
            return XCTFail()
        }

        var components = URLComponents()
        components.scheme = "https"
        components.host = "public.codesquad.kr"
        components.path = "/jk/storeapp/data/main/"
        components.path += "\(fileName).\(fileExtension)"
        guard let url = components.url else { return }

        networkManager.fetchImageData(url: url) { data in
            XCTAssertEqual(localImageData, data)
            promise.fulfill()
        }

        wait(for: [promise], timeout: 2)
    }
}
