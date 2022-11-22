
import Alamofire
import Foundation

class NetworkManager {

    static let host = "http://34.145.188.36"

    static func getAllTickets(completion: @escaping ([Ticket]) -> Void) {
        let endpoint = "\(host)/tasks/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            
            switch response.result {
            case .success(let data):
       
                let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                if let userResponse = try? jsonDecoder.decode(TicketResponse.self, from: data) {
                    completion(userResponse.tasks)
                } else {
                    print("Failed to decode getAllTickets")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getTicketById(id: Int, completion: @escaping (Ticket) -> Void) {
        let endpoint = "\(host)/tasks/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            
            switch response.result {
            case .success(let data):
       
                let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                if let userResponse = try? jsonDecoder.decode(Ticket.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode getAllTickets")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


    static func createTicket(description: String, completion: @escaping (Ticket) -> Void) {
        let endpoint = "\(host)/tasks/"
        let params: Parameters = [
            "description": description
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Ticket.self, from: data){
                    completion(userResponse)
                    
                } else {
                    print("failed to decode createTicket")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        
    }
    
    static func updateTicket(id: Int, description: String, done: Bool, completion: @escaping (Ticket) -> Void) {
        let endpoint = "\(host)/tasks/\(id)/"
        let params: Parameters = [
            "description": description,
            "done": done
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData {
            response in
            
            switch response.result {
            case .success(let data):
                
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Ticket.self, from: data){
                    completion(userResponse)
                    
                } else {
                    print("failed to decode createTicket")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }


    }
    
    static func deleteTicket(id: Int, completion: @escaping (Ticket) -> Void) {
        let endpoint = "\(host)/tasks/\(id)/"
        
        AF.request(endpoint, method: .delete).validate().responseData {
            response in
            switch response.result {
            
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Ticket.self, from: data){
                    completion(userResponse)
                } else {
                    print("failed to decode createTicket")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
