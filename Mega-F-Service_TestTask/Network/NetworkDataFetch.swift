//
//  NetworkDataFetch.swift
//  Mega-F-Service_TestTask
//
//  Created by Сергей Горбачёв on 07.09.2021.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchDevices(responce: @escaping (DevicesModel?, Error?) -> Void) {
        NetworkService.shared.requestDevices { result in
            switch result {
            
            case .success(let data):
                do {
                    let devices = try JSONDecoder().decode(DevicesModel.self, from: data)
                    responce(devices, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil, error)
               
            }
        }
    }
}
