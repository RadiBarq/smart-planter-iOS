//
//  NetworkModel.swift
//  SmartPlanter
//
//  Created by Harri on 5/19/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import Foundation
import SocketIO


struct NetworkModel {
    
    static var baseURL = "http://127.0.0.1:8000/"
    static var planterID = 1
    static var planterType = ""
    static var userName = ""
    static let manager = SocketManager(socketURL: URL(string: "http://192.168.137.49:8000")!, config: [.log(true), .compress, .reconnects(true)])
    static var socket: SocketIOClient!
    
    enum APIError: Error {
        case responseProblem
        case decondingProblem
        case encodingProblem
    }
    
    static func login() {
        
    }
    
    static func getJobs(completion: @escaping(Result<[Job], APIError>) -> Void) {
        
        guard let url = URL(string: baseURL + "api/planters/" + String(planterID) + "/jobs/") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let response = try JSONDecoder().decode(JobsResult.self, from: jsonData)
                completion(.success(response.jobs))
            } catch {
                completion(.failure(.decondingProblem))
            }
        }
        
        dataTask.resume()
    }
    
    static func updateJobs(job: Job, completion: @escaping () -> Void) {
        do {
            guard let url = URL(string: baseURL + "api/planters/" + String(planterID) + "/jobs/" + job.name + "/") else {
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(job)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    return
                }
                completion()
            }
            dataTask.resume()
        }
        catch(let error) {
            print(error)
        }
    }
    
    static func getJobHistory(jobURL: String, completion: @escaping(Result<[JobHistory], APIError>) -> Void) {
        guard let url = URL(string: baseURL + jobURL) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let response = try JSONDecoder().decode(JobHistoryResult.self, from: jsonData)
                completion(.success(response.jobs))
            } catch {
                completion(.failure(.decondingProblem))
            }
        }
        dataTask.resume()
    }
    
    static func getPlantsType(completion: @escaping(Result<[Plant], APIError>) -> Void) {
        
        guard let url = URL(string: baseURL + "api/plantstype/") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let response = try JSONDecoder().decode(PlantsTypeResult.self, from: jsonData)
                completion(.success(response.plants))
            } catch {
                completion(.failure(.decondingProblem))
            }
        }
        dataTask.resume()
    }
    
    static func gePlanter(completion: @escaping(Result<PlanterResult, APIError>) -> Void) {
        
        guard let url = URL(string: baseURL + "api/planters/" + String(planterID) + "/") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let response = try JSONDecoder().decode(PlanterResult.self, from: jsonData)
                planterID = response.id
                planterType = response.plant_type
                userName = response.name
                completion(.success(response))
            } catch(let error) {
                print(error)
                completion(.failure(.decondingProblem))
            }
        }
        dataTask.resume()
    }
    
    static func getImages(completion: @escaping(Result<[Image], APIError>) -> Void) {
        guard let url = URL(string: baseURL + "api/planters/" + String(planterID) + "/images") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let response = try JSONDecoder().decode(ImagesResult.self, from: jsonData)
                completion(.success(response.images))
            } catch(let error) {
                print(error)
                completion(.failure(.decondingProblem))
            }
        }
        dataTask.resume()
    }
    
    static func connectSocket() {
        self.socket = self.manager.defaultSocket
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
    }
    
    static func moveLeft() {
        self.socket.emit("left","hi")
    }
    
    static func moveRight() {
        self.socket.emit("right","hi")
    }
    
    static func moveUp() {
        self.socket.emit("forward","hi")
    }
    
    static func moveDown() {
        self.socket.emit("backward","hi")
    }
}
