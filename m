Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFQeb-00010w-PF
 for kexec@lists.infradead.org; Wed, 24 Oct 2018 21:25:44 +0000
Received: by mail-pl1-f194.google.com with SMTP id bb7-v6so2809041plb.13
 for <kexec@lists.infradead.org>; Wed, 24 Oct 2018 14:25:15 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/2] arm64: Add support to read PHYS_OFFSET from '/proc/kcore'
 (if available)
Date: Thu, 25 Oct 2018 02:54:54 +0530
Message-Id: <1540416294-10526-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1540416294-10526-1-git-send-email-bhsharma@redhat.com>
References: <1540416294-10526-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Vadim.Lomovtsev@cavium.com, yanjiang.jin@hxt-semitech.com, bhsharma@redhat.com, takahiro.akashi@linaro.org, horms@verge.net.au, bhupesh.linux@gmail.com

Since kernel version 4.19-rc5 (Commit 23c85094fe1895caefdd
["proc/kcore: add vmcoreinfo note to /proc/kcore"]), '/proc/kcore'
contains a new PT_NOTE which carries the VMCOREINFO information.

If the same is available, one should prefer the same to
retrieve 'PHYS_OFFSET' value exported by the kernel as this
is now the standard interface exposed by kernel for sharing
machine specific details with the user-land as per
the arm64 kernel maintainers (see [0]) .

