Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F59CAC598
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 02:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B0DvEATy1boxO8jY+p5CHjM48FocEtwboNagjTq4rGo=; b=IOY5+mLkDA5SgZpPf8MZEyxlo5
	ZZ/La/8/YfICSgwVFSGnvI54TM6pMx6Bo2P+UvxQVCsNBjQIqQ0D6HFGPV4KX9iy557P3/VplGas1
	Mq/uG1+IyVk/TC84ay7qkz6U1j9NcUdBF8Kde1TzEK9TypGTiWy8QeUvZyd4vlfk2a7lpyiPAArRN
	+fXCzliZ6vgu/6T0j3x9xebneDUk/2aExNqp7m39DX5MZqV4zS0g0vd2hMXy+E2A0FGsv9gqK7Yn+
	ayYFUTC+CX4kH4kkEfRWyG9mNmS5JsNYhkgGfBVZQ2LusvYUpgr67TKBp6PaKNJamtcaYeBL3jdPW
	sShZWAPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyiFx-0000000A0hr-1kSK;
	Wed, 17 Sep 2025 02:50:53 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyiFu-0000000A0fU-3x96
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 02:50:52 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-24ced7cfa07so63663735ad.1
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758077449; x=1758682249; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0DvEATy1boxO8jY+p5CHjM48FocEtwboNagjTq4rGo=;
        b=zsWRb1LzH32D2aWEfdbL2Jo5QSfAEfTYOY3xxRNBnz4HdPR1PTuoOQ68r2m56DzsEd
         JpJd2XGLHVJ8Zn0iESORCnO+wZ++GMMxzMKCzMdgQR7gBJkfg1HVvROIzKs8kcR2CM+8
         1WJKIMql2++WMgec8R4MWJm1ZnR8ZgjLabJMqAhVA9OM2aDj5Hb4q/IcJhYtooa+nHjh
         Nv/US2vakzrlfGLDWmetJdNXIck38cuRWAJehxeCLwFPnHTPEiFwzRrBF+SOQQ3zbAUr
         UfljfleUfwVSYSOP4t9WzqlFELRMYD9oITqe/MZxwI0xdfTlp5/w+A7isaZr2l98vhl5
         rZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077449; x=1758682249;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0DvEATy1boxO8jY+p5CHjM48FocEtwboNagjTq4rGo=;
        b=iqDNJ3Y46+WLwKyBSch7ZFvzp27cvidqH/FtsBpKcKjJpNEY1PF0Zno4mbpaQsAdtZ
         1R6pUmNuDHj06ZgoXLexeDLZHPJdqpKA6I14hnWzaXT62bORdDHFRVQXvxtRnCPfdmoM
         Oh7SubtIelwavKiT/e4MsQ9wLoE9TxZlKbB1CaBTxT9GfKKoMwRbSkQY8xr6IeD+fXzk
         4V7HCsBTwWE6fThhbsEP4MdexZE4d4sxdI4fV/fJdA+QzratfC3EE+5YcfrCnxT8uHJT
         xQIo5RNQc00XlIR3YWppgP9YsTKg0QDcgEBkIRwzMJl0OcuuUjOKd03CQaXDAOBcPSna
         NaHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGdER77VkYVXvy7TUZIWsIA2Sjxv3RbGrLEoyNsyPte1+eqZteN0GSCE/siM0p4BNcM39xfA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2i+7Xjd/MJFUpBIfkuxIe0lsrpPoOi5ZISzsJavWmpVLnTvAI
	keZxw/MkLk+3J+dtVYjR53EX9PIhkw7MIx6ZkasTVN5dBr4Fu0uRvy2wn5d+QqPRaBXdImZ/S3s
	0/8xrnsddyJe3kw==
X-Google-Smtp-Source: AGHT+IERUNLZmWljnHVW/VI2Iz32N7whxhHeQqNofUwRKCrC4MDBM1MGWQZdKx/R1kYbmKHfIml8z0yP7qtaZA==
X-Received: from pjk5.prod.google.com ([2002:a17:90b:5585:b0:32e:3646:77d6])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db02:b0:267:cdb8:c683 with SMTP id d9443c01a7336-268123806c5mr6135285ad.27.1758077449502;
 Tue, 16 Sep 2025 19:50:49 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:50:19 -0700
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917025019.1585041-5-jasonmiu@google.com>
Subject: [RFC v1 4/4] kho: Remove notifier system infrastructure
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
X-CRM114-CacheID: sfid-20250916_195050_993344_88785D77 
X-CRM114-Status: GOOD (  10.74  )
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

Remove the KHO notifier system.

Eliminate the core KHO notifier API
functions (`register_kho_notifier`, `unregister_kho_notifier`), the
`kho_event` enum, and the notifier chain head from KHO internal
structures.

This infrastructure was used to support the now-removed finalize and
abort states and is no longer required. Client subsystems now interact
with KHO through direct API calls.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h | 20 --------------------
 kernel/kexec_handover.c        | 15 ---------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index e29dcf53de7e..09e8f0b0fcab 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -10,14 +10,7 @@ struct kho_scratch {
 	phys_addr_t size;
 };
 
-/* KHO Notifier index */
-enum kho_event {
-	KEXEC_KHO_FINALIZE = 0,
-	KEXEC_KHO_ABORT = 1,
-};
-
 struct folio;
-struct notifier_block;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
@@ -28,9 +21,6 @@ struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -66,16 +56,6 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	return -EOPNOTSUPP;
 }
 
-static inline int register_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void kho_memory_init(void)
 {
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index f7933b434364..62f654b08c74 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -16,7 +16,6 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 
 #include <asm/early_ioremap.h>
@@ -683,13 +682,11 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 }
 
 struct kho_out {
-	struct blocking_notifier_head chain_head;
 	struct dentry *dir;
 	struct kho_serialization ser;
 };
 
 static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
 	.ser = {
 		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
 	},
@@ -727,18 +724,6 @@ int kho_add_subtree(const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-int register_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(register_kho_notifier);
-
-int unregister_kho_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
-}
-EXPORT_SYMBOL_GPL(unregister_kho_notifier);
-
 /**
  * kho_preserve_folio - preserve a folio across kexec.
  * @folio: folio to preserve.
-- 
2.51.0.384.g4c02a37b29-goog


