Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZETVt-0007oi-8B
 for kexec@lists.infradead.org; Mon, 13 Jul 2015 02:30:37 +0000
Message-Id: <20150713021353.282890552@redhat.com>
Date: Mon, 13 Jul 2015 10:13:53 +0800
From: dyoung@redhat.com
Subject: [PATCH 0/3] kexec: refactor CONFIG_KEXEC/CONFIG_KEXEC_FILE Kconfig
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
Cc: jwboyer@fedoraproject.org, tytso@mit.edu, ptesarik@suse.cz, dhowells@redhat.com, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

Previously Theodore Ts'o brought up an issue about kexec_load syscall bypassing
signature verification:
https://lkml.org/lkml/2015/6/14/280

Because we have two kexec load syscall, one kexec_load, another kexec_file_load,
the latter one was introduced by Vivek Goyal, it is mainly for supporting UEFI
secure boot. kexec_file_load verifies kernel signature, but even if with
CONFIG_KEXEC_VERIFY_SIG=y and CONFIG_KEXEC_FILE=y, kexec-tools still can use
old syscall and bypass signature verification.

KEXEC_FILE can also be used without UEFI, so kexec can always verify kernel
signature for security purpose. 

The suggestion in above thread is add a new Kconfig option for kexec common
code, here I use KEXEC_CORE, KEXEC and KEXEC_FILE select KEXEC_CORE so one can
compile only KEXEC_FILE without old kexec_load syscall.

There's checkpatch warnings and errors, I would like to send furthuer cleanup
patches after this series. Please let me know if you have other suggestions.
checkpatch errors are for cases such as assign a value to static variables.

PATCH 3/3 can be sort out from the series if people do not like. It is a
cleanup for a macro.

Below is the diffstat of the patches:
---
 arch/arm/Kconfig              |    4 
 arch/ia64/Kconfig             |    4 
 arch/m68k/Kconfig             |    4 
 arch/mips/Kconfig             |    4 
 arch/powerpc/Kconfig          |    4 
 arch/sh/Kconfig               |    4 
 arch/tile/Kconfig             |    4 
 arch/x86/Kconfig              |    6 
 arch/x86/boot/header.S        |    2 
 arch/x86/include/asm/kdebug.h |    5 
 arch/x86/kernel/Makefile      |    4 
 arch/x86/kernel/kvmclock.c    |    4 
 arch/x86/kernel/reboot.c      |    4 
 arch/x86/kernel/setup.c       |    2 
 arch/x86/kernel/vmlinux.lds.S |    2 
 arch/x86/kvm/vmx.c            |    8 
 arch/x86/platform/efi/efi.c   |    4 
 arch/x86/platform/uv/uv_nmi.c |    6 
 drivers/firmware/efi/Kconfig  |    2 
 drivers/pci/pci-driver.c      |    2 
 include/linux/kexec.h         |   12 
 init/initramfs.c              |    4 
 kernel/Makefile               |    2 
 kernel/events/core.c          |    2 
 kernel/kexec.c                | 2633 ------------------------------------------
 kernel/kexec_core.c           | 1594 +++++++++++++++++++++++++
 kernel/kexec_file.c           | 1044 ++++++++++++++++
 kernel/kexec_internal.h       |   22 
 kernel/ksysfs.c               |    6 
 kernel/printk/printk.c        |    2 
 kernel/reboot.c               |    2 
 kernel/sysctl.c               |    2 
 32 files changed, 2745 insertions(+), 2659 deletions(-)

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
