Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E826C369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfewFjZZgA0wbLHZ0utjYl4REWcdoeGGCmHLPQc1YQk=; b=JEiagJED6BIaCIz2WPuMPRb7Cy
	plPpmJSIuUAMRPmMxGzWuo5F4FYKhecCk14nLZ2j56mrKKc6cT20iT2dSF8iSejIpuO1p8Jm43tGO
	G3ZEc+r6CXqncISBznCK7njjmMyhivuDRe1UzW7QFSNczDawLd7O+KxPdAn2yx8zvRE0zdsqPyY3J
	xTPSITJP3uh4oH7uQukjvAW7L7MNUzw7VvFs3doMra/ryf7ODasI+kSJdwTucyt6gjF6rNOSPWslA
	gnyEc684120KjPEmbdPFpwLFbiaU+AtTE2K0tDj+FOSNPM/bSGuqr07/TA2QFpL9iifYRy5OWsou/
	RdOa1LIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAdEg-00000000FqM-3yyN;
	Thu, 01 May 2025 23:22:34 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcog-000000007Wn-1KHx
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:44 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2242f3fd213so12463795ad.1
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140141; x=1746744941; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfewFjZZgA0wbLHZ0utjYl4REWcdoeGGCmHLPQc1YQk=;
        b=iMuD0VLATlCuLYekUrrKvswJeNqYTRAXUCYX1IVe2wIrWAat0kkZHhaanmeWDjpLIT
         xql6xZGKdkwVb0P715k/Xuct9n91jm/NtNsffdnVwoB4vhF4QcHMeQjpVSTH8LdfQLD9
         DdikBhlMjN+YHpcLprlJcdag+UW7cSWrAmRq1yvntfVjKwQDp8/Jdm8Ouga4PzNQmpQd
         HYRxULDMXGbfLeLNNB8gTZU5IG0QXP2dY5bn3bWNr3tD+F1Coe/3KD4oYb7ehQ9LVpSD
         6CmZb6B95jeXUXZXDFFrUQjalZIaM1Oz5SAm/HZKYqRwLykKG4in+PfVSPG+0JimIb6f
         gNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140141; x=1746744941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfewFjZZgA0wbLHZ0utjYl4REWcdoeGGCmHLPQc1YQk=;
        b=Qc9AKVNFvehVDSgp+bFtus6ouHdeTJ7jWfnqHVVdhnEs0WoNDBrST1EZStlb3jC0Do
         ceLnUgtTbxvXBNL6vFHHsOdYOiNx6Ki5w8POqPZou84aVwqIcO+RKrbTiBIl72gwZe4R
         Few/cmETL8QU7L/4qYsXgHWMAd5CfIuDbYGGSDnbeGXygJ3NRhTT3mVvJ7OeElZV+fQV
         ezHF3n7J6pwq0O+7/ggSNlkDrgnwQjzUJHK9SlveHOD+yb5HPXu51IuKy3J01pA1kT1N
         SZnF0HSDMDX1I316MIsyz+0JXmXgUEmdysC1weslr3wgZauVxdsoONBRsF//k+WKBzTN
         EchA==
X-Forwarded-Encrypted: i=1; AJvYcCVPU9HP3PEqoF1gxqLiSnkSOhcQsVSO7kUfXlCQTo7BQtEQpXeHr08VVAN0VXG/EdaBcLSZiA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLtkAMdX9rpApiptu75Al16jROIevNjIA9glDrNxxLNdj1Ajt8
	UZ6ZpyzV19kiDptJKpI4QTG8eZcxZaoEdW+xVslLimF6zWICZPdio7L2sNJxirgsUS1T32aogRK
	KCXtClGhx0DMPCfmWOg==
X-Google-Smtp-Source: AGHT+IGItHhc8YdkABGJyaGvVxl19Y7R7MBDsRAPRNtryCWPo0I1aAnulHG4c/Jmy4vZoSyaAqXIqrI14d7kkyuV
X-Received: from plq10.prod.google.com ([2002:a17:903:2f8a:b0:22c:31cd:5f2e])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a6b:b0:225:adf8:8634 with SMTP id d9443c01a7336-22e103ca1b3mr10294705ad.51.1746140141096;
 Thu, 01 May 2025 15:55:41 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:23 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-17-changyuanl@google.com>
Subject: [PATCH v7 16/18] memblock: add KHO support for reserve_mem
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_155542_350747_84B8DE28 
X-CRM114-Status: GOOD (  20.82  )
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

From: Alexander Graf <graf@amazon.com>

Linux has recently gained support for "reserve_mem": A mechanism to
allocate a region of memory early enough in boot that we can cross our
fingers and hope it stays at the same location during most boots, so we
can store for example ftrace buffers into it.

Thanks to KASLR, we can never be really sure that "reserve_mem"
allocations are static across kexec. Let's teach it KHO awareness so
that it serializes its reservations on kexec exit and deserializes them
again on boot, preserving the exact same mapping across kexec.

This is an example user for KHO in the KHO patch set to ensure we have
at least one (not very controversial) user in the tree before extending
KHO's use to more subsystems.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 mm/memblock.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9202c3412bb19..27b6325a65b00 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -18,6 +18,11 @@
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/libfdt.h>
+#include <linux/kexec_handover.h>
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 #include <asm/sections.h>
 #include <linux/io.h>
 
