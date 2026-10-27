//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

struct PlaceDetails: Decodable {
    let index: Int
    let displayName: String?
    let placeId: String?
    let rating: Double?
    let userRatingCount: Int?
    let latitude: Double?
    let longitude: Double?
    let phoneNumber: String?
    let reviewSummary: String?
    let photoUrl: String?
    let address: String?
    let priceLevel: Int?
    let regionCode: String?
    let photoAuthorName: String?
    let photoAuthorUri: String?
}

struct PlaceDetailsResponse: Decodable {
    let places: [PlaceDetails]
}
