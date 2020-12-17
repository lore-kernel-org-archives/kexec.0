Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpsL3-00062W-UO
 for kexec@lists.infradead.org; Thu, 17 Dec 2020 12:24:59 +0000
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
 by kirsty.vergenet.net (Postfix) with ESMTPA id DEE4525AE78
 for <kexec@lists.infradead.org>; Thu, 17 Dec 2020 23:24:42 +1100 (AEDT)
Date: Thu, 17 Dec 2020 13:24:40 +0100
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.21
Message-ID: <20201217122439.GA7652@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi all,

I am happy to announce the release of kexec-tools 2.0.21.

This is a feature release coinciding with the release of v5.10
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.21.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.

Commits since v2.0.20:

af25626 kexec-tools 2.0.21
018ae8d kexec-tools 2.0.21-rc1
0eac640 kexec: mips: Fix mem parameters
fa91709 dt-ops: fix memory leak when new_node malloc fails
d4eaff6 zlib: fix resource leak when gzdirect failed
4149df9 printk: add support for lockless ringbuffer
6b5667d x86_64: allow ELFCLASS32 for x32 support
5c7f47d i386: fix string formatting-related warnings
3dce5ce i386/kexec-mb2-x86.c: cast ints to uintptr_t before pointers to avoid warnings
6caad4c configure.ac, arch/x86_64: handle x32 as subarch of x86_64 and don't specify -mcmodel=large there
9d33ea5 config: update to latest config.{sub,guess}, install-sh
1e9de8e arm64: Add purgatory printing
70cca82 kexec: Fix snprintf related compilation warnings
15fc8cb vmcore-dmesg/man page: Update the vmcore-dmesg man page
9fd2189 kexec-tools: Add some missing free() calls
ec53791 kexec-tools: Fix a prompt message when crashkernel is not reserved
7bd2516 kexec-tools: mips: Remove commandline parameter "mem"
a47b10c kexec/kexec.c: Add missing close() call
16168f8 AUTHORS: Update email address for Khalid
01144be MIPS: Fix compile warnnings in kexec-elf-mips.c
24884d1 mips: kexec-elf-mips: fix not free in elf_mips_load()
12e643a kexec-tools: Check callback first in kexec_iomem_for_each_line()
7a576da arm: Increase zImage length after getting the tag
f22b6aa kexec-tools: fix the unintended fallthrough when '-d' option is used
74c7c36 arm: redefine OPT_APPEND and OPT_RAMDISK
5dc72de kexec-tools: s390: Reset kernel command line on syscall fallback
65441fb kexec-xen: Introduce --exec-live-update to trigger a live update
b13984c kexec: Introduce --load-live-update for xen
41a9b98 kexec-xen: Introduce xen_get_kexec_range to wrap xc_kexec_get_range
cc087b1 kexec-tools: Remove duplicated variable declarations
cbbee58 Removing condition that will never be met after calls xmalloc and xrealloc
618799e kexec: support parsing the string "Reserved" to get the correct e820 reserved region
9cf7212 kexec-tools: Reset getopt before falling back to legacy syscall
4f77da6 kexec-tools: Fix kexec_file_load(2) error handling
a4afe68 crashdump-ppc64: crashkernel-base and crashkernel-size are big-endian
2c9f26e kexec: build multiboot2 for i386
66b151d ARM: Use mmap for zImage initrd
2572b8d arm64: kdump: deal with a lot of resource entries in /proc/iomem
f736104 arm64: kexec: allocate memory space avoiding reserved regions
cf977b1 kexec: add variant helper functions for handling memory regions
bd07796 kexec-tools: Fix conversion overflow when compiling on 32-bit platforms
775f258 kexec-tools: Fix possible out-of-bounds access in ifdown
470d5c4 kexec: add support for PARISC architecture
b54816e kexec/arm: undefine __NR_kexec_file_load for arm
ed2d6e3 i386/kexec-mb2-x86.c: Fix compilation warning
a46c686 vmcore-dmesg/vmcore-dmesg.c: Fix shifting error reported by cppcheck
fa3f0ed Limit the size of vmcore-dmesg.txt to 2G
a7c4cb8 Cleanup: move it back from util_lib/elf_info.c
14ad054 Fix an error definition about the variable 'fname'
545c811 Cleanup: remove the read_elf_kcore()
23b67f0 x86: Fix PAGE_OFFSET for kernels since 4.20
77c8824 kexec-tools 2.0.20.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
