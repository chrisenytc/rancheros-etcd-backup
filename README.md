# RancherOS ETCD Backup

> A system service to make backups of the etcd cluster on RancherOS

```bash
           ,/         \,
          ((__,-"""-,__))
           `--)~   ~(--`
          .-'(       )`-,
          `~~`d\   /b`~~`
              |     |
              (6___6)
               `---`

     RancherOS ETCD Backup
```

[![Maintenance](https://img.shields.io/maintenance/yes/2018.svg)]()
[![License](https://img.shields.io/github/license/chrisenytc/rancheros-etcd-backup.svg)](https://github.com/chrisenytc/rancheros-etcd-backup/blob/master/LICENSE)
[![GitHub forks](https://img.shields.io/github/forks/chrisenytc/rancheros-etcd-backup.svg)](https://github.com/chrisenytc/rancheros-etcd-backup/network)
[![GitHub stars](https://img.shields.io/github/stars/chrisenytc/rancheros-etcd-backup.svg)](https://github.com/chrisenytc/rancheros-etcd-backup/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/chrisenytc/rancheros-etcd-backup.svg)](https://github.com/chrisenytc/rancheros-etcd-backup/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/chrisenytc/rancheros-etcd-backup.svg)](https://hub.docker.com/r/chrisenytc/rancheros-etcd-backup/)
[![Docker Stars](https://img.shields.io/docker/stars/chrisenytc/rancheros-etcd-backup.svg)](https://hub.docker.com/r/chrisenytc/rancheros-etcd-backup/)

[![Twitter Follow](https://img.shields.io/twitter/follow/chrisenytc.svg?style=social&label=Follow)](http://twitter.com/chrisenytc)
[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Awesome%20https://github.com/chrisenytc/rancheros-etcd-backup%20via%20@chrisenytc)

## Supported tags and respective `Dockerfile` links

- [`1.0.0`](https://github.com/chrisenytc/rancheros-etcd-backup/blob/1.0.0/Dockerfile)

## Requirements

You need to create a iam role and policy to attach on your aws ec2 instance.

### Required permissions

`s3:PutObject`

This module should be used with rancher 2.0 [recurring-snapshots](https://rancher.com/docs/rancher/v2.x/en/backups/backups/ha-backups/#option-a-recurring-snapshots)

## How to use

Add this [cloud-init](http://cloudinit.readthedocs.io) config on your EC2 user-data or in your rancher configuration file.

```yaml
#cloud-config
rancher:
  services:
    etcd-backup:
      image: chrisenytc/rancheros-etcd-backup:1.0.0
      privileged: true
      environment:
        - S3_BUCKET=s3://chrisenytc-etcd-backup/
      labels:
        io.rancher.os.after: network
        io.rancher.os.scope: system
        io.rancher.os.createonly: 'false'
        cron.schedule: "*/5 * * * *"
      volumes:
        - /opt/rke/etcd-snapshots:/opt/src
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/chrisenytc/rancheros-etcd-backup](https://github.com/chrisenytc/rancheros-etcd-backup). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it [chrisenytc/rancheros-etcd-backup](https://github.com/chrisenytc/rancheros-etcd-backup/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Support
If you have any problem or suggestion please open an issue [here](https://github.com/chrisenytc/rancheros-etcd-backup/issues).

## License 

Check [here](LICENSE).