// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Benchmarks",
  platforms: [
    .macOS(.v14)
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections.git",
      from: "1.1.4"
    ),
    .package(
      url: "https://github.com/apple/swift-collections-benchmark.git",
      from: "0.0.3"
    ),
    .package(
      url: "https://github.com/ordo-one/package-benchmark",
      from: "1.27.4"
    ),
  ],
  targets: [
    .target(
      name: "BenchmarksUtils",
      dependencies: [
        .product(
          name: "Collections",
          package: "swift-collections"
        )
      ],
      linkerSettings: [
        .unsafeFlags([
          "-Xlinker", "-sectcreate",
          "-Xlinker", "__TEXT",
          "-Xlinker", "__info_plist",
          "-Xlinker", "Resources/Info.plist",
        ])
      ]
    ),
    .executableTarget(
      name: "Benchmarks",
      dependencies: [
        "BenchmarksUtils",
        .product(
          name: "Collections",
          package: "swift-collections"
        ),
        .product(
          name: "Benchmark",
          package: "package-benchmark"
        ),
      ],
      path: "Benchmarks/Benchmarks",
      swiftSettings: [
        .swiftLanguageMode(.v5)
      ],
      plugins: [
        .plugin(
          name: "BenchmarkPlugin",
          package: "package-benchmark"
        )
      ]
    ),
    .executableTarget(
      name: "CollectionsBenchmarks",
      dependencies: [
        "BenchmarksUtils",
        .product(
          name: "Collections",
          package: "swift-collections"
        ),
        .product(
          name: "CollectionsBenchmark",
          package: "swift-collections-benchmark"
        ),
      ]
    ),
  ]
)
