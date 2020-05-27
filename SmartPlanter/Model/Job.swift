//
//  Job.swift
//  SmartPlanter
//
//  Created by Harri on 5/19/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import Foundation

struct JobHistoryResult: Decodable {
    let jobs: [JobHistory]
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.jobs = try container.decode([JobHistory].self)
    }
}

struct JobsResult: Decodable {
    let jobs: [Job]
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.jobs = try container.decode([Job].self)
    }
}

struct JobHistory: Decodable {
    let id: Int
    let created: String
    let value: Double
    let planter: Int
    let current_time: String
}

struct Job: Codable {
    let name: String
    let current_time: String
    let last_executed: String
    var when_to_execute: Int
    let created: String
    let url: String
    var status: Bool
    let planter: Int
}

struct PlantsTypeResult: Decodable {
    let plants: [Plant]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.plants = try container.decode([Plant].self)
    }
}

struct Plant: Decodable {
    let name: String
    let created: String
    let current_time: String
}

struct PlanterResult: Decodable {
    let id: Int
    let WaterLevel: Double
    let Moisture: Double
    let Temperature: Double
    let Humidity: Double
    let image: String
    let Lighting: [Double]
    let name: String
    let created: String
    let plant_type: String
    let jobs: [Job]
}

struct ImagesResult: Decodable {
    let images: [Image]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.images = try container.decode([Image].self)
    }
}

struct Image: Decodable {
    let image: String
    let current_time: String
}
