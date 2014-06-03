Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WroRy-00019H-Pb
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 13:08:23 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC PATCH 00/13][V3] kexec: A new system call to allow in kernel
 loading
Date: Tue,  3 Jun 2014 09:06:49 -0400
Message-Id: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, hpa@zytor.com, Vivek Goyal <vgoyal@redhat.com>, bp@alien8.de, ebiederm@xmission.com, greg@kroah.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

Hi,

This is V3 of the patchset. Previous versions were posted here.

V1: https://lkml.org/lkml/2013/11/20/540
V2: https://lkml.org/lkml/2014/1/27/331

Changes since v2:

- Took care of most of the review comments from V2.
- Added support for kexec/kdump on EFI systems.
- Dropped support for loading ELF vmlinux.

This patch series is generated on top of 3.15.0-rc8. It also requires a
two patch cleanup series which is sitting in -tip tree here.

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=x86/boot

This patch series does not do kernel signature verification yet. I plan
to post another patch series for that. Now bzImage is already signed
with PKCS7 signature I plan to parse and verify those signatures.

Primary goal of this patchset is to prepare groundwork so that kernel
image can be signed and signatures be verified during kexec load. This
should help with two things.

- It should allow kexec/kdump on secureboot enabled machines.

- In general it can help even without secureboot. By being able to verify
  kernel image signature in kexec, it should help with avoiding module
  signing restrictions. Matthew Garret showed how to boot into a custom
  kernel, modify first kernel's memory and then jump back to old kernel and
  bypass any policy one wants to.

Any feedback is welcome.

Thanks
Vivek

Vivek Goyal (13):
  bin2c: Move bin2c in scripts/basic
  kernel: Build bin2c based on config option CONFIG_BUILD_BIN2C
  kexec: Move segment verification code in a separate function
  resource: Provide new functions to walk through resources
  kexec: Make kexec_segment user buffer pointer a union
  kexec: New syscall kexec_file_load() declaration
  kexec: Implementation of new syscall kexec_file_load
  purgatory/sha256: Provide implementation of sha256 in purgaotory
    context
  purgatory: Core purgatory functionality
  kexec: Load and Relocate purgatory at kernel load time
  kexec-bzImage: Support for loading bzImage using 64bit entry
  kexec: Support for Kexec on panic using new system call
  kexec: Support kexec/kdump on EFI systems

 arch/x86/Kbuild                      |    1 +
 arch/x86/Kconfig                     |    3 +
 arch/x86/Makefile                    |    6 +
 arch/x86/include/asm/crash.h         |    9 +
 arch/x86/include/asm/kexec-bzimage.h |   11 +
 arch/x86/include/asm/kexec.h         |   53 ++
 arch/x86/kernel/Makefile             |    3 +-
 arch/x86/kernel/crash.c              |  581 ++++++++++++++++
 arch/x86/kernel/kexec-bzimage.c      |  314 +++++++++
 arch/x86/kernel/machine_kexec.c      |  232 +++++++
 arch/x86/kernel/machine_kexec_64.c   |  177 +++++
 arch/x86/purgatory/Makefile          |   35 +
 arch/x86/purgatory/entry64.S         |  101 +++
 arch/x86/purgatory/purgatory.c       |   71 ++
 arch/x86/purgatory/setup-x86_32.S    |   17 +
 arch/x86/purgatory/setup-x86_64.S    |   58 ++
 arch/x86/purgatory/sha256.c          |  284 ++++++++
 arch/x86/purgatory/sha256.h          |   22 +
 arch/x86/purgatory/stack.S           |   19 +
 arch/x86/purgatory/string.c          |   13 +
 arch/x86/syscalls/syscall_64.tbl     |    1 +
 drivers/firmware/efi/runtime-map.c   |   21 +
 include/linux/efi.h                  |   19 +
 include/linux/ioport.h               |    6 +
 include/linux/kexec.h                |   97 ++-
 include/linux/syscalls.h             |    3 +
 include/uapi/linux/kexec.h           |    4 +
 init/Kconfig                         |    5 +
 kernel/Makefile                      |    2 +-
 kernel/kexec.c                       | 1239 +++++++++++++++++++++++++++++++---
 kernel/resource.c                    |  108 ++-
 kernel/sys_ni.c                      |    1 +
 scripts/Makefile                     |    1 -
 scripts/basic/Makefile               |    1 +
 scripts/basic/bin2c.c                |   35 +
 scripts/bin2c.c                      |   36 -
 36 files changed, 3452 insertions(+), 137 deletions(-)
 create mode 100644 arch/x86/include/asm/crash.h
 create mode 100644 arch/x86/include/asm/kexec-bzimage.h
 create mode 100644 arch/x86/kernel/kexec-bzimage.c
 create mode 100644 arch/x86/kernel/machine_kexec.c
 create mode 100644 arch/x86/purgatory/Makefile
 create mode 100644 arch/x86/purgatory/entry64.S
 create mode 100644 arch/x86/purgatory/purgatory.c
 create mode 100644 arch/x86/purgatory/setup-x86_32.S
 create mode 100644 arch/x86/purgatory/setup-x86_64.S
 create mode 100644 arch/x86/purgatory/sha256.c
 create mode 100644 arch/x86/purgatory/sha256.h
 create mode 100644 arch/x86/purgatory/stack.S
 create mode 100644 arch/x86/purgatory/string.c
 create mode 100644 scripts/basic/bin2c.c
 delete mode 100644 scripts/bin2c.c

-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
