From: Hui Li <lihui@loongson.cn>
Date: Sun, 24 Apr 2022 10:35:21 +0800
Subject: [PATCH v2 0/2] kexec-tools:mips: Fix Kernel panic problem
Message-ID: <20220424023523.16869-1-lihui@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Under loongson platform,use command:
kexec -l vmlinux... --append="root=UUID=28e1..." --initrd=...
kexec -e
quick restart failed like this:

[    3.420791] VFS: Cannot open root device "UUID=6462a8a4-02fb-49ff-bcb6-54fe53813c2a" or unknown-block(0,0): error -6
[    3.431262] Please append a correct "root=" boot option; here are the available partitions:
...
...
...
[    3.543175]   0801         4194304 sda1 554e69cc-01
[    3.543175] 
[    3.549494]   0802        62914560 sda2 554e69cc-02
[    3.549495] 
[    3.555818]   0803         8388608 sda3 554e69cc-03
[    3.555819] 
[    3.562139]   0804       174553229 sda4 554e69cc-04
[    3.562139] 
[    3.568463] 0b00         1048575 sr0 
[    3.568464]  driver: sr
[    3.574524] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    3.582750] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---


The reason of this problem:
The kernel cannot parse the UUID,UUID is parsed in the initrd.
Loongson platform obtain the initrd through cmdline in kernel.
In kexec-tools, initrd is not added to cmdline.

The following two steps to solve this problem.

Hui Li (2):
  kexec-tools: mips: Add CONFIG_LOONGSON option.
  kexec-tools: mips: Add initrd parameter to cmdline

 configure.ac                     |  5 ++++
 kexec/arch/mips/crashdump-mips.h |  6 ++++-
 kexec/arch/mips/kexec-elf-mips.c | 43 ++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.20.1


