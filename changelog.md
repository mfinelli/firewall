# Change Log
This is the change log for the firewall project, which adheres to [semantic versioning](http://semver.org/).

## [1.0.1] - 2015-03-23
### Fixed
- Fix issue with existing chain when adding sshguard rules. Some distributions (such as Debian) automatically create the sshguard chain when installing the sshguard package. This didn't really cause any errors, but it printed an ugly error message that the chain already existed when attempting to create that chain.

## [1.0.0] - 2015-03-02
Initial release.
