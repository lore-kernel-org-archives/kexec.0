Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJVk0-0002CO-Qu
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 21:45:07 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 00/16] [RFC PATCH] Signed kexec support
Date: Tue, 10 Sep 2013 17:44:15 -0400
Message-Id: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com, vgoyal@redhat.com

Hi,

Matthew has been posting patches to lock down kernel either due to
secureboot requirements or because of signed modules with signing
enforced. In kernel lock down mode, kexec will be disabled and that
means kdump will not work either.

These patches sign /sbin/kexec and kernel verifies the signature
and allows loading a kernel if signature verification is successful.
IOW, trust is extended to validly signed user space.

Currently it works only for statically linked applications.

I have generated these patches on top of keys-devel branch of david howell's
linux-fs tree (as I required his system_kerying and trusted keyring patches
to build upon).

git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git keys-devel

These patches assume that matthew's patches to lockdown kernel will go
in some form (secure modules or secure levels or something else). Right
now I have hardcoded few things and will remove those once matthew's
patches are in. 

Some more details about design I have written here.

http://people.redhat.com/vgoyal/kdump-secureboot/kdump-secureboot-summary.txt

Any comments/feedback is appreciated.

Thanks
Vivek

Vivek Goyal (16):
  mm: vm_brk(), align the length to page boundary
  integrity: Add a function to determine digital signature length
  ima: Allow adding more memory locking metadata after digital signature
    v2
  integrity: Allow digital signature verification with a given keyring
    ptr
  integrity: Export a function to retrieve hash algo used in digital
    signature
  ima: export new IMA functions for signature verification
  mm: Define a task flag MMF_VM_LOCKED for memlocked tasks and don't
    allow munlock
  binfmt_elf: Elf executable signature verification
  ima: define functions to appraise memory buffer contents
  keyctl: Introduce a new operation KEYCTL_VERIFY_SIGNATURE
  ptrace: Do not allow ptrace() from unsigned process to signed one
  binfmt_elf: Do not mark process signed if binary has elf interpreter
  kexec: Allow only signed processes to call sys_kexec() in secureboot
    mode
  kexec: Export sysfs attributes for secureboot and secure modules to
    user space
  bootparam: Pass acpi_rsdp pointer in bootparam
  mount: Add a flag to not follow symlink at the end of mount point

 arch/x86/include/uapi/asm/bootparam.h  |   3 +-
 arch/x86/kernel/acpi/boot.c            |   5 +
 drivers/acpi/osl.c                     |  10 ++
 fs/Kconfig.binfmt                      |  10 ++
 fs/binfmt_elf.c                        | 116 ++++++++++++++++++++-
 fs/namespace.c                         |   6 +-
 include/linux/acpi.h                   |   1 +
 include/linux/cred.h                   |   2 +
 include/linux/ima.h                    |  27 +++++
 include/linux/integrity.h              |  25 ++++-
 include/linux/sched.h                  |   2 +
 include/uapi/linux/fs.h                |   1 +
 include/uapi/linux/keyctl.h            |  16 +++
 kernel/cred.c                          |   2 +
 kernel/kexec.c                         |  29 ++++++
 kernel/ksysfs.c                        |  25 +++++
 mm/mlock.c                             |   6 ++
 mm/mmap.c                              |   8 +-
 security/commoncap.c                   |  11 ++
 security/integrity/digsig.c            | 180 +++++++++++++++++++++++++++++++--
 security/integrity/digsig_asymmetric.c |  11 --
 security/integrity/ima/ima_api.c       |  51 ++++++++++
 security/integrity/ima/ima_appraise.c  | 132 +++++++++++++++++++++++-
 security/integrity/integrity.h         |  36 +++++--
 security/keys/compat.c                 |  28 +++++
 security/keys/internal.h               |   2 +
 security/keys/keyctl.c                 |  79 +++++++++++++++
 27 files changed, 788 insertions(+), 36 deletions(-)

-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
