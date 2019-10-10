//
//  User.swift
//
//  Created by Robert on 6/30/19.
//  Copyright © 2019 avellar. All rights reserved.
//

import Foundation

public struct User: Codable, Equatable {
    public var id: String?
    public var email: String?
    public var username: String?
    public var chatRooms: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case username
        case chatRooms
    }
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User {
    static func save(user: User?, with key: String) {
        if let user = user, let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: key)
        } else {
            UserDefaults.standard.set(nil, forKey: key)
        }
    }
    
    static func get(from userDefaultsKey: String) -> User? {
        guard let savedPerson = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data else
        { return nil}
        return try? JSONDecoder().decode(User.self, from: savedPerson)
    }
}
