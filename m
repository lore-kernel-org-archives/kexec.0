Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE466CD4F3F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hm3N3CUlxXRBXqf7e3XiIHtpRuBL112Zzp/Y6lHhCj8=; b=sUmI6CyNskMyUCtsBmQxcQwUrk
	fkoEP1PosrJOaBVFCXeAp4up2p/8y9Xwj1YIe1SzCbzH5Z8Eyp2TO6iT1fgWcc0rW+L8Q2CelSfH3
	hS6MT+ZtCuMUpt5/RfT+S4yiYTXhf/VM+wN7xYfs7IP+5eFk/PBAvEABlUnbMAPeAUS1ev3uzkf7K
	771oM8ZofwtnpNiOHvj6llauUWxIByaucp+U9krxOQSj/4hh4Ii1cUgx/krW5FfQCMuLkJ7J9/Ik6
	f0S4Di6U2yd6ybOrBhmU43oJ+ldbqrRAI8OBRBg5CiLBMWMu+QXpK6K6X6tEWLeXtu1hcDAjkIrl4
	GeHILq+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8n-00000000GhY-22VS;
	Tue, 12 May 2026 19:51:41 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8k-00000000Gg1-40SF
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 19:51:40 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8386367b23cso4608904b3a.3
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778615498; x=1779220298; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm3N3CUlxXRBXqf7e3XiIHtpRuBL112Zzp/Y6lHhCj8=;
        b=NMTC3JN5CLu9qGySSyBhlWL5S05fy9bLvpiUfQQskhMTqkSzD1A0EYi9kxG5E6VvHJ
         9JNfhNiZ/AMv60WT30oIgS7e4efYTED4WZu2vKu2F488VgRp5JCyEL8zB8Whx42rV1um
         BDScxZwscV6KOqthcNEBHkh/Q6ScqqlRYSshuXRret3znI/h3YvSPWyMNsKhUHukQGvh
         SV+/YRZkDuofhdAk0rpmXQrC32ON11omEyh4boRGfxRtzFuAATYkSYn/kua4BuEG2DAb
         OzLoH9oHDfjiHQ+2c85KJhom89+GlxRNHa2Sq5Ax8H+BEaB7jmEWBh8r6g7RTnb3ZRGS
         0E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778615498; x=1779220298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm3N3CUlxXRBXqf7e3XiIHtpRuBL112Zzp/Y6lHhCj8=;
        b=RuBtYLp10pKvMbxcSqAu4Ucb8UgaDjepOdFM7TmrXpSon8Wr4FQHlSbd0mrn047mS3
         x2PfCbvZ48lSPfXq3guQm+yYiYMt49NCetRpZO3hBa3PJy2gHrKjnd6m/rP6HMqbFyMf
         7jc5l8g1KruIYmdKA5yTLa5a+g9YHoNgJGdeIAPCb4WqUlYH52uE7ser9bSW/OUEMiGK
         MhThDq5sdnGt6v9v2tME5LBhrpJs3cujkGHnnz+x7RXevlIQxgQ6h6w3zGy7CDz/mp+i
         01/TqplsCU4GG2QOQ76PaIhCm7myBfBxTspKRzXefddrgkzhpQv0sA75bYI7HqvFjRbl
         89Kw==
X-Forwarded-Encrypted: i=1; AFNElJ8El1h7tS27kf/42fg8qafxZSx1LepJR52mV/kRjma12aIklNRY7+T4UKhWtdC9HcCWfnjC5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YycVUgYoAKoKeNayMB6UuD3Tbt3Uo2nv8yiEFMzX45Dc2bqMKzP
	hzJ/BU6RfPFb54S11eWw9j7TMB2cyHBkC4SE4CNnwYa35CJT2822u8Ja8SN6QfvESO3QMLWhsRL
	FbtRRk+kfw79h1A==
X-Received: from pfbdu16.prod.google.com ([2002:a05:6a00:2b50:b0:82f:9778:a429])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a254:b0:82f:2226:5aeb with SMTP id d2e1a72fcca58-83f03fe5b91mr112295b3a.20.1778615497372;
 Tue, 12 May 2026 12:51:37 -0700 (PDT)
Date: Tue, 12 May 2026 19:51:34 +0000
In-Reply-To: <20260512195135.804833-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260512195135.804833-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512195135.804833-3-skhawaja@google.com>
Subject: [PATCH 2/3] kho: Add helper function to check if pages are preserved
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_125138_994841_A00A7039 
X-CRM114-Status: GOOD (  12.44  )
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
 kernel/liveupdate/kexec_handover.c | 52 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

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
index 1375291d9b07..f678372b3e81 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -12,6 +12,7 @@
 
 #include <linux/cleanup.h>
 #include <kunit/static_stub.h>
+#include <kunit/visibility.h>
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
@@ -1771,3 +1772,54 @@ int kho_locate_mem_hole(struct kexec_buf *kbuf,
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
+
+#if IS_ENABLED(CONFIG_KUNIT)
+static bool _kho_is_pfn_preserved(struct kho_radix_tree *tree,
+				  unsigned long pfn, unsigned int order)
+{
+	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
+	struct kho_radix_node *node = tree->root;
+	struct kho_radix_leaf *leaf;
+	unsigned int i, idx;
+
+	if (!tree->root)
+		return false;
+
+	guard(mutex)(&tree->lock);
+
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
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
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
2.54.0.563.g4f69b47b94-goog


