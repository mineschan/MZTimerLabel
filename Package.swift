import PackageDescription

let package = Package(
    name: "MZTimerLabel",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "MZTimerLabel",
            targets: ["MZTimerLabel"]),
    ],
    dependencies: [
        // no dependencies
    ],
    targets: [
        .target(
            name: "MZTimerLabel",
            dependencies: []),
    ]
)