@@ -2475,6 +2480,196 @@ int reserve_mem_release_by_name(const char *name)
 	return 1;
 }
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#define MEMBLOCK_KHO_FDT "memblock"
+#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
+#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
+static struct page *kho_fdt;
+
+static int reserve_mem_kho_finalize(struct kho_serialization *ser)
+{
+	int err = 0, i;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= kho_preserve_phys(map->start, map->size);
+	}
+
+	err |= kho_preserve_folio(page_folio(kho_fdt));
+	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
+
+	return notifier_from_errno(err);
+}
+
+static int reserve_mem_kho_notifier(struct notifier_block *self,
+				    unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case KEXEC_KHO_FINALIZE:
+		return reserve_mem_kho_finalize((struct kho_serialization *)v);
+	case KEXEC_KHO_ABORT:
+		return NOTIFY_DONE;
+	default:
+		return NOTIFY_BAD;
+	}
+}
+
+static struct notifier_block reserve_mem_kho_nb = {
+	.notifier_call = reserve_mem_kho_notifier,
+};
+
+static int __init prepare_kho_fdt(void)
+{
+	int err = 0, i;
+	void *fdt;
+
+	kho_fdt = alloc_page(GFP_KERNEL);
+	if (!kho_fdt)
+		return -ENOMEM;
+
+	fdt = page_to_virt(kho_fdt);
+
+	err |= fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= fdt_begin_node(fdt, map->name);
+		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
+		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
+		err |= fdt_property(fdt, "size", &map->size, sizeof(map->size));
+		err |= fdt_end_node(fdt);
+	}
+	err |= fdt_end_node(fdt);
+
+	err |= fdt_finish(fdt);
+
+	if (err) {
+		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
+		put_page(kho_fdt);
+		kho_fdt = NULL;
+	}
+
+	return err;
+}
+
+static int __init reserve_mem_init(void)
+{
+	int err;
+
+	if (!kho_is_enabled() || !reserved_mem_count)
+		return 0;
+
+	err = prepare_kho_fdt();
+	if (err)
+		return err;
+
+	err = register_kho_notifier(&reserve_mem_kho_nb);
+	if (err) {
+		put_page(kho_fdt);
+		kho_fdt = NULL;
+	}
+
+	return err;
+}
+late_initcall(reserve_mem_init);
+
+static void *__init reserve_mem_kho_retrieve_fdt(void)
+{
+	phys_addr_t fdt_phys;
+	struct folio *fdt_folio;
+	int err;
+	static void *fdt;
+
+	if (fdt)
+		return fdt;
+
+	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
+	if (err) {
+		if (err != -ENOENT)
+			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
+				MEMBLOCK_KHO_FDT, err);
+		return NULL;
+	}
+
+	fdt_folio = kho_restore_folio(fdt_phys);
+	if (!fdt_folio) {
+		pr_warn("failed to restore memblock KHO FDT (0x%llx)\n", fdt_phys);
+		return NULL;
+	}
+
+	fdt = folio_address(fdt_folio);
+
+	err = fdt_node_check_compatible(fdt, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("FDT '%s' is incompatible with '%s': %d\n",
+			MEMBLOCK_KHO_FDT, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
+		fdt = NULL;
+	}
+
+	return fdt;
+}
+
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	int err, len_start, len_size, offset;
+	const phys_addr_t *p_start, *p_size;
+	const void *fdt;
+
+	fdt = reserve_mem_kho_retrieve_fdt();
+	if (!fdt)
+		return false;
+
+	offset = fdt_subnode_offset(fdt, 0, name);
+	if (offset < 0) {
+		pr_warn("FDT '%s' has no child '%s': %d\n",
+			MEMBLOCK_KHO_FDT, name, offset);
+		return false;
+	}
+	err = fdt_node_check_compatible(fdt, offset, RESERVE_MEM_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("Node '%s' is incompatible with '%s': %d\n",
+			name, RESERVE_MEM_KHO_NODE_COMPATIBLE, err);
+		return false;
+	}
+
+	p_start = fdt_getprop(fdt, offset, "start", &len_start);
+	p_size = fdt_getprop(fdt, offset, "size", &len_size);
+	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
+	    len_size != sizeof(*p_size)) {
+		return false;
+	}
+
+	if (*p_start & (align - 1)) {
+		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%lx, 0x%lx)\n",
+			name, (long)align, (long)*p_start);
+		return false;
+	}
+
+	if (*p_size != size) {
+		pr_warn("KHO reserve-mem '%s' has wrong size (0x%lx != 0x%lx)\n",
+			name, (long)*p_size, (long)size);
+		return false;
+	}
+
+	reserved_mem_add(*p_start, size, name);
+	pr_info("Revived memory reservation '%s' from KHO\n", name);
+
+	return true;
+}
+#else
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 /*
  * Parse reserve_mem=nn:align:name
  */
@@ -2530,6 +2725,11 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_find_by_name(name, &start, &tmp))
 		return -EBUSY;
 
+	/* Pick previous allocations up from KHO if available */
+	if (reserve_mem_kho_revive(name, size, align))
+		return 1;
+
+	/* TODO: Allocation must be outside of scratch region */
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
-- 
2.49.0.906.g1f30a19c02-goog


