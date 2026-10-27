//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

struct PlanRequest: Encodable {
    let city: String
    let mood: String
    let budget: String
}

struct Activity: Decodable {
    let time: String
    let title: String
    let placeName: String
    let description: String?
    var placeId: String?
}

struct Plan: Decodable {
    var title: String
    var activities: [Activity]
}

enum PlanEvent {
    case status(String)
    case title(String)
    case activity(Activity)
    case done([String?])
}

enum PlanError: Error {
    case http(Int)
    case server(String)
}

enum Mood {
    case food
    case culture
    case travel
    case nature
    case shopping
    case cinema
    
    var promptValue: String {
        switch self {
        case .food: return "food and dining"
        case .culture: return "cultural and arts"
        case .travel: return "travel and sightseeing"
        case .nature: return "nature and outdoors"
        case .shopping: return "shopping"
        case .cinema: return "cinema"
        }
    }
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .food
        case 1: self = .culture
        case 2: self = .travel
        case 3: self = .nature
        case 4: self = .shopping
        case 5: self = .cinema
        default: self = .food
        }
    }
}

enum Budget {
    case low
    case medium
    case high
    
    var promptValue: String {
        switch self {
        case .low: return "low"
        case .medium: return "medium"
        case .high: return "high"
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 1:
            self = .low
        case 2:
            self = .medium
        case 3:
            self = .high
        default:
            self = .low
        }
    }
}
