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

import Benchmark
import BenchmarksUtils
import Collections
import Foundation
import SwiftData

let input = Int64(0x10000)

let benchmarks = {
  
  Benchmark.defaultConfiguration.metrics = .default
  Benchmark.defaultConfiguration.timeUnits = .microseconds
  Benchmark.defaultConfiguration.maxDuration = .seconds(86400)
  Benchmark.defaultConfiguration.maxIterations = .count(100)
  
  Benchmark("Swift.Dictionary: Insert") { benchmark in
    let dictionary = SwiftDictionary(input)
    benchmark.startMeasurement()
    
    var copy = dictionary
    let element = StructElement(input)
    copy[input] = element
    blackHole(element)
    blackHole(copy)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("Collections.TreeDictionary: Insert") { benchmark in
    let dictionary = CollectionsTreeDictionary(input)
    benchmark.startMeasurement()
    
    var copy = dictionary
    let element = StructElement(input)
    copy[input] = element
    blackHole(element)
    blackHole(copy)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("SwiftData.ModelContext: Insert") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let element = ModelElement(input)
    context.insert(element)
    blackHole(element)
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("SwiftData.ModelContext: Insert and Save") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let element = ModelElement(input)
    context.insert(element)
    blackHole(element)
    
    try! context.save()
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("Swift.Dictionary: Read") { benchmark in
    let dictionary = SwiftDictionary(input)
    benchmark.startMeasurement()
    
    let element = dictionary[0]!
    blackHole(element)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("Collections.TreeDictionary: Read") { benchmark in
    let dictionary = CollectionsTreeDictionary(input)
    benchmark.startMeasurement()
    
    let element = dictionary[0]!
    blackHole(element)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("SwiftData.ModelContext: Read") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let predicate = #Predicate<ModelElement> { model in
      model.a == 0
    }
    let values = try! context.fetch(predicate)
    blackHole(values)
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("Swift.Dictionary: Update") { benchmark in
    let dictionary = SwiftDictionary(input)
    benchmark.startMeasurement()
    
    var copy = dictionary
    var element = dictionary[0]!
    element.a = input
    copy[0] = element
    blackHole(element)
    blackHole(copy)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("Collections.TreeDictionary: Update") { benchmark in
    let dictionary = CollectionsTreeDictionary(input)
    benchmark.startMeasurement()
    
    var copy = dictionary
    var element = dictionary[0]!
    element.a = input
    copy[0] = element
    blackHole(element)
    blackHole(copy)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("SwiftData.ModelContext: Update") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let predicate = #Predicate<ModelElement> { model in
      model.a == 0
    }
    let values = try! context.fetch(predicate)
    let element = values[0]
    element.a = input
    blackHole(element)
    blackHole(values)
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("SwiftData.ModelContext: Update and Save") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let predicate = #Predicate<ModelElement> { model in
      model.a == 0
    }
    let values = try! context.fetch(predicate)
    let element = values[0]
    element.a = input
    blackHole(element)
    blackHole(values)
    
    try! context.save()
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("Swift.Dictionary: Delete") { benchmark in
    let dictionary = SwiftDictionary(input)
    benchmark.startMeasurement()
    
    var copy = dictionary
    copy[0] = nil
    blackHole(copy)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("Collections.TreeDictionary: Delete") { benchmark in
    let dictionary = CollectionsTreeDictionary(input)
    benchmark.startMeasurement()
    
    var copy = dictionary
    copy[0] = nil
    blackHole(copy)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("SwiftData.ModelContext: Delete") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let predicate = #Predicate<ModelElement> { model in
      model.a == 0
    }
    let values = try! context.fetch(predicate)
    let element = values[0]
    context.delete(element)
    blackHole(element)
    blackHole(values)
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("SwiftData.ModelContext: Delete and Save") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let predicate = #Predicate<ModelElement> { model in
      model.a == 0
    }
    let values = try! context.fetch(predicate)
    let element = values[0]
    context.delete(element)
    blackHole(element)
    blackHole(values)
    
    try! context.save()
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("Swift.Dictionary: Count") { benchmark in
    let dictionary = SwiftDictionary(input)
    benchmark.startMeasurement()
    
    let count = dictionary.count
    blackHole(count)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("Collections.TreeDictionary: Count") { benchmark in
    let dictionary = CollectionsTreeDictionary(input)
    benchmark.startMeasurement()
    
    let count = dictionary.count
    blackHole(count)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("SwiftData.ModelContext: Count") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let count = try! context.fetchCount(ModelElement.self)
    blackHole(count)
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
  Benchmark("Swift.Dictionary: Sort") { benchmark in
    let dictionary = SwiftDictionary(input)
    benchmark.startMeasurement()
    
    let values = dictionary.values.sorted(sort: \StructElement.a)
    blackHole(values)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("Collections.TreeDictionary: Sort") { benchmark in
    let dictionary = CollectionsTreeDictionary(input)
    benchmark.startMeasurement()
    
    let values = dictionary.values.sorted(sort: \StructElement.a)
    blackHole(values)
    
    benchmark.stopMeasurement()
    blackHole(dictionary)
  }
  
  Benchmark("SwiftData.ModelContext: Sort") { benchmark in
    let context = try! SwiftDataModelContext(input)
    benchmark.startMeasurement()
    
    let values = try! context.fetch(sort: \ModelElement.a)
    blackHole(values)
    
    benchmark.stopMeasurement()
    blackHole(context)
  }
  
}
