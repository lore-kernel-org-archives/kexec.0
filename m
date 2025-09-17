Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26801CAC59F
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 02:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSn2CmdF8+yf4DtOsVnJBkMWdMtw6s5eBLN2Lm9vVpQ=; b=Zw8wV7u8ZPWJliV89zExD4WoXX
	HrS7OetqQFddbc0IFArCvtwt42I8DHPA9vWGJ1APrMDICnW5RY/jw6ztYchtrIuL5OCvo2VLjQ96d
	pdsV4REJZ86EmPA2XCMa8+BJY1FXE+kZkyS6TDCUB6NTeQ1UDOoAsS7+5QdAYskWtbk0VlPWJxeQM
	eYWIgrTI/Ti3hjefgXQjOdQ5+HNrFUZ6xEd34ZCaZViBuSjci+YKlgsgUjx1HfmGWHzxezs6ONJBV
	OqIzsiOzqaySCNaxR0LKJNq2OPeIgllgsP9f2Zv1KnAMEncSXcOQchOEKyjMfzsaHFwW6PQiINx0o
	nosYeH4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyiFr-0000000A0dm-35ci;
	Wed, 17 Sep 2025 02:50:47 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyiFp-0000000A0bb-1Ugi
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 02:50:46 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so260310a91.2
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077444; x=1758682244; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSn2CmdF8+yf4DtOsVnJBkMWdMtw6s5eBLN2Lm9vVpQ=;
        b=HB6tSCRuhJMV284LbaGvlUp7oFf1rn1pASEntqP1DaA49yZAKfqzeLZGhyVT7sOtc1
         ssvdKu9oOyCGTvXL9JZZupfQ4dGXpGPv5H30+XSq+5DAQjlJQ7OmTFWbQceSR0F6WavR
         RRXToHctVtwJ01KSqVCwstj11F9kPHPD0Qd5MEVDW+mKyhZQdyeZzDPX472NACZnHgQ7
         y74G4aYrwp8iIeshGcvfomKnMaqKrGdVjb+z4OVeceMN9juLmxGkPs/mjxivhkJcn4TZ
         Xgq0jCqQs+GGm0yoaj7HpbJZmPvTpS406bWkl91rlTyspHPrfIpZ58yJWC2sPid7/rRJ
         oJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077444; x=1758682244;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSn2CmdF8+yf4DtOsVnJBkMWdMtw6s5eBLN2Lm9vVpQ=;
        b=Ek5HPOXCc90+OSYAwzu3YSU7S/fgczA9FWvGUj6IOF4HExswCZY5kaPZVhLYIVC98Y
         xskLYtHF/z9KFZrhFxfmdcqLJl/XwYUq18gffC9Fdrlcgb+b+FSraRoB1Y7KLgfVBgdr
         uH20hwBKB56fEmc0KwYZGTnsPBeDNCU/Q5I8V+/uVX5fR8Dp7SFIZeIqnt9ltPCJiFQF
         VEUKMNrC+plUrgQ/iVKIkGCZKFJYJNYjQAikMbyZEACbKRiC2kxgcpG9u3qnURY/NJfj
         pq9e2QO6NeNG1CpsPsbr2onv6cVejjYPU50vKkyYJ47hZrpMRzdgnWuHoSbZuC6V0u0K
         vnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPBIQoaP90JWZrzdGpMXfNrzQF6WdVcpdgHrYKYGU7wQATgYmaknE+vOIvZ2EBjXcSb80fBA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJDGT9yp6X8L2L90lewpiU6j9/4tYbMpOHXM68CKQtL0sRfj2C
	UDjWI/I4FOGE06SQMUnPtKccLXI075HWOesWnYdXAFIc6PvRLmNzylUPCCEFtPmLLN9hAS/Vtqv
	wzfUn4Gfg71rblQ==
X-Google-Smtp-Source: AGHT+IHQ74t+zzjdi8h+z/5IY48HHRSYodyFCrNO4puZo9tU2iy1v7RraJy6Ayld7eqRNTEp/i2TMXedcJZ7fA==
X-Received: from pjbdy13.prod.google.com ([2002:a17:90b:6cd:b0:32e:2c41:7def])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fcf:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-32ee3f65f8fmr715320a91.33.1758077443958;
 Tue, 16 Sep 2025 19:50:43 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:18 -0700
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-4-jasonmiu@google.com>
Subject: [RFC v1 3/4] memblock: Remove KHO notifier usage
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_195045_402637_D8DC05DF 
X-CRM114-Status: GOOD (  20.88  )
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

Update memblock to use direct KHO API calls for memory preservation.

Remove the KHO notifier registration and callbacks from the memblock
subsystem. These notifiers were tied to the former KHO finalize and
abort events, which are no longer used.

