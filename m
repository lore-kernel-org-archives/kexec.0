Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F12EC4707B
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TBijOq1GkTJT3AvEMoUU3SlJ/tYQi15nDlhKDXlUE30=; b=z7UuuwF+QuyQX0
	2M08RE6/sJMs0kc4UtT24jRYp06HxtWeWP8AmWeyT7JINDSz5o+ZXZ9Y1fh8tgPhjUfig69STIUEG
	Nk+xckiUTEpKqq0ck8bXwb59bGJIfm7l9jsL+HrBSjuC+WXhDF3CAITsTAMAlVyW+Osrmf8TCEIP9
	TVYNZiYQj0SQSN/uwPSJWE5+HttROxf3vzlQ73icTP2rlNMJ1SIMD4ed2Hk5QyTtFlkRWBiT+6Yoy
	61WOPYcxU83igggYIHzrqTkeuaQazdPpawdClUJnlzK6+WedQqd8SdYAVBT5XIo1LeIw0jVCM+Wsg
	DHzz1O1EWFU+JuoCNkWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhWR-00GY9m-1i;
	Fri, 05 Jan 2024 10:33:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhWI-00GY0H-1O
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 10:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704450821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMlc6dZwikPfDYMMsuu3YLX/C3vxI2XwN9NRTV207m8=;
	b=fYt5aC5f4P+4ZPLdkIPLg5OXzxNfxdimp78u7U8Na6BK3ZHKaNNau+hfcVAeFR/SgNOuAl
	Ek7Jl1VZpj4exQz1PHKYoOh+p9gu7iq2v3D7fXiYHWdUnMAyhhi/dz52xQlUSd+TD2tH/B
	mGdx4h+gTxQIN+RD7fSg6fwq8LGC088=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-2EQYqSDWOhuKmK9Ocp2m-g-1; Fri,
 05 Jan 2024 05:33:36 -0500
X-MC-Unique: 2EQYqSDWOhuKmK9Ocp2m-g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 753FE1C05148;
	Fri,  5 Jan 2024 10:33:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0B9E492BC6;
	Fri,  5 Jan 2024 10:33:29 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	kexec@lists.infradead.org,
	hbathini@linux.ibm.com,
	arnd@arndb.de,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	viro@zeniv.linux.org.uk,
	ebiederm@xmission.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/5] crash: rename crash_core to vmcore_info
