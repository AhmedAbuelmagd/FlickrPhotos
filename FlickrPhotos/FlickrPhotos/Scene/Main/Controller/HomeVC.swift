//
//  HomeVC.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Variables & Constants
    let viewModel = HomeVM()
    
    //MARK: - Outlets
    @IBOutlet weak var imagesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTV(imagesTV)
        viewModel.text = "Color"
        title = TITLES.HOME.rawValue
        bindViewModel()
        viewModel.getPhotos()
    }
    
    func initTV(_ TV:UITableView){
        TV.dataSource = self
        TV.delegate = self
        TV.prefetchDataSource = self
        TV.registerNib(cell: ImagesTVCell.self)
        TV.registerNib(cell: ImagesAdsTVCell.self)
    }
}
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photosData.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row % 5 == 0) {
            let cell = tableView.dequeue() as ImagesAdsTVCell
            return cell
        } else {
            let cell = tableView.dequeue() as ImagesTVCell
            if let data = viewModel.photosData.value?[indexPath.row - (indexPath.row / 5)]{
                cell.initCell(cellData: data)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row % 5 == 0) {
            return CGFloat(tableView.frame.width * 0.3)
        } else {
            return CGFloat(tableView.frame.width * 0.562)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
//MARK:- UI Table View Data Source Prefetching
extension HomeVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.preFetch(indexPaths: indexPaths)
    }
    
}
extension HomeVC {
    func bindViewModel() {
        // bind loading
        viewModel.showLoading.bind { [weak self] visible in
            if self != nil {
                visible ? showLoaderForController(getCurrentVC() ?? UIViewController()) : hideLoaderForController(getCurrentVC() ?? UIViewController())
            }
        }
        
        // bind error message
        viewModel.onShowError = { message in
            print(message)
        }
        
        viewModel.photosData.bind {[weak self] albums in
            self?.imagesTV.reloadData()
        }
    }
}

