Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EF0CD4F3D
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5K2FdXzRnABLtF63rsnxGYJOAKntAeJNMkiCQxBi/I=; b=zi+jVgpTXSdjLqFlqwp82+THYs
	l7pIm/YYCdEvQi+5SoBdRq4CGfhKbLoltr3kakUDel0C0rvePQTCivYyxOL++ckeOUMiIGK9bBDg/
	duhe0LhTnFKFrDP1WiU2yb6GwEP5K9qLBDbzVN+02vuTIbpKJDTiULOMSwbL6w1RSXhRWc9gAUxNK
	qaQlxn7q/ONyGm6YBCNvMExanF3CCvcf7tHRsgeMGSfHrzlr7185xW4w/MAgXOgTGksvD2Q+cj1jW
	Kz3CJ0kks1bWe7E8dOQdAfW2VW+eYNGcHFQ8zlJ7fCQsvZVevW5Mvi3cxqhvHNMgXY/1IBzbfAxtt
	7k9gclDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97q-00000008uwn-0TZ5;
	Thu, 21 May 2026 19:32:10 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97n-00000008uuI-22BT
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 19:32:08 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so3278697b3a.3
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779391925; x=1779996725; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5K2FdXzRnABLtF63rsnxGYJOAKntAeJNMkiCQxBi/I=;
        b=KvE74/WFQoBuvDZsPSlmFuVt1tiwBwgQx4/hmM+7XmW3j4RBAJ1wL8uHbk09nKRzVB
         2iDJYWr3ql6sdtbFI2OqhdZSJwnAnTqe0bNMqdI7NPaFn80lYihwkCpI4lGkRNGfgXK7
         cpUJrt9Eq6L6v602MjRptNTSWRjU5QSC699deQqeTsDZvi6vp5VwzywtNtE7tW38FtAS
         q7tfi9PZJRVkNPcLmKC1LjXM7xIVR3uEwQM9kQxRXuh6GALYeRMc3LYX1SfNYMEDcg5J
         W+YPQ5w+tFDDEKtfK2kyNb/cnMRtPjWS5oexNGmi2DfREby3oy/+Y0N+TEOCrs1RccID
         F66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391925; x=1779996725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5K2FdXzRnABLtF63rsnxGYJOAKntAeJNMkiCQxBi/I=;
        b=AKDY97b5mQQaBVO1T2zDD8qUbS3uaHvvUiEucqZlqFR6+d8U5oNxB7mDbPzFx4vv47
         tMKZh1LP4Njje4bAwrYjTXH2xfwsl2F3YuOZETD4JJEhrSSQJw/v5nUTf0QohqSWo2Xv
         zUEqITI6ST5AEKiCC9XbLbEJHxYDOh5cL0lHAyaLHdAZSmQDg+ziJgszk+LH0yDQwGS5
         RIjy75Xe1ZZ0naEqYNwPgl5mDbLLdpb8qzLkQtguVtuokFK3KtqTIBTtouiU3XOcAWVn
         gfRLmo35J4Vl6pE50iotMLfjxc1Jn6GA8OLclp6boLn6NaLjIk27P6r7VXeRLL75kcHd
         gtzw==
X-Forwarded-Encrypted: i=1; AFNElJ8V7kUEXmEbidKxa80FG6lvPrnrHTLFnMc1jGU4s3BgBkr2eMsYgJ3FD0LvHmp7KtAB7LHc0w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/kBAU1TVE4498HxG26AWEMu6mkrRjlwCXzUTbgnBXsclvvDoT
	j2A4FVm4rrbM8EYY8Uy+ECyY6Hj11ZUda4NKC5k4i7aBT4ULG+04PLomNjO69DrAsCr2DXqw/98
	MYWGteAIrLLGntg==
X-Received: from pfwp44.prod.google.com ([2002:a05:6a00:26ec:b0:83f:75b6:75ac])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d81:b0:837:42a6:589d with SMTP id d2e1a72fcca58-8415f129f9amr521581b3a.11.1779391924486;
 Thu, 21 May 2026 12:32:04 -0700 (PDT)
Date: Thu, 21 May 2026 19:32:01 +0000
In-Reply-To: <20260521193202.746810-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260521193202.746810-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521193202.746810-3-skhawaja@google.com>
Subject: [PATCH v2 2/3] kho: Add helper function to check if pages are preserved
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_123207_529799_770BDC6E 
X-CRM114-Status: GOOD (  11.68  )
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

Kunit test needs to check whether the pages are preserved after
preservation or after unpreserve. The helper function added is only
enabled when kunit is enabled.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/kexec_handover.h     |  5 +++
 kernel/liveupdate/kexec_handover.c | 53 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..a3afc74cf41c 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -32,6 +32,11 @@ void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool kho_test_pages_preserved(phys_addr_t phys, unsigned long nr_pages);
+#endif
+
 int kho_add_subtree(const char *name, void *blob, size_t size);
 void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 902019f36c24..abe201825e83 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "KHO: " fmt
 
 #include <kunit/static_stub.h>
+#include <kunit/visibility.h>
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
@@ -1775,3 +1776,55 @@ int kho_locate_mem_hole(struct kexec_buf *kbuf,
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
+
+#if IS_ENABLED(CONFIG_KUNIT)
+static bool _kho_is_pfn_preserved(struct kho_radix_tree *tree,
+				  unsigned long pfn, unsigned int order)
+{
+	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
+	struct kho_radix_node *node;
+	struct kho_radix_leaf *leaf;
+	unsigned int i, idx;
+
+	if (!tree->root)
+		return false;
+
+	guard(mutex)(&tree->lock);
+
+	node = tree->root;
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		idx = kho_radix_get_table_index(key, i);
+
+		if (!node->table[idx])
+			return false;
+
+		node = phys_to_virt(node->table[idx]);
+	}
+
+	idx = kho_radix_get_bitmap_index(key);
+	leaf = (struct kho_radix_leaf *)node;
+
+	return test_bit(idx, leaf->bitmap);
+}
+
+bool kho_test_pages_preserved(phys_addr_t phys, unsigned long nr_pages)
+{
+	struct kho_radix_tree *tree = &kho_out.radix_tree;
+	unsigned long pfn = PHYS_PFN(phys);
+	unsigned long end_pfn;
+	unsigned int order;
+
+	end_pfn = pfn + nr_pages;
+	while (pfn < end_pfn) {
+		order = __kho_preserve_pages_order(pfn, end_pfn);
+
+		if (!_kho_is_pfn_preserved(tree, pfn, order))
+			return false;
+
+		pfn += 1 << order;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(kho_test_pages_preserved);
+#endif
-- 
2.54.0.746.g67dd491aae-goog


