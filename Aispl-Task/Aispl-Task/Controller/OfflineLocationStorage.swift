//
//  OfflineLocationStorage.swift
//  Aispl-Task
//
//  Created by Karthi on 09/07/24.
//

import Foundation
import RealmSwift

class Place: Object {
    @Persisted var name: String = ""
}
