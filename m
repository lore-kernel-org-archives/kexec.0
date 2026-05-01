Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC23BCCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owhGFFGkj/MfzHZLNOkioxRyYPGExMvDZLhrjI6gPS0=; b=JqUL4oIcJFd+S8U7hdKkRKdnvl
	S2I9W3fSzXHUqqzxQyNmGDHEGcuP8mbvufHfiMZLL0Sgq6qAx1cerHb0uSj8lrtUopbvpdJrs8AH9
	0y/+2gCjgY8WXSKFomKMco11Cy4ku4LtMJpheH12bqJQIzDTgctL5YGR2ROvT2i8o8yGHx4zxJvjc
	fcK+eTBcL5q+8lwkGE2sejnW5PUw8Vz6D8Ls1CxNtsaHnwlgZhKgqDn7zpqGVCASZHFXnjmk2u1cI
	tooAqldiuWKFkfpBnqN2QtA9cNY3asbonh3m4BfAAzpiRrpdSiLB3j58As+WcE7TN86UXURBOoN8c
	6Ai7qdHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIri7-00000007Vil-09O8;
	Fri, 01 May 2026 17:31:31 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIri4-00000007Vho-1Dsu
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 17:31:29 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so1399262a91.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656687; x=1778261487; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owhGFFGkj/MfzHZLNOkioxRyYPGExMvDZLhrjI6gPS0=;
        b=jqh/QkGmnUeTwj1UUp8rR25ExXexC6nUkhU5HDm5yTUQXQI2cElfocb8KEJhmJI/7m
         qq+Jl2PI9AZeWIOmzMPWWV9zZCbVGazWQhltAsCyggGaJurRQZE/9IQsxGnxWnT4Qe7V
         0LEdHIPAXxFVj89YGqkX8W2sZpYpgiLQamr9PGlmxkHe6JMo5v0r11xj72mf2g/Ma4YO
         vB73V8+dZAY15Z4Ihf6e8W+ncLnTcR3ZNfGhGfb2TIFKr96K9wh2hJDQnocysC04bCIT
         9mw2IDk/tRJn+IOaTnMWAbXvl4Yzy74S67Fg6iCSrLwu4/RIPwD61eYLZLeGDiEmHXfh
         9HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656687; x=1778261487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owhGFFGkj/MfzHZLNOkioxRyYPGExMvDZLhrjI6gPS0=;
        b=neKLil/aNbpbdtf4rLnxBr77sGhpm9BT4UUYAt8hQZiUeAO7881mAFjd/mf2dmnQzP
         DCyIbX6oTpnue0F3sYJFh/Hlt2Gp2ZGrVIVn5wj6pZom8bk/dK+WS99SkF2uWeDu3P0o
         dNlm8SKjAOAxxoxtKBRDh/co0Jbgv15GSy1shnq0QOQUQF8eDXLWh/fHmYxftq8n3/9L
         RmHxAG+WyLv3KVoUtxJJ8+UDt2w/FKUHd6pJ0WimuwQtMN6a6WQENR6c/SxVtfB/B3o8
         9e4G6CZ3kvDAxm8wlCc4K/0spv0lQU9khrLUB2ku1PWepq1IfskxGtGTBm4CAHszMliz
         HO0A==
X-Forwarded-Encrypted: i=1; AFNElJ+elHqFz0Mhn6PqXhGGjYivQrO049gyBktewcfkOJa22wP+tuZ12rH+hIurs8gyUEeHvup2Mw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+NOzPAlUlJT3EjdmS2i3nCI/wXSaS+VpW7TUDmhAAMTUGHsqA
	mCoDbfPCocsxsm9uHuKO42udvLXEM6bMX0AIfEgSE/YmStkxeJ4uNHXQ