Memblock now preserves its `reserve_mem` regions and registers its
metadata by calling kho_preserve_phys(), kho_preserve_folio(), and
kho_add_subtree() directly within its initialization function. This is
made possible by changes in the KHO core to complete the FDT at a
later stage, during kexec.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h |  7 ++----
 kernel/kexec_core.c            |  4 +++
 kernel/kexec_handover.c        | 46 +++++++++++++++++++++-------------
 kernel/kexec_internal.h        |  2 ++
 mm/memblock.c                  | 46 ++++++++--------------------------
 5 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index c8229cb11f4b..e29dcf53de7e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -19,15 +19,13 @@ enum kho_event {
 struct folio;
 struct notifier_block;
 
-struct kho_serialization;
-
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 int register_kho_notifier(struct notifier_block *nb);
@@ -58,8 +56,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..3cf33aaded17 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1147,6 +1147,10 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	error = kho_commit_fdt();
+	if (error)
+		goto Unlock;
+
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		/*
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 578d1c1b9cea..f7933b434364 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -682,9 +682,21 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 	return 0;
 }
 
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+	struct dentry *dir;
+	struct kho_serialization ser;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+	},
+};
+
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
- * @ser: serialization control object passed by KHO notifiers.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
  *
@@ -697,8 +709,9 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
+	struct kho_serialization *ser = &kho_out.ser;
 	int err = 0;
 	u64 phys = (u64)virt_to_phys(fdt);
 	void *root = page_to_virt(ser->fdt);
@@ -714,19 +727,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-	struct dentry *dir;
-	struct kho_serialization ser;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-	},
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -952,6 +952,7 @@ static int kho_out_fdt_init(void)
 	void *fdt = page_to_virt(kho_out.ser.fdt);
 	u64 *preserved_order_table;
 
+	/* Do not close the root node and FDT until kho_commit_fdt() */
 	err |= fdt_create(fdt, PAGE_SIZE);
 	err |= fdt_finish_reservemap(fdt);
 	err |= fdt_begin_node(fdt, "");
@@ -965,9 +966,6 @@ static int kho_out_fdt_init(void)
 
 	*preserved_order_table = (u64)virt_to_phys(kho_order_table);
 
-	err |= fdt_end_node(fdt);
-	err |= fdt_finish(fdt);
-
 abort:
 	if (err)
 		pr_err("Failed to convert KHO state tree: %d\n", err);
@@ -1211,6 +1209,18 @@ int kho_fill_kimage(struct kimage *image)
 	return 0;
 }
 
+int kho_commit_fdt(void)
+{
+	int err = 0;
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+
+	/* Close the root node and commit the FDT */
+	err = fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+	return err;
+}
+
 static int kho_walk_scratch(struct kexec_buf *kbuf,
 			    int (*func)(struct resource *, void *))
 {
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 228bb88c018b..490170911f5a 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -46,6 +46,7 @@ struct kexec_buf;
 int kho_locate_mem_hole(struct kexec_buf *kbuf,
 			int (*func)(struct resource *, void *));
 int kho_fill_kimage(struct kimage *image);
+int kho_commit_fdt(void);
 #else
 static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 				      int (*func)(struct resource *, void *))
@@ -54,5 +55,6 @@ static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 }
 
 static inline int kho_fill_kimage(struct kimage *image) { return 0; }
+static inline int kho_commit_fdt(void) { return 0; }
 #endif /* CONFIG_KEXEC_HANDOVER */
 #endif /* LINUX_KEXEC_INTERNAL_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..978717d59a6f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2001 Peter Bergner.
  */
 
+#include "asm-generic/memory_model.h"
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -2510,39 +2511,6 @@ int reserve_mem_release_by_name(const char *name)
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
 static struct page *kho_fdt;
 
-static int reserve_mem_kho_finalize(struct kho_serialization *ser)
-{
-	int err = 0, i;
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-	}
-
-	err |= kho_preserve_folio(page_folio(kho_fdt));
-	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
-
-	return notifier_from_errno(err);
-}
-
-static int reserve_mem_kho_notifier(struct notifier_block *self,
-				    unsigned long cmd, void *v)
-{
-	switch (cmd) {
-	case KEXEC_KHO_FINALIZE:
-		return reserve_mem_kho_finalize((struct kho_serialization *)v);
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	default:
-		return NOTIFY_BAD;
-	}
-}
-
-static struct notifier_block reserve_mem_kho_nb = {
-	.notifier_call = reserve_mem_kho_notifier,
-};
-
 static int __init prepare_kho_fdt(void)
 {
 	int err = 0, i;
@@ -2583,7 +2551,7 @@ static int __init prepare_kho_fdt(void)
 
 static int __init reserve_mem_init(void)
 {
-	int err;
+	int err, i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
@@ -2592,7 +2560,15 @@ static int __init reserve_mem_init(void)
 	if (err)
 		return err;
 
-	err = register_kho_notifier(&reserve_mem_kho_nb);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= kho_preserve_phys(map->start, map->size);
+	}
+
+	err |= kho_preserve_folio(page_folio(kho_fdt));
+	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
+
 	if (err) {
 		put_page(kho_fdt);
 		kho_fdt = NULL;
-- 
2.51.0.384.g4c02a37b29-goog


