//
//  API.swift
//  Fitness
//
//  Created by Keivan Shahida on 4/24/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import Moya

enum FitnessAPI {
    
    //Gyms
    case gyms
    case gym(gymId: Int)
    
    //Gym Class Instances
    case gymClassInstances
    case gymClassInstance(gymClassInstanceId: Int)
    case gymClassInstancesPaginated(page: Int, pageSize: Int)
    case gymClassInstancesByDate(date: String)
    
    //Class Descriptions
    case gymClassDescriptions
    case gymClassDescription(gymClassDescriptionId: Int)
    case gymClassDescriptionsByTag(tag: Int)

    
    //Tags
    case tags
    
    //Gym Classes
    case gymClasses
    case gymClass(gymClassId: Int)
    
    //Instructors
    case instructors
    case instructor(instructorId: Int)
    
    //Favorites
    case favorite(gymClassId: Int)
}

extension FitnessAPI: TargetType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "http://localhost:5000/api/v0/" //temp
        case .development: return "http://localhost:5000/api/v0/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .gyms: return "gyms"
        case .gym(let gymId): return "gym/\(gymId)"
            
        case .gymClassInstances: return "gymclassinstances"
        case .gymClassInstance(let gymClassInstanceId): return "gymclassinstance/\(gymClassInstanceId)"
        case .gymClassInstancesPaginated(let page, let pageSize): return "gymclassinstances?page=\(page)&page_size=\(pageSize)"
        case .gymClassInstancesByDate(let date): return "gymclassinstances/\(date)"
            
        case .gymClassDescriptions: return "class_descs"
        case .gymClassDescription(let classDescriptionId): return "class_descs/\(classDescriptionId)"
        case .gymClassDescriptionsByTag(let tag): return "class_descs/\(tag)"

        case .tags: return "tags"
            
        case .gymClasses: return "gymclasses"
        case .gymClass(let gymClassId): return "gymclass/\(gymClassId)"
            
        case .instructors: return "instructors"
        case .instructor(let instructorId): return "instructor/\(instructorId)"
            
        case .favorite(let gymClassId): return "favorite/\(gymClassId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .favorite:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .favorite(let gymClassId):
            var parameters = [String: Any]()
            parameters["gymclass_id"] = gymClassId
            return parameters
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task { // double check temp
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
