/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
    
import Foundation

struct PhotonResponse: Codable {
    let features: [PhotonFeature]
}

struct PhotonFeature: Codable {
    let properties: PhotonProperties
}

struct PhotonProperties: Codable {
    let name: String?
    let city: String?
    let country: String?
    let state: String?
}
