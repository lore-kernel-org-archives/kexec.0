Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5985DC46CD3
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=utsaWHr2xAz/Dtph5hJ6CjSjjr6iVUVpFOrBO4Be8GA=; b=iyqmwuJ2Feiz73
	y+N9nDoC4ezup0TANNcxStQjWkcKHXZ/SVCj5BI4a9NFjGl5QyBSGdxxr8vmiicKIIDNgEdyKpiGv
	7yYZ+rew7El/uwJ5QK9jdzurP/3efX8Jyu8ln0QMoc6S3V1Dk0aOfXSr6deok2DnrAY2BZcdnBJaO
	XVUKpvbMwdWBbJ0KG3dwvPrBxoi+7cgZSUKoiRsqOGrLA2dIqYKLcSp3LupBO+z0thWUZ+xKG0u3S
	hb33h0viExaBbIbWv6GtWSyArxAytMnvjgqTvTlddT6Rzz/DDfcJlNz03AGS/I0TptVu7BgwiA16M
	a1fVSR13z7s4l5iVlucg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJ3T-002wrn-0z;
	Thu, 21 Dec 2023 13:25:39 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJ3P-002wnz-1p;
	Thu, 21 Dec 2023 13:25:37 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28659348677so575234a91.0;
        Thu, 21 Dec 2023 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165132; x=1703769932; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/DS3plAsGGkfXvSea0H3Njbv+EkemNe6sD3VMx3Ho4=;
        b=k7fQIg7/RenwpvroJ9WAXQDY8FNrmIOQp2f7+lFlp/RYFgwMPME1EqLMla+p8aG3UT
         9ZjrkXpkwJLDkNsm3IokbDV7VcywYnkgKZNsOY2PpMM+58cA0oBGzEIUERk2k33oNuVF
         07n+3ElPoekBm/SVfAjP4Gi1BywTi9bEodRO/1YO+nOJlrtnSkcaDOG3O71XEXklS+AC
         O9gjEEq5Mr0kGiKB7d1vni6hnQ0Komdn5VU/DP5rRSRxEE+xYGgr7QtWP3cWS8SDhnS2
         tiJPr+3r5DbWQloV2yHZLHD8M6uH1sKVf4Rh6H1wfokcwk7NXUDuu5OFt7iQQDL5cS2U
         8cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165132; x=1703769932;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/DS3plAsGGkfXvSea0H3Njbv+EkemNe6sD3VMx3Ho4=;
        b=DZss97k6/d+yMqLorTUqEp1kdKOg68jQqDr27wgPLpyo5gITeQyGYp6Oprsx84W/V4
         bX9OlPJamNRa8zCppjLza8X7a9p5FG7+Tn0R5o+UOH9bQzXVnq4Jr5J2S10iPqK8dRKQ
         N6KoqjUWktU4wZCvYIauXA0VGmqpixSO1i+UuiyE4Nvc+X00gS+TS4Ngm8mrLUDBNCT8
         NLo4vDdFeLT79BYup6TriMgGQzKfhhAi+3UI7vhI3uDVlnGTvKiq3EbFc9OYJzE2xafs
         qUx5opFd+khAnSq9r2p3hGct5YompIFy1AqNJ+X50dNsKsbAmMOqw0mnCsvuSHo/So1K
         YvVg==
X-Gm-Message-State: AOJu0Yx/+aDY9Pyu0GyjgPcqz1HyP0wkjYfzdg8W0o8oM99wjIrrL2Iv
	RfuEexgKZdYjXOLg+GG7uNE=
