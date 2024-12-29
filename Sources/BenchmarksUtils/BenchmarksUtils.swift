//
//  Copyright 2024 Rick van Voorden and Bill Fisher
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Collections
import Foundation
import SwiftData

package struct StructElement : Hashable {
  package var a: Int64
  package var b: Int64
  package var c: Int64
  package var d: Int64
  package var e: Int64
  package var f: Int64
  package var g: Int64
  package var h: Int64
  package var i: Int64
  package var j: Int64
}

extension StructElement {
  package init(_ value: Int64) {
    self.init(
      a: value,
      b: value,
      c: value,
      d: value,
      e: value,
      f: value,
      g: value,
      h: value,
      i: value,
      j: value
    )
  }
}

@Model final package class ModelElement : Hashable {
  package var a: Int64
  package var b: Int64
  package var c: Int64
  package var d: Int64
  package var e: Int64
  package var f: Int64
  package var g: Int64
  package var h: Int64
  package var i: Int64
  package var j: Int64
  
  init(a: Int64, b: Int64, c: Int64, d: Int64, e: Int64, f: Int64, g: Int64, h: Int64, i: Int64, j: Int64) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
    self.f = f
    self.g = g
    self.h = h
    self.i = i
    self.j = j
  }
}

extension ModelElement {
  package convenience init(_ value: Int64) {
    self.init(
      a: value,
      b: value,
      c: value,
      d: value,
      e: value,
      f: value,
      g: value,
      h: value,
      i: value,
      j: value
    )
  }
}

extension Sequence {
  package func sorted<Value: Comparable>(
    sort keyPath: KeyPath<Self.Element, Value> & Sendable,
    order: SortOrder = .forward
  ) -> [Self.Element] {
    self.sorted(
      using: SortDescriptor(
        keyPath,
        order: order
      )
    )
  }
}

extension ModelContext {
  package func fetchCount<T: PersistentModel>(_ type: T.Type) throws -> Int {
    try self.fetchCount(
      FetchDescriptor<T>()
    )
  }
}

extension ModelContext {
  package func fetch<T: PersistentModel>(_ type: T.Type) throws -> Array<T> {
    try self.fetch(
      FetchDescriptor<T>()
    )
  }
}

extension ModelContext {
  package func fetch<T: PersistentModel>(_ predicate: Predicate<T>) throws -> Array<T> {
    try self.fetch(
      FetchDescriptor(predicate: predicate)
    )
  }
}

extension ModelContext {
  package func fetch<Element: PersistentModel, Value: Comparable>(
    sort keyPath: KeyPath<Element, Value> & Sendable,
    order: SortOrder = .forward
  ) throws -> Array<Element> {
    try self.fetch(
      SortDescriptor(
        keyPath,
        order: order
      )
    )
  }
}

extension ModelContext {
  package func fetch<T: PersistentModel>(_ sortBy: SortDescriptor<T>) throws -> Array<T> {
    try self.fetch(
      FetchDescriptor(sortBy: [sortBy])
    )
  }
}

package func SwiftDictionary(_ size: Int64) -> Dictionary<Int64, StructElement> {
  let sequence = (0 ..< size).shuffled().map { index in
    return (index, StructElement(index))
  }
  let dictionary = Dictionary<Int64, StructElement>(uniqueKeysWithValues: sequence)
  
  precondition(dictionary.count == size)
  
  return dictionary
}

package func CollectionsTreeDictionary(_ size: Int64) -> TreeDictionary<Int64, StructElement> {
  let sequence = (0 ..< size).shuffled().map { index in
    return (index, StructElement(index))
  }
  let dictionary = TreeDictionary<Int64, StructElement>(uniqueKeysWithValues: sequence)
  
  precondition(dictionary.count == size)
  
  return dictionary
}

package func SwiftDataModelContext(_ size: Int64) throws -> ModelContext {
  let configuration = ModelConfiguration(
    isStoredInMemoryOnly: true,
    allowsSave: true
  )
  let container = try ModelContainer(
    for: ModelElement.self,
    configurations: configuration
  )
  let sequence = (0 ..< size).shuffled().map { index in
    return ModelElement(index)
  }
  let context = ModelContext(container)
  context.autosaveEnabled = false
  for model in sequence {
    context.insert(model)
  }
  try context.save()
  
  let count = try context.fetchCount(ModelElement.self)
  precondition(count == size)
  
  return context
}
