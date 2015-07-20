Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZH6jl-00054B-20
 for kexec@lists.infradead.org; Mon, 20 Jul 2015 08:47:50 +0000
Message-Id: <20150720083713.528114272@redhat.com>
Date: Mon, 20 Jul 2015 16:37:13 +0800
From: dyoung@redhat.com
Subject: [PATCH V2 0/2] kexec: refactor CONFIG_KEXEC/CONFIG_KEXEC_FILE Kconfig
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
Cc: jwboyer@fedoraproject.org, tytso@mit.edu, ptesarik@suse.cz, dhowells@redhat.com, geert@linux-m68k.org, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

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

Changes to V1:
* drop patch 3/3 which is not belonging to this series
* move KEXEC_CORE to generic arch/Kconfig, arch KEXEC selects KEXEC_CORE
* add KEXEC_CORE in s390 arch.

Tested kexec_load only, kexec_file_load only, kexec and kexec_file_load built in cases in x86. For kexec_file_load, tested signed and un-signed kernel.
Tested kexec_load in powerpc64 arch.
Build tested arm arch.

For kexec_file_load, if you do not specify "-s" in kexec-tools, kexec load
will hang, though "-s" is mandatory for kexec_file_load, kexec should still
fail out instead of hanging there, here is a fix in kexec-tools:
 
--- kexec-tools.orig/kexec/crashdump-elf.c
+++ kexec-tools/kexec/crashdump-elf.c
@@ -145,11 +145,12 @@ int FUNC(struct kexec_info *info,
 
 	count_cpu = nr_cpus;
 	for (i = 0; count_cpu > 0; i++) {
-		if (get_note_info(i, &notes_addr, &notes_len) < 0) {
-			/* This cpu is not present. Skip it. */
-			continue;
-		}
+		int ret;
+
+		ret = get_note_info(i, &notes_addr, &notes_len);
 		count_cpu--;
+		if (ret < 0) /* This cpu is not present. Skip it. */
+			continue;
 
 		phdr = (PHDR *) bufp;
 		bufp += sizeof(PHDR);

Below is the diffstat of the patche series:
--
 arch/Kconfig                  |    3 
 arch/arm/Kconfig              |    1 
 arch/ia64/Kconfig             |    1 
 arch/m68k/Kconfig             |    1 
 arch/mips/Kconfig             |    1 
 arch/powerpc/Kconfig          |    1 
 arch/s390/Kconfig             |    1 
 arch/sh/Kconfig               |    1 
 arch/tile/Kconfig             |    1 
 arch/x86/Kconfig              |    3 
 arch/x86/boot/header.S        |    2 
 arch/x86/include/asm/kdebug.h |    2 
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
 34 files changed, 2725 insertions(+), 2656 deletions(-)

--
Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
