//
//  BaseVM.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import Foundation

protocol BaseVMProtocol {
    var showLoading: Bindable<Bool> { get set }
    var onShowError: ((_ alert: String) -> Void)?  { get set }
}
