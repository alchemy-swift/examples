import Alchemy
//import AlchemyS3

extension App {

    /// Configurations related to your app's filesystems.

    var filesystems: Filesystems {
        Filesystems(

            /// Your app's default filesystem.

            default: .local,

            /// Define your filesystem disks here.

            disks: [
                .local: .local(),
                /// Uncomment this, the import, and the section in Package.swift for S3 integration
                //.s3: .s3(
                //    key: Env.AWS_ACCESS_KEY_ID ?? "key",
                //    secret: Env.AWS_SECRET_ACCESS_KEY ?? "secret",
                //    bucket: Env.AWS_BUCKET ?? "bucket",
                //    region: Env.AWS_REGION ?? .useast1
                //)
            ]
        )
    }
}

extension Filesystem.Identifier {
    static let local: Filesystem.Identifier = "local"
    static let s3: Filesystem.Identifier = "s3"
}
