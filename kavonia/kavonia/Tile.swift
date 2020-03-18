//
//  Tile.swift
//  kavonia
//
//  Created by Sarah Leavitt on 3/18/20.
//  Copyright © 2020 Innoviox. All rights reserved.
//

import Foundation
import SceneKit

class Tile {
    var node: SCNNode
    
    init(filepath: String) {
        node = SCNScene(named: filepath).rootNode.childNodes[0]
    }
}