X-Google-Smtp-Source: AGHT+IGkXBT8oqblE3YuI1ThaXHFX3DcdNh1gfUXgs4jHaYsZd5D1avj3ud8huyGboP9iYvj7uDzTA==
X-Received: by 2002:a17:90b:4c12:b0:28b:cc1e:66f4 with SMTP id na18-20020a17090b4c1200b0028bcc1e66f4mr791145pjb.33.1703165132327;
        Thu, 21 Dec 2023 05:25:32 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090abe0300b0028bc09a5e1fsm1760016pjs.12.2023.12.21.05.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:25:31 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: qiruipeng@lixiang.com,
	maz@kernel.org,
	lecopzer.chen@mediatek.com,
	ardb@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	arnd@arndb.de,
	mcgrof@kernel.org,
	brauner@kernel.org,
	dianders@chromium.org,
	maninder1.s@samsung.com,
	michael.christie@oracle.com,
	samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [RFC PATCH 2/7] osdump: reuse some code from crash_core to get vmcoreinfo
Date: Thu, 21 Dec 2023 21:25:22 +0800
Message-Id: <20231221132522.547-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_052535_609859_D3409B0C 
X-CRM114-Status: GOOD (  23.40  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is a new crash dumping solution like crash. It is interested in
vmcoreinfo,too. Reuse some data and function from crash_core, but not full
of them. So pick some code to get vmcoreinfo as needed.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 arch/arm64/kernel/Makefile |   1 +
 include/linux/buildid.h    |   3 +-
 kernel/Makefile            |   1 +
 kernel/crash_core_mini.c   | 275 +++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c     |   2 +-
 lib/buildid.c              |   3 +-
 6 files changed, 282 insertions(+), 3 deletions(-)
 create mode 100644 kernel/crash_core_mini.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d95b3d6b471a..fd6d06e44ae2 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
+obj-$(CONFIG_OS_MINIDUMP)              += crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 8a582d242f06..157edba44068 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -11,7 +11,8 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE) \
+	|| IS_ENABLED(CONFIG_OS_MINIDUMP)
 extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
 void init_vmlinux_build_id(void);
 #else
