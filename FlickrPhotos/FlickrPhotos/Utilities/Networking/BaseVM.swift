//
//  BaseVM.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import Foundation
import RxCocoa

protocol BaseVMProtocol {
    var showLoading: BehaviorRelay<Bool> { get set }
    var onShowError: ((_ alert: String) -> Void)?  { get set }
}