Also on certain arm64 platforms, it has been noticed that due
to a hole at the start of physical ram exposed to kernel
(i.e. it doesn't start from address 0), the kernel still
calculates the 'memstart_addr' kernel variable as 0.

Whereas the SYSTEM_RAM or IOMEM_RESERVED range in '/proc/iomem'
would carry a first entry whose start address is non-zero
(as the physical ram exposed to the kernel starts from a
non-zero address).

In such cases, if we rely on '/proc/iomem' entries to
calculate the phys_offset, then we will have mismatch
between the user-space and kernel space 'PHYS_OFFSET'
value. The present 'kexec-tools' code does the same
in 'get_memory_ranges_iomem_cb()' function when it makes
a call to 'set_phys_offset()'. This can cause the vmcore
generated via 'kexec-tools' to miss the last few bytes as
the first '/proc/iomem' starts from a non-zero address.

One such case was reported by Yanjiang Jin (which I was also
able to reproduce on my qualcomm-amberwing boards). Please see [1]
for the detailed discussion on the same.

Here is some background on that issue:

1. The EFI firmware on the qualcomm amberwing board can set the first
EFI block as EfiReservedMemType:

   Region1: 0x000000000000-0x000000200000 [EfiReservedMemType]
   Region2: 0x000000200000-0x00000021fffff [EfiRuntimeServiceData]

But EFI API won't return the "EfiReservedMemType" memory to Linux
kernel for security reasons, so kernel can't get any info about the
first mem block, and kernel can only see region2 as below:

   efi: Processing EFI memory map:
   efi:   0x000000200000-0x00000021ffff [Runtime Data       |RUN|  |  |
   |  |  |  |   |WB|WT|WC|UC]

   00200000-0021ffff : reserved

2a. If we add debug prints to kernel file 'arch/arm64/mm/init.c'
to print the kernel Virtual map we can see that the memory node is
set to:

..........
   memory  : 0xffff800000200000 - 0xffff801800000000

2b. Now if we use kdump (kexec -p) to obtain a crash vmcore we can see
that if we use 'readelf' to get the last program Header from vmcore
(logs below are for the non-kaslr case):

ELF Header:
........................

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
  FileSiz            MemSiz              Flags  Align
  ..............................................................
    LOAD        0x0000000076d40000 0xffff80017fe00000
    0x0000000180000000                 0x0000001680000000
    0x0000001680000000  RWE    0

3. So if we do a simple calculation:

(VirtAddr + MemSiz) = 0xffff80017fe00000 + 0x0000001680000000 =
    0xffff8017ffe00000

which is _not_ equal to 0xffff801800000000.

This indicates that the end virtual memory nodes are not the
same between vmlinux and vmcore. This would eventually cause
'vmcore-dmesg' to fail while trying to read the vmcore, with
an error message:

"No program header covering vaddr 0xXXXX found kexec bug?"

Note:
-----
This patch fixes the issue for non-KASLR boot cases on arm64 platforms,
I will send a separate followup patch to fix the KASLR boot cases
(as the discussion on the same is in progress with the arm64
kernel maintainers).

References:
-----------
[0] https://www.mail-archive.com/kexec@lists.infradead.org/msg20300.html
[1] https://www.spinics.net/lists/kexec/msg20618.html

Reported-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 7a124795f3d0..5ce83b32a441 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -14,6 +14,7 @@
 #include <sys/stat.h>
 #include <linux/elf-em.h>
 #include <elf.h>
+#include <elf_info.h>
 
 #include <unistd.h>
 #include <syscall.h>
@@ -38,6 +39,11 @@
 #define PROP_ELFCOREHDR "linux,elfcorehdr"
 #define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
 
+/* Global flag which indicates that we have tried reading vmcoreinfo
+ * from '/proc/kcore' already.
+ */
+static bool flag_read_vmcoreinfo_from_kcore = false;
+
 /* Global varables the core kexec routines expect. */
 
 unsigned char reuse_initrd;
@@ -740,17 +746,84 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 }
 
 /**
+ * get_phys_offset_from_kcore - Helper for getting PHYS_OFFSET from kcore.
+ *
+ * Since kernel version 4.19, '/proc/kcore' contains a new
+ * PT_NOTE which carries the VMCOREINFO information.
+ *
+ * If the same is available, use it to retrieve 'PHYS_OFFSET'
+ * from the VMCOREINFO PT_NOTE present in '/proc/kcore'.
+ */
+
+static int get_phys_offset_from_kcore(unsigned long *phys_offset)
+{
+	int fd, ret;
+
+	if ((fd = open("/proc/kcore", O_RDONLY)) < 0) {
+		dbgprintf("Can't open (%s).\n", "/proc/kcore");
+		return EFAILED;
+	}
+
+	ret = read_phys_offset_elf_kcore(fd, phys_offset);
+	if (ret != 0) {
+		dbgprintf("Can't find VMCOREINFO in '/proc/kcore'\n");
+		close(fd);
+		return ret;
+	}
+
+	close(fd);
+	return 0;
+}
+
+/**
  * get_memory_ranges_iomem_cb - Helper for get_memory_ranges_iomem.
  */
 
 static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 	unsigned long long base, unsigned long long length)
 {
+	int ret;
+	unsigned long phys_offset = UINT64_MAX;
 	struct memory_range *r;
 
 	if (nr >= KEXEC_SEGMENT_MAX)
 		return -1;
 
+	/* Since kernel version 4.19, '/proc/kcore' contains a new
+	 * PT_NOTE which carries the VMCOREINFO information.
+	 *
+	 * If the same is available, one should prefer the same to
+	 * retrieve 'PHYS_OFFSET' value exported by the kernel as this
+	 * is now the standard interface exposed by kernel for sharing
+	 * machine specific details with the userland.
+	 *
+	 * Also on certain arm64 platforms, it has been noticed that due
+	 * to a hole at the start of physical ram exposed to kernel
+	 * (i.e. it doesn't start from address 0), the kernel still
+	 * calculates the 'memstart_addr' kernel variable as 0.
+	 *
+	 * Whereas the SYSTEM_RAM or IOMEM_RESERVED range in '/proc/iomem'
+	 * would carry a first entry whose start address is non-zero
+	 * (as the physical ram exposed to the kernel starts from a
+	 * non-zero address).
+	 *
+	 * In such cases, if we rely on '/proc/iomem' entries to
+	 * calculate the phys_offset, then we will have mismatch
+	 * between the user-space and kernel space 'PHYS_OFFSET'
+	 * value.
+	 */
+
+	if (!flag_read_vmcoreinfo_from_kcore) {
+		ret = get_phys_offset_from_kcore(&phys_offset);
+		if (!ret) {
+			if (phys_offset != UINT64_MAX)
+				set_phys_offset(phys_offset);
+
+		}
+
+		flag_read_vmcoreinfo_from_kcore = true;
+	}
+
 	r = (struct memory_range *)data + nr;
 
 	if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)))
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
