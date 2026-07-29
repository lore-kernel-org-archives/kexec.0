Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDDBC53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFKX7VdbrSojIZMcZQMEka05eICH+4dBFNUpk47CBQc=; b=wuBxzKoI3WtT+4kkYRl9u5qyQr
	FlOEO54gfZJh+/sSh6wxVLLIHDCms+hUMEvBazYKMjpNZ2m2d88ueOvChZu5pmOK8w8XgFiGgVa2L
	IncEwObx84/5Ly6DtaFDfFOVT4ztK/cxKf1WeKiJM+Z5UCi+GvWi6qPVa7WekZ/neftQDrRqqJD6J
	Quw6Ns4sZg2D1AkkmYoA4kZiKitgS9YajDkYOe5korGEFxTjwnGlbcmAG48n/ut+hLtjyv6RXHAXr
	xJt1b5JWRZ/Y034RBnOtfE10v12KhEAF6ncHqJfymXZh//9gTwIIeuzQWiS0QzthvRDWWFQw7VeTg
	i8nNZ4Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wouiq-00000006jgh-1JHq;
	Wed, 29 Jul 2026 03:12:44 +0000
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wouie-00000006jZX-3IPL;
	Wed, 29 Jul 2026 03:12:36 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HFKX7VdbrSojIZMcZQMEka05eICH+4dBFNUpk47CBQc=;
	b=jicR4gTI8R6l67d8/IRM5KWBgRMY3+PUR4/CAKPIPJloSX0FMAObfgA4j+JNo9DyMpXsjTk9/
	RnjdhdDMIfNWNnqiz6lCWUciHw4CIjQsEuwWasCVjwNFMC6ILHbhiRHXr+5w8uPGzNJ5KxJB2rz
	lC2sbKB/f4B/lmEtv6Ziaks=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h8xwN6bskzLlX5;
	Wed, 29 Jul 2026 11:03:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id BF06440563;
	Wed, 29 Jul 2026 11:12:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 11:12:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<jic23@kernel.org>, <james.morse@arm.com>, <ardb@kernel.org>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>,
	<robh@kernel.org>, <kees@kernel.org>, <coxu@redhat.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <ebiggers@kernel.org>,
	<jbouron@amazon.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 5/5] arm64: crash: Add crash hotplug support
Date: Wed, 29 Jul 2026 11:12:35 +0800
Message-ID: <20260729031235.2840255-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729031235.2840255-1-ruanjinjie@huawei.com>
References: <20260729031235.2840255-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_201233_155252_632BC29B 
X-CRM114-Status: GOOD (  31.62  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When CPU or memory hotplug events occur, the elfcorehdr in the kdump
image becomes stale, potentially leading to incomplete crash dumps.

Currently, userspace udev rules reload the entire kdump image upon such
events, which is inefficient and leaves kdump inactive for a long time.

Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
support") introduced a kernel mechanism to update only the elfcorehdr.
This patch enables that support for arm64.

On arm64, only memory hotplug events require elfcorehdr updates:
- Physical CPU hotplug is not supported.

- For ACPI based vCPU hotplug [1], the elfcorehdr is built using
  for_each_possible_cpu(), so no update is needed.

The patch:
- Adds CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG (default y).

- Implements following arch functions to handle memory hotplug:
  1. arch_crash_hotplug_support()
  2. arch_crash_get_elfcorehdr_size()
  3. arch_crash_handle_hotplug_event()

- Moves arch_get_system_nr_ranges() and arch_crash_populate_cmem()
  from machine_kexec_file.c to crash.c for crash hotplug reuse.

Follows the approach of x86 commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support") and powerpc commit b741092d5976 ("powerpc/crash: add
crash CPU hotplug support").

Tested with QEMU [2] virtual machine using:
	-M virt,acpi=on,highmem=on
	-smp cpus=1,maxcpus=3
	-bios /usr/share/edk2/aarch64/QEMU_EFI.fd
	-m 2G,slots=64,maxmem=16G

Only kexec_file_load path has been tested; kexec_load is expected to
work via KEXEC_CRASH_HOTPLUG_SUPPORT flag but not yet verified.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
[1]: https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com/
[2]: https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/kexec.h         |  16 +++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/crash.c              | 143 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  55 +++++-----
 5 files changed, 187 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..bebebded5b96 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1666,6 +1666,9 @@ config ARCH_DEFAULT_CRASH_DUMP
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..6c9a73c0b920 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -130,6 +130,22 @@ extern int load_other_segments(struct kimage *image,
 		char *cmdline);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static inline unsigned long pnum_hdr_sz(unsigned long pnum)
+{
+	return pnum * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr);
+}
+
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
+#define arch_crash_hotplug_support arch_crash_hotplug_support
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
+#endif
+
 #endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d2690c3ec528..9bbac452994c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o crash.o
 obj-$(CONFIG_VMCORE_INFO)		+= vmcore_info.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
