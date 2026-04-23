import Foundation
import BuildShared

do {
    let options = try BuildRunner.performCommand()

    try BuildUchardet(options: options).buildALL()
} catch {
    print(error.localizedDescription)
    exit(1)
}


enum Library: String, CaseIterable, BuildLibrary {
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
                    url: "https://github.com/mpvkit/libuchardet-build/releases/download/\(BuildRunner.options!.releaseVersion)/Libuchardet.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libuchardet-build/releases/download/\(BuildRunner.options!.releaseVersion)/Libuchardet.xcframework.checksum.txt"
                ),
            ]
        }
    }
}


private class BuildUchardet: BaseBuild {
    init(options: ArgumentOptions) {
        super.init(library: Library.libuchardet, options: options)
    }

    override func arguments(platform : PlatformType, arch : ArchType) -> [String] {
        [
            "-DBUILD_BINARY=0",
        ]
    }
}
