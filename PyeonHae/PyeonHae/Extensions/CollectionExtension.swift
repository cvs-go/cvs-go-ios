//
//  CollectionExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 1/4/24.
//

import Foundation

extension Collection {
  func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
}
