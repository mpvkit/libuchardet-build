import Foundation

do {
    let options = try ArgumentOptions.parse(CommandLine.arguments)
    try Build.performCommand(options)

    try BuildUchardet().buildALL()
} catch {
    print(error.localizedDescription)
    exit(1)
}


enum Library: String, CaseIterable {
    case libuchardet
    var version: String {
        switch self {
        case .libuchardet:
            return "v0.0.8"
        }
    }

    var url: String {
        switch self {
        case .libuchardet:
            return "https://gitlab.freedesktop.org/uchardet/uchardet"
        }
    }

    // for generate Package.swift
    var targets : [PackageTarget] {
        switch self {
        case .libuchardet:
            return  [
                .target(
                    name: "Libuchardet",
                    url: "https://github.com/mpvkit/libuchardet-build/releases/download/\(BaseBuild.options.releaseVersion)/Libuchardet.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libuchardet-build/releases/download/\(BaseBuild.options.releaseVersion)/Libuchardet.xcframework.checksum.txt"
                ),
            ]
        }
    }
}


private class BuildUchardet: BaseBuild {
    init() {
        super.init(library: .libuchardet)
    }

    override func arguments(platform : PlatformType, arch : ArchType) -> [String] {
        [
            "-DBUILD_BINARY=0",
        ]
    }
}