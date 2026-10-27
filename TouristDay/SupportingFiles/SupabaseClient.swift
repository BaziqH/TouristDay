//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

import UIKit
import Supabase

//struct PlanService {
//    
//    private let client = SupabaseClient(
//        supabaseURL: URL(string: "https://ugrqxlezhplzsohybmyz.supabase.co")!,
//        supabaseKey: "sb_publishable_AGfXnzSrgOjx28RYKz4xTQ_pH07lNHY"
//    )
//    
//    private let decoder: JSONDecoder = {
//        let d = JSONDecoder()
//        d.keyDecodingStrategy = .convertFromSnakeCase
//        return d
//    }()
//    
//    func fetchPlan(city: String, mood: String, budget: String) async throws -> Plan {
//        print("City: \(city), Mood: \(mood), Budget: \(budget)")
//        do {
//            let data: Plan = try await client.functions.invoke(
//                "plan-generation",
//                options: FunctionInvokeOptions(
//                    body: PlanRequest(city: city, mood: mood, budget: budget)
//                ),
//                decoder: decoder
//                
//            )
//            print("SUPABASE RESPONSE: \(data)")
//            
//            return data
//        } catch {
//            print("INVOCATION OR DECODING ERROR: \(error)")
//            throw error
//        }
//    }
//}



struct PlaceDetailsRequest: Encodable {
    struct Item: Encodable {
        let placeId: String?
        let placeName: String
    }
    let city: String
    let places: [Item]
}

struct PlanService {

    private let functionURL = URL(string: "https://ugrqxlezhplzsohybmyz.supabase.co/functions/v1/plan-generation")!
    private let detailsURL = URL(string: "https://ugrqxlezhplzsohybmyz.supabase.co/functions/v1/places-verfication")!
    private let apiKey = "sb_publishable_AGfXnzSrgOjx28RYKz4xTQ_pH07lNHY"

    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()

    func streamPlan(city: String, mood: String, budget: String) -> AsyncThrowingStream<PlanEvent, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    var request = URLRequest(url: functionURL)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.setValue(apiKey, forHTTPHeaderField: "apikey")
                    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
                    request.httpBody = try JSONEncoder().encode(PlanRequest(city: city, mood: mood, budget: budget))

                    let (bytes, response) = try await URLSession.shared.bytes(for: request)
                    if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
                        throw PlanError.http(http.statusCode)
                    }

                    var event = ""
                    for try await line in bytes.lines {
                        if line.hasPrefix("event:") {
                            event = line.dropFirst(6).trimmingCharacters(in: .whitespaces)
                        } else if line.hasPrefix("data:") {
                            let data = Data(line.dropFirst(5).trimmingCharacters(in: .whitespaces).utf8)
                            switch event {
                            case "status":
                                let s = try decoder.decode([String: String].self, from: data)
                                continuation.yield(.status(s["stage"] ?? ""))
                            case "title":
                                let t = try decoder.decode([String: String].self, from: data)
                                continuation.yield(.title(t["title"] ?? ""))
                            case "activity":
                                continuation.yield(.activity(try decoder.decode(Activity.self, from: data)))
                            case "done":
                                struct Done: Decodable { let placeIds: [String?] }
                                continuation.yield(.done(try decoder.decode(Done.self, from: data).placeIds))
                            case "error":
                                let e = try decoder.decode([String: String].self, from: data)
                                throw PlanError.server(e["error"] ?? "Unknown error")
                            default:
                                break
                            }
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }

    func fetchDetails(city: String, activities: [Activity]) async throws -> [PlaceDetails] {
        var request = URLRequest(url: detailsURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try encoder.encode(
            PlaceDetailsRequest(
                city: city,
                places: activities.map { .init(placeId: $0.placeId, placeName: $0.placeName) }
            )
        )

        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw PlanError.http(http.statusCode)
        }
        return try decoder.decode(PlaceDetailsResponse.self, from: data).places
    }
}
