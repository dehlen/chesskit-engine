// swift-tools-version: 5.9

import PackageDescription

// MARK: - Package Configuration

let package = Package(
    name: "ChessKitEngine",
    platforms: [
        .iOS(.v16),
        .watchOS(.v9),
        .macOS(.v13),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "ChessKitEngine",
            targets: ["ChessKitEngine"]
        )
    ],
    targets: [
        .target(
            name: "ChessKitEngine",
            dependencies: ["ChessKitEngineCore"]
        ),
        .target(
            name: "ChessKitEngineCore",
            cxxSettings: [
                .define("NNUE_EMBEDDING_OFF"),
                .define("NO_PEXT"),
                .unsafeFlags([
                    // suppress Stockfish warnings
                    "-Wno-deprecated-declarations",
                    "-Wno-shorten-64-to-32"
                ])
            ],
            linkerSettings: [
                .linkedLibrary("z")
            ]
        ),
        .testTarget(
            name: "ChessKitEngineTests",
            dependencies: ["ChessKitEngine"],
            resources: [
                .copy("EngineTests/Resources/192x15_network")
            ]
        )
    ],
    cxxLanguageStandard: .gnucxx17
)