Date: Fri,  5 Jan 2024 18:33:03 +0800
Message-ID: <20240105103305.557273-4-bhe@redhat.com>
In-Reply-To: <20240105103305.557273-1-bhe@redhat.com>
References: <20240105103305.557273-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_023342_651870_417B8EDB 
X-CRM114-Status: GOOD (  17.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Now only vmcoreinfo handling related code is in crash_core.c, so do the
renaming as follows:
 kernel/{crash_core.c => vmcore_info.c}
 arch/xxx/kernel/{crash_core.c => vmcore_info.c}
 include/linux/{crash_core.h => vmcore_info.h}
 CONFIG_CRASH_CORE   => CONFIG_VMCORE_INFO

And also update the old ifdeffery of CONFIG_CRASH_CORE, including of
<linux/vmcore_info.h> and config item dependency on CRASH_CORE
accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/Makefile                         |  2 +-
 arch/arm64/kernel/{crash_core.c => vmcore_info.c}  |  2 +-
 arch/powerpc/Kconfig                               |  2 +-
 arch/powerpc/kernel/setup-common.c                 |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c         |  2 +-
 arch/riscv/kernel/Makefile                         |  2 +-
 arch/riscv/kernel/{crash_core.c => vmcore_info.c}  |  2 +-
 arch/x86/kernel/Makefile                           |  2 +-
 .../kernel/{crash_core_32.c => vmcore_info_32.c}   |  2 +-
 .../kernel/{crash_core_64.c => vmcore_info_64.c}   |  2 +-
 drivers/firmware/qemu_fw_cfg.c                     | 14 +++++++-------
 fs/proc/Kconfig                                    |  2 +-
 fs/proc/kcore.c                                    |  2 +-
 include/linux/buildid.h                            |  2 +-
 include/linux/kexec.h                              |  2 +-
 include/linux/{crash_core.h => vmcore_info.h}      |  0
 kernel/Kconfig.kexec                               |  4 ++--
 kernel/Makefile                                    |  2 +-
 kernel/ksysfs.c                                    |  6 +++---
 kernel/printk/printk.c                             |  4 ++--
 kernel/{crash_core.c => vmcore_info.c}             |  0
 lib/buildid.c                                      |  2 +-
 22 files changed, 30 insertions(+), 30 deletions(-)
 rename arch/arm64/kernel/{crash_core.c => vmcore_info.c} (97%)
 rename arch/riscv/kernel/{crash_core.c => vmcore_info.c} (96%)
 rename arch/x86/kernel/{crash_core_32.c => vmcore_info_32.c} (90%)
 rename arch/x86/kernel/{crash_core_64.c => vmcore_info_64.c} (94%)
 rename include/linux/{crash_core.h => vmcore_info.h} (100%)
 rename kernel/{crash_core.c => vmcore_info.c} (100%)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d95b3d6b471a..bcf89587a549 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -66,7 +66,7 @@ obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
-obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
+obj-$(CONFIG_VMCORE_INFO)		+= vmcore_info.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/vmcore_info.c
similarity index 97%
rename from arch/arm64/kernel/crash_core.c
rename to arch/arm64/kernel/vmcore_info.c
index 66cde752cd74..a5abf7186922 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/vmcore_info.c
@@ -4,7 +4,7 @@
  * Copyright (C) Huawei Futurewei Technologies.
  */
 
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <asm/cpufeature.h>
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index bbddee079bf5..d391e8cddf6c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -689,7 +689,7 @@ config ARCH_SELECTS_CRASH_DUMP
 config FA_DUMP
 	bool "Firmware-assisted dump"
 	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
-	select CRASH_CORE
+	select VMCORE_INFO
 	select CRASH_RESERVE
 	select CRASH_DUMP
 	help
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9b142b9d5187..733f210ffda1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -109,7 +109,7 @@ int ppc_do_canonicalize_irqs;
 EXPORT_SYMBOL(ppc_do_canonicalize_irqs);
 #endif
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 /* This keeps a track of which one is the crashing cpu. */
 int crashing_cpu = -1;
 #endif
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index bb7657115f1d..c9a9b759cc92 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -16,7 +16,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/of.h>
 
 #include <asm/page.h>
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..9320748b2694 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
 obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
-obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/vmcore_info.c
similarity index 96%
rename from arch/riscv/kernel/crash_core.c
rename to arch/riscv/kernel/vmcore_info.c
index 8706736fd4e2..e8ad57a60a2f 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/vmcore_info.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/pagemap.h>
 
 void arch_crash_save_vmcoreinfo(void)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..913d4022131e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_X86_TSC)		+= trace_clock.o
 obj-$(CONFIG_TRACING)		+= trace.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o
-obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
diff --git a/arch/x86/kernel/crash_core_32.c b/arch/x86/kernel/vmcore_info_32.c
similarity index 90%
rename from arch/x86/kernel/crash_core_32.c
rename to arch/x86/kernel/vmcore_info_32.c
index 8a89c109e20a..5995a749288a 100644
--- a/arch/x86/kernel/crash_core_32.c
+++ b/arch/x86/kernel/vmcore_info_32.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/pgtable.h>
 
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/crash_core_64.c b/arch/x86/kernel/vmcore_info_64.c
similarity index 94%
rename from arch/x86/kernel/crash_core_64.c
rename to arch/x86/kernel/vmcore_info_64.c
index 7d255f882afe..0dec7d868754 100644
--- a/arch/x86/kernel/crash_core_64.c
+++ b/arch/x86/kernel/vmcore_info_64.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/pgtable.h>
 
 #include <asm/setup.h>
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 1448f61173b3..66f2e9089631 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -37,7 +37,7 @@
 #include <uapi/linux/qemu_fw_cfg.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
