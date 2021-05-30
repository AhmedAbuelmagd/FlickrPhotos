//
//  Photo.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

struct Photo : Codable {
    var id : String?
    var owner : String?
    var secret : String?
    var server : String?
    var farm : Int?
    var title : String?
    var ispublic : Int?
    var isfriend : Int?
    var isfamily : Int?
    var imageUrl: String {
        return "https://live.staticflickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "").jpg"
    }
}
