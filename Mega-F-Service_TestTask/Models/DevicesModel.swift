//
//  DevicesModel.swift
//  Mega-F-Service_TestTask
//
//  Created by Сергей Горбачёв on 07.09.2021.
//

import Foundation

struct DevicesModel: Decodable {
    var data: [Datum]
}

struct Datum: Decodable {
    let id: Int
    let name: Name
    let icon: Icon
    let isOnline: Bool
    let type: Int
    let status: String
    let lastWorkTime: Int
}

enum Icon: String, Decodable {
    case imgTest1SVG = "/img/test/1.svg"
    case imgTest2SVG = "/img/test/2.svg"
}

enum Name: String, Decodable {
    case датчикГаза = "Датчик газа"
    case роботПылесос = "Робот - пылесос"
}
