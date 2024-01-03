import Foundation

struct UserGit: Codable {
    let login: String
    let id: Int
    let followers: Int
    let avatar_url: String
    let bio: String
}

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
}

class Service {
    
    var dados: UserGit?
    
    func getUser(completion: @escaping(Result<UserGit,Error>) -> Void) {

        let endPoint: String = "https://api.github.com/users/EullerAmaral"
        
        guard let url: URL = URL(string: endPoint) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(UserGit.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                    print("SUCCESS")

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
