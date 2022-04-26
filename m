From: Bo YU <tsu.yubo@gmail.com>
Date: Tue, 26 Apr 2022 17:17:14 +0800
Subject: Does Kexec have plan to support riscv64?
Message-ID: <20220426091714.fbtmlnp7geldb6td@debian>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,
Sorry, send again.
 From here: https://projects.horms.net/projects/kexec/
I noticed the kexec does not support riscv64 arch. Are we have plan to support
riscv64 for it? Or are there others that are not suitable for this plan?

It seems we are starting to do it:
http://lists.infradead.org/pipermail/kexec/2022-April/024533.html

If possible I can help to port kexec to riscv64(maybe need you help).

Background: I am porting debian package to riscv64. There is one ftbfs(fail to
boot from source) issue on riscv64 about kexec-tools:
https://buildd.debian.org/status/fetch.php?pkg=kexec-tools&arch=riscv64&ver=1%3A2.0.24-1&stamp=1649802148&raw=0
And i am trying to fix it with patch but found that there are a lot code
need to add. So i turn to to see the kexec upstream that does support riscv64
or not. Maybe this is a *wrong* question to ask:(

Please cc me :)

BR,
Bo

