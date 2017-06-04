//
//  RealmMapper.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation


protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    
    var uid: String {get}
    
    func asRealm() -> RealmType
}