diff --git a/kernel/Makefile b/kernel/Makefile
index dc2b4ba5c953..14b7002f3279 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
+obj-$(CONFIG_OS_MINIDUMP) += crash_core_mini.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
diff --git a/kernel/crash_core_mini.c b/kernel/crash_core_mini.c
new file mode 100644
index 000000000000..a0f8d0c79bba
--- /dev/null
+++ b/kernel/crash_core_mini.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * crash.c - kernel crash support code.
+ * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
+ */
+
+#include <linux/buildid.h>
+#include <linux/init.h>
+#include <linux/utsname.h>
+#include <linux/vmalloc.h>
+#include <linux/sizes.h>
+#include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
+#include <linux/memblock.h>
+#include <linux/kexec.h>
+#include <linux/kmemleak.h>
+
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <crypto/sha1.h>
+
+#include "kallsyms_internal.h"
+#include "kexec_internal.h"
+
+/* Per cpu memory for storing cpu states in case of system crash. */
+note_buf_t __percpu *crash_notes;
+
+/* vmcoreinfo stuff */
+unsigned char *vmcoreinfo_data;
+size_t vmcoreinfo_size;
+u32 *vmcoreinfo_note;
+
+/* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
+static unsigned char *vmcoreinfo_data_safecopy;
+
+
+Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
+			  void *data, size_t data_len)
+{
+	struct elf_note *note = (struct elf_note *)buf;
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = data_len;
+	note->n_type   = type;
+	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
+	memcpy(buf, name, note->n_namesz);
+	buf += DIV_ROUND_UP(note->n_namesz, sizeof(Elf_Word));
+	memcpy(buf, data, data_len);
+	buf += DIV_ROUND_UP(data_len, sizeof(Elf_Word));
+
+	return buf;
+}
+
+void final_note(Elf_Word *buf)
+{
+	memset(buf, 0, sizeof(struct elf_note));
+}
+
+static void update_vmcoreinfo_note(void)
+{
+	u32 *buf = vmcoreinfo_note;
+
+	if (!vmcoreinfo_size)
+		return;
+	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
+			      vmcoreinfo_size);
+	final_note(buf);
+}
+
+void crash_update_vmcoreinfo_safecopy(void *ptr)
+{
+	if (ptr)
+		memcpy(ptr, vmcoreinfo_data, vmcoreinfo_size);
+
+	vmcoreinfo_data_safecopy = ptr;
+}
+
+void crash_save_vmcoreinfo(void)
+{
+	if (!vmcoreinfo_note)
+		return;
+
+	/* Use the safe copy to generate vmcoreinfo note if have */
+	if (vmcoreinfo_data_safecopy)
+		vmcoreinfo_data = vmcoreinfo_data_safecopy;
+
+	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
+	update_vmcoreinfo_note();
+}
+
+void vmcoreinfo_append_str(const char *fmt, ...)
+{
+	va_list args;
+	char buf[0x50];
+	size_t r;
+
+	va_start(args, fmt);
+	r = vscnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	r = min(r, (size_t)VMCOREINFO_BYTES - vmcoreinfo_size);
+
+	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
+
+	vmcoreinfo_size += r;
+
+	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
+		  "vmcoreinfo data exceeds allocated size, truncating");
+}
+
+/*
+ * provide an empty default implementation here -- architecture
+ * code may override this
+ */
+void __weak arch_crash_save_vmcoreinfo(void)
+{}
+
+phys_addr_t __weak paddr_vmcoreinfo_note(void)
+{
+	return __pa(vmcoreinfo_note);
+}
+EXPORT_SYMBOL(paddr_vmcoreinfo_note);
+
+int get_note_size(void)
+{
+	return VMCOREINFO_NOTE_SIZE;
+}
+
+static int __init crash_save_vmcoreinfo_init(void)
+{
+	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+	if (!vmcoreinfo_data) {
+		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
+		return -ENOMEM;
+	}
+
+	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!vmcoreinfo_note) {
+		free_page((unsigned long)vmcoreinfo_data);
+		vmcoreinfo_data = NULL;
+		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
+		return -ENOMEM;
+	}
+
+	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
+	VMCOREINFO_BUILD_ID();
+	VMCOREINFO_PAGESIZE(PAGE_SIZE);
+
+	VMCOREINFO_SYMBOL(init_uts_ns);
+	VMCOREINFO_OFFSET(uts_namespace, name);
+	VMCOREINFO_SYMBOL(node_online_map);
+#ifdef CONFIG_MMU
+	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
+#endif
+	VMCOREINFO_SYMBOL(_stext);
+	VMCOREINFO_SYMBOL(vmap_area_list);
+
+#ifndef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(mem_map);
+	VMCOREINFO_SYMBOL(contig_page_data);
+#endif
+#ifdef CONFIG_SPARSEMEM
+	VMCOREINFO_SYMBOL_ARRAY(mem_section);
+	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
+	VMCOREINFO_STRUCT_SIZE(mem_section);
+	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
+#endif
+	VMCOREINFO_STRUCT_SIZE(page);
+	VMCOREINFO_STRUCT_SIZE(pglist_data);
+	VMCOREINFO_STRUCT_SIZE(zone);
+	VMCOREINFO_STRUCT_SIZE(free_area);
+	VMCOREINFO_STRUCT_SIZE(list_head);
+	VMCOREINFO_SIZE(nodemask_t);
+	VMCOREINFO_OFFSET(page, flags);
+	VMCOREINFO_OFFSET(page, _refcount);
+	VMCOREINFO_OFFSET(page, mapping);
+	VMCOREINFO_OFFSET(page, lru);
+	VMCOREINFO_OFFSET(page, _mapcount);
+	VMCOREINFO_OFFSET(page, private);
+	VMCOREINFO_OFFSET(page, compound_head);
+	VMCOREINFO_OFFSET(pglist_data, node_zones);
+	VMCOREINFO_OFFSET(pglist_data, nr_zones);
+#ifdef CONFIG_FLATMEM
+	VMCOREINFO_OFFSET(pglist_data, node_mem_map);
+#endif
+	VMCOREINFO_OFFSET(pglist_data, node_start_pfn);
+	VMCOREINFO_OFFSET(pglist_data, node_spanned_pages);
+	VMCOREINFO_OFFSET(pglist_data, node_id);
+	VMCOREINFO_OFFSET(zone, free_area);
+	VMCOREINFO_OFFSET(zone, vm_stat);
+	VMCOREINFO_OFFSET(zone, spanned_pages);
+	VMCOREINFO_OFFSET(free_area, free_list);
+	VMCOREINFO_OFFSET(list_head, next);
+	VMCOREINFO_OFFSET(list_head, prev);
+	VMCOREINFO_OFFSET(vmap_area, va_start);
+	VMCOREINFO_OFFSET(vmap_area, list);
+	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
+	log_buf_vmcoreinfo_setup();
+	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
+	VMCOREINFO_NUMBER(NR_FREE_PAGES);
+	VMCOREINFO_NUMBER(PG_lru);
+	VMCOREINFO_NUMBER(PG_private);
+	VMCOREINFO_NUMBER(PG_swapcache);
+	VMCOREINFO_NUMBER(PG_swapbacked);
+	VMCOREINFO_NUMBER(PG_slab);
+#ifdef CONFIG_MEMORY_FAILURE
+	VMCOREINFO_NUMBER(PG_hwpoison);
+#endif
+	VMCOREINFO_NUMBER(PG_head_mask);
+#define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
+	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_NUMBER(PG_hugetlb);
+#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
+	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
+#endif
+
+#ifdef CONFIG_KALLSYMS
+	VMCOREINFO_SYMBOL(kallsyms_names);
+	VMCOREINFO_SYMBOL(kallsyms_num_syms);
+	VMCOREINFO_SYMBOL(kallsyms_token_table);
+	VMCOREINFO_SYMBOL(kallsyms_token_index);
+#ifdef CONFIG_KALLSYMS_BASE_RELATIVE
+	VMCOREINFO_SYMBOL(kallsyms_offsets);
+	VMCOREINFO_SYMBOL(kallsyms_relative_base);
+#else
+	VMCOREINFO_SYMBOL(kallsyms_addresses);
+#endif /* CONFIG_KALLSYMS_BASE_RELATIVE */
+#endif /* CONFIG_KALLSYMS */
+
+	arch_crash_save_vmcoreinfo();
+	update_vmcoreinfo_note();
+
+	return 0;
+}
+
+subsys_initcall(crash_save_vmcoreinfo_init);
+
+static int __init crash_notes_memory_init(void)
+{
+	/* Allocate memory for saving cpu registers. */
+	size_t size, align;
+
+	/*
+	 * crash_notes could be allocated across 2 vmalloc pages when percpu
+	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
+	 * pages are also on 2 continuous physical pages. In this case the
+	 * 2nd part of crash_notes in 2nd page could be lost since only the
+	 * starting address and size of crash_notes are exported through sysfs.
+	 * Here round up the size of crash_notes to the nearest power of two
+	 * and pass it to __alloc_percpu as align value. This can make sure
+	 * crash_notes is allocated inside one physical page.
+	 */
+	size = sizeof(note_buf_t);
+	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
+
+	/*
+	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
+	 * definitely will be in 2 pages with that.
+	 */
+	BUILD_BUG_ON(size > PAGE_SIZE);
+
+	crash_notes = __alloc_percpu(size, align);
+	if (!crash_notes) {
+		pr_warn("Memory allocation for saving cpu register states failed\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+subsys_initcall(crash_notes_memory_init);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..f4dea403bda7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -951,7 +951,7 @@ const struct file_operations kmsg_fops = {
 	.release = devkmsg_release,
 };
 
-#ifdef CONFIG_CRASH_CORE
+#if defined(CONFIG_CRASH_CORE) || defined(CONFIG_OS_MINIDUMP)
 /*
  * This appends the listed symbols to /proc/vmcore
  *
diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0e..78d7ce03b34e 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -174,7 +174,8 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE) \
+		|| (IS_ENABLED(CONFIG_OS_MINIDUMP))
 unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
 
 /**
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
