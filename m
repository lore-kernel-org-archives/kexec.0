Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BC6CCD199
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/xrVZHpXvHRMhRkGHJU8i3nfYQNiwJDcAoOnm63ckE=; b=dILv/VjOPiWATAdYYNjItYgK5E
	WwN7isbsM+G6rgr9PBWaNdw5MpnuP3otreAGOvKUsND6jpmsrcHIow+bUh5Hp5qWNAI/ncbr/8vyy
	VmzCQYBSsycU5PvrAYgsw8ZFnA+PB2QZprkCi5+6NLibokhH7HxujHVBWcVw9KPH7hz6VyphKuJVU
	x+NaHJi4SfYhMDU51XZcQoVS94eJClro3etMmvB8yomP2HT6KJ/1rR3A2fO6md63XtR6w6dctpBx2
	axQR4iHNxm2rcQOAGyQn8ahc0n3ODARnoT+U5x/+yLzQjMp3FAJ26NwIy/+Myly14bcfLGR8LMtPS
	T2gcJrMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmjY-0000000CiAt-1sMC;
	Mon, 20 Oct 2025 10:03:20 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmjV-0000000Ci6i-14pl
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 10:03:18 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-26983c4d708so34124165ad.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954596; x=1761559396; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/xrVZHpXvHRMhRkGHJU8i3nfYQNiwJDcAoOnm63ckE=;
        b=4r6xYq80Fv+yCPY0evWx5b3xyfURHokEhscgL5X6GRY11URAIm4RRwLQ7/rQq+8hB2
         uevg0LnOwGMDltIPt2MjfToOTeIlmurQRms+74fLYjWYcwp+smIXF8Enb/5WG+0uwUpR
         DxS6SOYDusHVMQWfHJ4eCzNjPJMUuWC0Z5Yy8R9rLmknf/vTFAaC1m1sUZSWKBW1fPAD
         +Iazzu3mu5sA4NaKC6J3qsc57NF0jRFzkCewM3pO5mWtSS1F9pHYuHRxzvFtCGeTwU3X
         8NacSB7CtrJh7YlrVsp/0LB1a7j6K8hyfxYU5JCuRvbF2ewL0ADr6oXZny5Sc/qA+/Tp
         93KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954596; x=1761559396;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/xrVZHpXvHRMhRkGHJU8i3nfYQNiwJDcAoOnm63ckE=;
        b=VKzwiE0EPyPpFN2CKwhl+JRF4cFnZ/gqKOCDkig/qygXff4hs2b+F5snZHPiLih1Ft
         Ra1r8MRnG9jwxSiR8Nai59U7OjnvD0FXbtQU91s+fvhOAW4ACdK/3qYMaKosn4O+Cl7+
         jOoi+CJCqm8hOSZUFZRQH5Mc3nhl7TfYv2mP22HqERnvbVtuk6QDuCrjhHFZBsC7JOud
         VKw5wT3Qi6pHbZ/3mLqTUYmmdfEYoe7K1VX3lWOFqLAg1MiZjmef+7TXNr8XVePfSlT3
         IBxxyTTfKis4xr0AJH5RQ0fylqJYKF1Je/FHvfu+GmzQVOb0pJ3iD6UPbAAarfpubTBn
         BNoA==
X-Forwarded-Encrypted: i=1; AJvYcCXYg8Cm9+7PCmVNY4cBfFSanMELhLhZtNuvjPzlaBjtZf10ZGLc3vajJ+T+20YISG698Fp/Cg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4ClT5vUHvNONCeQo1ctRp3rY+Xng+I9IyRtYJdOTxILje0P4s
	5nt8kQAjQVFrN4++9CwCfUYrWtwuLmxB60FDod6sdf/rZLNa+iXFIdbRHlE4pk8wRshIzxmu4bj
	+dCxH7aTnQ6KGmg==
X-Google-Smtp-Source: AGHT+IEzFK4LZayLd5iN1w0uFbIESnuBTugytBDsMRryC9YXYqChyResDflUkGa6F21iVpOozbAUdMrrBXy9VA==
X-Received: from plcr12.prod.google.com ([2002:a17:903:14c:b0:290:4eeb:bc7a])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id d9443c01a7336-290c9cd4b48mr146517415ad.25.1760954595745;
 Mon, 20 Oct 2025 03:03:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:06 -0700
In-Reply-To: <20251020100306.2709352-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-4-jasonmiu@google.com>
Subject: [PATCH v2 3/3] kho: Remove notifier system infrastructure
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_030317_302934_9D219C58 
X-CRM114-Status: GOOD (  11.07  )
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

Eliminate the core KHO notifier API
functions (`register_kho_notifier`, `unregister_kho_notifier`), the
`kho_event` enum, and the notifier chain head from KHO internal
structures.

This infrastructure was used to support the now-removed finalize and
abort states and is no longer required. Client subsystems now interact
with KHO through direct API calls.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h | 22 ----------------------
 kernel/kexec_handover.c        | 15 ---------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 1f2ca09519a1..d345f301c57b 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -10,16 +10,7 @@ struct kho_scratch {
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
-
-struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
@@ -31,9 +22,6 @@ int kho_add_subtree(const char *name, void *fdt);
 int kho_remove_subtree(const char *name);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
-int register_kho_notifier(struct notifier_block *nb);
-int unregister_kho_notifier(struct notifier_block *nb);
-
 void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
@@ -74,16 +62,6 @@ static inline int kho_remove_subtree(const char *name)
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
index 1138b16fa546..325b83a609fc 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -17,7 +17,6 @@
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/memblock.h>
-#include <linux/notifier.h>
 #include <linux/page-isolation.h>
 #include <linux/rwsem.h>
 #include <linux/live_update/abi/kexec_handover.h>
@@ -674,13 +673,11 @@ static int kho_debugfs_fdt_remove(struct list_head *list, const char *name)
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
@@ -787,18 +784,6 @@ int kho_remove_subtree(const char *name)
 }
 EXPORT_SYMBOL_GPL(kho_remove_subtree);
 
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
2.51.0.858.gf9c4a03a3a-goog


