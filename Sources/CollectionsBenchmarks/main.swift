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

import BenchmarksUtils
import Collections
import CollectionsBenchmark
import Foundation
import SwiftData

func benchmarks() {
  var benchmark = Benchmark()

  benchmark.add(
    title: "Swift.Dictionary: Insert",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = SwiftDictionary(input)
      timer.measure {
        var copy = dictionary
        let element = StructElement(input)
        copy[input] = element
        blackHole(element)
        blackHole(copy)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "Collections.TreeDictionary: Insert",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = CollectionsTreeDictionary(input)
      timer.measure {
        var copy = dictionary
        let element = StructElement(input)
        copy[input] = element
        blackHole(element)
        blackHole(copy)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Insert",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let element = ModelElement(input)
        context.insert(element)
        blackHole(element)
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Insert and Save",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let element = ModelElement(input)
        context.insert(element)
        blackHole(element)
        
        try! context.save()
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "Swift.Dictionary: Read",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = SwiftDictionary(input)
      timer.measure {
        let element = dictionary[0]!
        blackHole(element)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "Collections.TreeDictionary: Read",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = CollectionsTreeDictionary(input)
      timer.measure {
        let element = dictionary[0]!
        blackHole(element)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Read",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let predicate = #Predicate<ModelElement> { model in
          model.a == 0
        }
        let values = try! context.fetch(predicate)
        blackHole(values)
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "Swift.Dictionary: Update",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = SwiftDictionary(input)
      timer.measure {
        var copy = dictionary
        var element = dictionary[0]!
        element.a = input
        copy[0] = element
        blackHole(element)
        blackHole(copy)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "Collections.TreeDictionary: Update",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = CollectionsTreeDictionary(input)
      timer.measure {
        var copy = dictionary
        var element = dictionary[0]!
        element.a = input
        copy[0] = element
        blackHole(element)
        blackHole(copy)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Update",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let predicate = #Predicate<ModelElement> { model in
          model.a == 0
        }
        let values = try! context.fetch(predicate)
        let element = values[0]
        element.a = input
        blackHole(element)
        blackHole(values)
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Update and Save",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let predicate = #Predicate<ModelElement> { model in
          model.a == 0
        }
        let values = try! context.fetch(predicate)
        let element = values[0]
        element.a = input
        blackHole(element)
        blackHole(values)
        
        try! context.save()
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "Swift.Dictionary: Delete",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = SwiftDictionary(input)
      timer.measure {
        var copy = dictionary
        copy[0] = nil
        blackHole(copy)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "Collections.TreeDictionary: Delete",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = CollectionsTreeDictionary(input)
      timer.measure {
        var copy = dictionary
        copy[0] = nil
        blackHole(copy)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Delete",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let predicate = #Predicate<ModelElement> { model in
          model.a == 0
        }
        let values = try! context.fetch(predicate)
        let element = values[0]
        context.delete(element)
        blackHole(element)
        blackHole(values)
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Delete and Save",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let predicate = #Predicate<ModelElement> { model in
          model.a == 0
        }
        let values = try! context.fetch(predicate)
        let element = values[0]
        context.delete(element)
        blackHole(element)
        blackHole(values)
        
        try! context.save()
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "Swift.Dictionary: Count",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = SwiftDictionary(input)
      timer.measure {
        let count = dictionary.count
        blackHole(count)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "Collections.TreeDictionary: Count",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = CollectionsTreeDictionary(input)
      timer.measure {
        let count = dictionary.count
        blackHole(count)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Count",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let count = try! context.fetchCount(ModelElement.self)
        blackHole(count)
      }
      blackHole(context)
    }
  }
  
  benchmark.add(
    title: "Swift.Dictionary: Sort",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = SwiftDictionary(input)
      timer.measure {
        let values = dictionary.values.sorted(sort: \StructElement.a)
        blackHole(values)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "Collections.TreeDictionary: Sort",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let dictionary = CollectionsTreeDictionary(input)
      timer.measure {
        let values = dictionary.values.sorted(sort: \StructElement.a)
        blackHole(values)
      }
      blackHole(dictionary)
    }
  }
  
  benchmark.add(
    title: "SwiftData.ModelContext: Sort",
    input: Int.self
  ) { input in
    let input = Int64(input)
    return { timer in
      let context = try! SwiftDataModelContext(input)
      timer.measure {
        let values = try! context.fetch(sort: \ModelElement.a)
        blackHole(values)
      }
      blackHole(context)
    }
  }

  benchmark.main()
}

benchmarks()
