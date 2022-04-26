//
//  ProductCollectionViewModel.swift
//  SideDishApp
//
//  Created by Kai Kim on 2022/04/20.
//

import Foundation
import UIKit.UIImage
import UIKit
// This is going to represent single viewModel that drives productCollectionView

struct CategorySectionViewModel {
    var type: ProductType
    var productViewModel: [ProductCellViewModel]
}

struct ProductCollectionViewModel {

    private let categoryManager = CategoryManager()
    private var imageCache = NSCache<NSURL, UIImage>()
    private let categoryType = [0: ProductType.main, 1: ProductType.soup, 2: ProductType.side]

    public var cellViewModels: Observable<[CategorySectionViewModel]> = Observable<[CategorySectionViewModel]>([])

    func countProduct(section: Int) -> Int {
        self.cellViewModels.value[section].productViewModel.count
    }

    func countSection() -> Int {
        self.cellViewModels.value.count
    }

    subscript(_ indexPath: IndexPath) -> ProductCellViewModel? {
        let targetType = categoryType[indexPath.item]
        guard let index = cellViewModels.value.firstIndex(where: {$0.type == targetType}) else {return nil}
        let targetCellViewModel = cellViewModels.value[index]
        return targetCellViewModel.productViewModel[indexPath.item]
    }

    func fetchCategories() {
        var temp = [CategorySectionViewModel]()

        let dispatchGroup = DispatchGroup()

        for type in ProductType.allCases {
            dispatchGroup.enter()

            categoryManager.fetchCategory(of: type) { category in
                guard let category = category else {
                    return
                }

                let productCellVMs = category.product.compactMap { product in
                    ProductCellViewModel(product: product)
                }

                let categorySectionVM = CategorySectionViewModel(type: type, productViewModel: productCellVMs)

                temp.append(categorySectionVM)

                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .global(), work: DispatchWorkItem {
            cellViewModels.value = temp
        })
    }

    func fetchImage(from url: URL, then completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.object(forKey: url as NSURL) {
            return completion(image)
        }

        categoryManager.fetchImageData(of: url) { data in
            guard let data = data, let image = UIImage(data: data) else {
                return completion(nil)
            }
            imageCache.setObject(image, forKey: url as NSURL)
            completion(image)
        }
    }
}
