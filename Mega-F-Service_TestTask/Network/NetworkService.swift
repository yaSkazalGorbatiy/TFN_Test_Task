//
//  NetworkManager.swift
//  Mega-F-Service_TestTask
//
//  Created by Сергей Горбачёв on 07.09.2021.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func requestDevices(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlString = "https://dev.api.sls.ompr.io/api/v1/test/devices"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
