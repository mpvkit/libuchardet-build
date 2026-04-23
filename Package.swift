// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libuchardet",
    platforms: [.macOS(.v11), .iOS(.v14), .tvOS(.v14)],
    products: [
        .library(
            name: "Libuchardet",
            targets: ["_Libuchardet"]
        ),
    ],
    targets: [
        // Need a dummy target to embedded correctly.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(
            name: "_Libuchardet",
            dependencies: ["Libuchardet"],
            path: "Sources/_Dummy"
        ),
        //AUTO_GENERATE_TARGETS_BEGIN//

        .binaryTarget(
            name: "Libuchardet",
            url: "https://github.com/mpvkit/libuchardet-build/releases/download/0.0.8/Libuchardet.xcframework.zip",
            checksum: "ea4f548a230a755e059144657cc9e2ff563c1cdeae03974c38f8b6e1a40303fb"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)
