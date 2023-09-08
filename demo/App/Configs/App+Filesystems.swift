import Alchemy

extension App {

    /// Configurations related to your app's filesystems.

    var filesystems: Filesystems {
        Filesystems(

            /// Your app's default filesystem.

            default: .local,

            /// Define your filesystem disks here.

            disks: [
                .local: .local()
            ]
        )
    }
}

extension Filesystem.Identifier {
    static let local: Filesystem.Identifier = "local"
    static let s3: Filesystem.Identifier = "aws"
}