diff --git a/arch/arm64/kernel/crash.c b/arch/arm64/kernel/crash.c
new file mode 100644
index 000000000000..1f49caa627c4
--- /dev/null
+++ b/arch/arm64/kernel/crash.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Architecture specific functions for kexec based crash dumps.
+ */
+
+#define pr_fmt(fmt)	"crash hp: " fmt
+
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/memblock.h>
+#include <linux/vmalloc.h>
+#include <linux/cacheflush.h>
+#include <linux/crash_core.h>
+
+#include <asm/kexec.h>
+
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
+unsigned int arch_get_system_nr_ranges(void)
+{
+	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
+
+	return nr_ranges;
+}
+
+int arch_crash_populate_cmem(struct crash_mem *cmem)
+{
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_CRASH_HOTPLUG
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
+{
+#ifdef CONFIG_KEXEC_FILE
+	if (image->file_mode)
+		return 1;
+#endif
+	/*
+	 * For kexec_load syscall, crash hotplug support requires
+	 * KEXEC_CRASH_HOTPLUG_SUPPORT flag to be passed by userspace.
+	 */
+	return kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT;
+}
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned long phdr_cnt;
+
+	/* A program header for possible CPUs, vmcoreinfo and kernel_map */
+	phdr_cnt = 2 + num_possible_cpus();
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
+
+	return pnum_hdr_sz(phdr_cnt);
+}
+
+/**
+ * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
+ *			       elfcorehdr in the kexec segment array.
+ * @image: the active struct kimage
+ */
+static void update_crash_elfcorehdr(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = phys_to_virt(mem);
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy(old_elfcorehdr, elfbuf, elfsz);
+	dcache_clean_inval_poc((unsigned long)old_elfcorehdr,
+			       (unsigned long)(old_elfcorehdr + elfsz));
+	xchg(&kexec_crash_image, image);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ * @arg: struct memory_notify handler for memory hotplug case and
+ *       NULL for CPU hotplug case.
+ *
+ * Update the kdump image based on the type of hotplug event:
+ * - CPU add and remove: No action is needed.
+ * - Memory add/remove: Update the elfcorehdr to reflect the current memory layout.
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
+{
+	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		return;
+
+	update_crash_elfcorehdr(image);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 3d907f8ee594..cce19f00acc0 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
-#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_CRASH_DUMP
-unsigned int arch_get_system_nr_ranges(void)
-{
-	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end)
-		nr_ranges++;
-
-	return nr_ranges;
-}
-
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
-		cmem->nr_ranges++;
-	}
-
-	return 0;
-}
-#endif
-
 /*
  * Tries to add the initrd and DTB to the image. If it is not possible to find
  * valid locations, this function will undo changes to the image and return non
@@ -89,8 +60,9 @@ int load_other_segments(struct kimage *image,
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
 #ifdef CONFIG_CRASH_DUMP
+	unsigned long pnum = 0;
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, NULL);
+		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, &pnum);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
@@ -101,9 +73,27 @@ int load_other_segments(struct kimage *image,
 
 		image->elf_headers = kbuf.buffer;
 		image->elf_headers_sz = kbuf.bufsz;
+		kbuf.memsz = kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+		/*
+		 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map
+		 * maximum CPUs and maximum memory ranges.
+		 */
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
+		else
+			pnum += 2 + num_possible_cpus();
+
+		if (pnum < PN_XNUM) {
+			kbuf.memsz = pnum_hdr_sz(pnum);
+			image->elf_headers_sz = max(kbuf.memsz, kbuf.bufsz);
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+#endif
 
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = kbuf.bufsz;
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
 		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
@@ -112,6 +102,9 @@ int load_other_segments(struct kimage *image,
 		if (ret)
 			goto out_err;
 
+		if (IS_ENABLED(CONFIG_CRASH_HOTPLUG) && pnum < PN_XNUM)
+			image->elfcorehdr_index = image->nr_segments - 1;
+
 		image->elf_load_addr = kbuf.mem;
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-- 
2.34.1


