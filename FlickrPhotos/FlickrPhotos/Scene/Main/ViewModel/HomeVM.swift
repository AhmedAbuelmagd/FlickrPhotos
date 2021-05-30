//
//  HomeVM.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import Foundation

protocol HomeVMProtocol {
    var albumId: Int { get set }
    var photosData: Bindable<[Photo]?> { get set }
    func getPhotos()
    var text: String? { get set }
}

class HomeVM: BaseVMProtocol, HomeVMProtocol {
    var text: String?
    var page = 1
    var per_page = 20
    
    var albumId: Int = 0
    var isPaging: Bool = true
    
    var isFetching: Bool = false
    var photosData = Bindable<[Photo]?>(nil)
    var showLoading: Bindable = Bindable(false)
    var onShowError: ((String) -> Void)?
    
    let apiClient: NetworkManager
    init(apiClient: NetworkManager = NetworkManager()) {
        self.apiClient = apiClient
    }
    func getPhotos() {
        showLoading.value = true
        apiClient.getPhotos(method: Config.METHOD, page: page , format: Config.FORMAT, nojsoncallback: 50, api_key: Config.API_KEY, text: "Color", per_page: per_page ){ [weak self] result in
            self?.showLoading.value = false
            switch result {
            case .success(let photosList):
                print("Response => \(photosList) <=")
//                self?.photosData.value = photosList.photos?.photo
                if (self?.page == 1){
                    
                    self?.photosData.value = photosList.photos?.photo
//                    for item in self?.photosData.value ?? []{
//                        let photoList = PhotosList(context: PresestanceServics.context)
//                        photoList.imageUrl = item.imageUrl
//                    }
                }else{
                    self?.photosData.value?.append(contentsOf: photosList.photos?.photo ?? [])
                }
            case .failure(let error):
                print("Error => \(error) <=")
                if let errors = error as? GetApiFailureReason {
                    self?.onShowError?(errors.getErrorMessage() ?? Errors.UNKNOWN.rawValue)
                }else {
                    self?.onShowError?(Errors.UNKNOWN.rawValue)
                }
            }
        }
    }
    func preFetch(indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (photosData.value?.count ?? 0) - 3 && !isFetching && isPaging{
                page += 1
                getPhotos()
                break
            }
        }
    }
}