X-Gm-Gg: AeBDieuBd6I9iIPjBF0usPeTnLo0Z4NZFugH+iyV54frqV9YcEnMvRnMCif6aNfNhfY
	kpKaKJLtt8aE7IgzVgzp056cg6jH+em20Fc/Sr+zO+Opr0j5gpcRTdIHIZ8g0HhI5nF56dHkSPW
	5v4VWphnnIjDZ39jTCdgprcfM6HJFxV9K9UT0lFlr0DRqVcGyGmBvnvstiY/5KdlrV9CCnfujw5
	w+uqIHjpgJNTDV3SmuemnWrv8D5hdOQcS1ozr+f+HeXgjNhglW/yzfJ39n5Xl+7xrJYymHWaCoA
	FVa3pYn8zusLRFC4F1ASsKfKvvCyOZWO3zLUVVWJMosRMwWGkhOPOgKZwiUCaKV7aXV0+PeBhj8
	qSHO982Pw9GjYFp6B+kOpVgpTq2OZ2sxLOX3n65OGjPgY9JfxRUNobgK2gNVt7PIa2CcQfG+SCK
	ejJyvwnQRztMfbYJrWV82OHjzE2EOZNgc3EQdbqA==
X-Received: by 2002:a17:903:2f46:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2b9f260d8acmr1445365ad.25.1777656687121;
        Fri, 01 May 2026 10:31:27 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:15cc:43cd:8af9:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2459sm27094895ad.33.2026.05.01.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:26 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] kexec: handover: add helper to check preserved page ranges
Date: Sat,  2 May 2026 01:30:49 +0800
Message-ID: <20260501173053.73116-2-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_103128_449361_96CD39C3 
X-CRM114-Status: GOOD (  14.57  )
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

Restore code should not use phys_to_virt() on physical addresses from
restored metadata until it verifies that the range was preserved by KHO.

Add kho_is_preserved() so callers can check a preserved page range without
restoring, freeing, or taking ownership of the pages.

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 include/linux/kexec_handover.h     |  6 +++++
 kernel/liveupdate/kexec_handover.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..fb09943ab232 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -19,6 +19,7 @@ struct page;
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 bool is_kho_boot(void);
+bool kho_is_preserved(phys_addr_t phys, unsigned long nr_pages);
 
 int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
@@ -51,6 +52,11 @@ static inline bool is_kho_boot(void)
 	return false;
 }
 
+static inline bool kho_is_preserved(phys_addr_t phys, unsigned long nr_pages)
+{
+	return false;
+}
+
 static inline int kho_preserve_folio(struct folio *folio)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94762de1fe5f..fe9f11190705 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
@@ -429,6 +430,40 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	return page;
 }
 
+/**
+ * kho_is_preserved - Verify that a physical page range belongs to KHO.
+ * @phys: physical address of the first page in the range.
+ * @nr_pages: number of pages that the caller expects to access.
+ *
+ * Use this before phys_to_virt() when a physical address comes from restored
+ * metadata. It checks that @phys starts a KHO-preserved allocation large
+ * enough to cover @nr_pages.
+ *
+ * This only checks the KHO marker. It does not restore, free, or take
+ * ownership of the pages.
+ *
+ * Return: true if @phys starts a preserved KHO allocation large enough to cover
+ * @nr_pages, false otherwise.
+ */
+bool kho_is_preserved(phys_addr_t phys, unsigned long nr_pages)
+{
+	struct page *page;
+	union kho_page_info info;
+
+	if (!nr_pages || !IS_ALIGNED(phys, PAGE_SIZE))
+		return false;
+
+	page = pfn_to_online_page(PHYS_PFN(phys));
+	if (!page)
+		return false;
+
+	info.page_private = page->private;
+	if (info.magic != KHO_PAGE_MAGIC || info.order >= BITS_PER_LONG)
+		return false;
+
+	return nr_pages <= BIT(info.order);
+}
+
 /**
  * kho_restore_folio - recreates the folio from the preserved memory.
  * @phys: physical address of the folio.
-- 
2.53.0


