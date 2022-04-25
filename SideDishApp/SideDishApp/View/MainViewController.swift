//
//  ViewController.swift
//  SideDishApp
//
//  Created by Bumgeun Song on 2022/04/18.
//

import UIKit
import Toast_Swift

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    private let viewModel = ProductCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "온반"
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .black
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance

        configureCollectionView()
        registerViews()
        bindViewModel()
    }

    private func registerViews() {
        mainCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        mainCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
    }

    private func configureCollectionView() {
        self.mainCollectionView.collectionViewLayout = CollectionViewLayoutFactory.createMainLayout()
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }

    private func bindViewModel() {
        ProductType.allCases.forEach({ type in
            guard let categoryVM = viewModel.categoryVMs[type] else {return}
            categoryVM.bind { _ in
                DispatchQueue.main.async {
                    let targetIndex = IndexSet(integer: type.index)
                        self.mainCollectionView.reloadSections(targetIndex)
                }
            }
        })

     viewModel.fetchAllCategories()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: Cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.countSection()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.countProduct(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        guard let productVM = viewModel[indexPath] else {return UICollectionViewCell()}
        viewModel.fetchImage(from: productVM.imageURL) { nsData in
            guard let nsData = nsData else { return }
            DispatchQueue.main.async {
                cell.mainImage.image = UIImage(data: Data(referencing: nsData))
            }
        }
        cell.configureCell(product: productVM)
        return cell
    }

    // MARK: Section Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = mainCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView

        let productType = ProductType.allCases[indexPath.section]
        header.setTitle(text: productType.title)
        return header

    }

}
