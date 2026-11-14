// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "doomsday",
    targets: [
        .executableTarget(
            name: "doomsday",
        ),
        .testTarget(
            name: "doomsdayTests",
            dependencies: ["doomsday"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ]
)