@@ -67,7 +67,7 @@ static void fw_cfg_sel_endianness(u16 key)
 		iowrite16(key, fw_cfg_reg_ctrl);
 }
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 static inline bool fw_cfg_dma_enabled(void)
 {
 	return (fw_cfg_rev & FW_CFG_VERSION_DMA) && fw_cfg_reg_dma;
@@ -156,7 +156,7 @@ static ssize_t fw_cfg_read_blob(u16 key,
 	return count;
 }
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 /* write chunk of given fw_cfg blob (caller responsible for sanity-check) */
 static ssize_t fw_cfg_write_blob(u16 key,
 				 void *buf, loff_t pos, size_t count)
@@ -195,7 +195,7 @@ static ssize_t fw_cfg_write_blob(u16 key,
 
 	return ret;
 }
-#endif /* CONFIG_CRASH_CORE */
+#endif /* CONFIG_VMCORE_INFO */
 
 /* clean up fw_cfg device i/o */
 static void fw_cfg_io_cleanup(void)
@@ -319,7 +319,7 @@ struct fw_cfg_sysfs_entry {
 	struct list_head list;
 };
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 static ssize_t fw_cfg_write_vmcoreinfo(const struct fw_cfg_file *f)
 {
 	static struct fw_cfg_vmcoreinfo *data;
@@ -343,7 +343,7 @@ static ssize_t fw_cfg_write_vmcoreinfo(const struct fw_cfg_file *f)
 	kfree(data);
 	return ret;
 }
-#endif /* CONFIG_CRASH_CORE */
+#endif /* CONFIG_VMCORE_INFO */
 
 /* get fw_cfg_sysfs_entry from kobject member */
 static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
@@ -583,7 +583,7 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	int err;
 	struct fw_cfg_sysfs_entry *entry;
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 	if (fw_cfg_dma_enabled() &&
 		strcmp(f->name, FW_CFG_VMCOREINFO_FILENAME) == 0 &&
 		!is_kdump_kernel()) {
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 32b1116ae137..d80a1431ef7b 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -32,7 +32,7 @@ config PROC_FS
 config PROC_KCORE
 	bool "/proc/kcore support" if !ARM
 	depends on PROC_FS && MMU
-	select CRASH_CORE
+	select VMCORE_INFO
 	help
 	  Provides a virtual ELF core file of the live kernel.  This can
 	  be read with gdb and other ELF tools.  No modifications can be
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 6422e569b080..8e08a9a1b7ed 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -10,7 +10,7 @@
  *	Safe accesses to vmalloc/direct-mapped discontiguous areas, Kanoj Sarcar <kanoj@sgi.com>
  */
 
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/kcore.h>
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 8a582d242f06..20aa3c2d89f7 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -11,7 +11,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
 extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
 void init_vmlinux_build_id(void);
 #else
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 19984ddd2c3a..be1e5c2fdbdc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -15,7 +15,7 @@
 
 #if !defined(__ASSEMBLY__)
 
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/crash_reserve.h>
 #include <asm/io.h>
 #include <linux/range.h>
diff --git a/include/linux/crash_core.h b/include/linux/vmcore_info.h
similarity index 100%
rename from include/linux/crash_core.h
rename to include/linux/vmcore_info.h
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 8b7be71edd85..8faf27043432 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -5,11 +5,11 @@ menu "Kexec and crash features"
 config CRASH_RESERVE
 	bool
 
-config CRASH_CORE
+config VMCORE_INFO
 	bool
 
 config KEXEC_CORE
-	select CRASH_CORE
+	select VMCORE_INFO
 	select CRASH_RESERVE
 	bool
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 933ba73ae317..08980e5c2080 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_CRASH_CORE) += crash_core.o
+obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 1d4bc493b2f4..11526fc42bc2 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -154,7 +154,7 @@ KERNEL_ATTR_RW(kexec_crash_size);
 
 #endif /* CONFIG_KEXEC_CORE */
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 
 static ssize_t vmcoreinfo_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -177,7 +177,7 @@ KERNEL_ATTR_RO(crash_elfcorehdr_size);
 
 #endif
 
-#endif /* CONFIG_CRASH_CORE */
+#endif /* CONFIG_VMCORE_INFO */
 
 /* whether file capabilities are enabled */
 static ssize_t fscaps_show(struct kobject *kobj,
@@ -265,7 +265,7 @@ static struct attribute * kernel_attrs[] = {
 	&kexec_crash_loaded_attr.attr,
 	&kexec_crash_size_attr.attr,
 #endif
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 	&vmcoreinfo_attr.attr,
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..7d74b000b43a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -34,7 +34,7 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 #include <linux/syscalls.h>
-#include <linux/crash_core.h>
+#include <linux/vmcore_info.h>
 #include <linux/ratelimit.h>
 #include <linux/kmsg_dump.h>
 #include <linux/syslog.h>
@@ -951,7 +951,7 @@ const struct file_operations kmsg_fops = {
 	.release = devkmsg_release,
 };
 
-#ifdef CONFIG_CRASH_CORE
+#ifdef CONFIG_VMCORE_INFO
 /*
  * This appends the listed symbols to /proc/vmcore
  *
diff --git a/kernel/crash_core.c b/kernel/vmcore_info.c
similarity index 100%
rename from kernel/crash_core.c
rename to kernel/vmcore_info.c
diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0e..3e6868c86b45 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -174,7 +174,7 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
 unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
 
 /**
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
