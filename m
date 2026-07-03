Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2583DC43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 02:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R42hNae76A7CXiYkYtHihW2CvpPOkdd31plc72X+MXE=; b=wkzajXz/3rstG5xrR6NVWzUHKd
	vUs6ppIWwx8A3RXRSlUs32fZHdXgrPItwTjGy+QNSlU7ekdnQwH62SuuLv0mAyYmNGQFnGQTGvVj8
	4pDLWRTuxib8mnSk05AF7LoHz44Hp1/V08AwYmomaPL3eP7FpPw79Hlo2HCRzrqQvrgnJKPFkKOKz
	ypV0cp55/pCkV7Jh4sHtMeLe+LlQ8tNwVd+sAIGF02FhAqsLEbhVl82vIe/HXUR5Xj65EHAzUvppF
	jlOQPnxJF8zrXFVpbl9ExLrD+btmUZdtuxvOQ5M/itX2anZ1PhVMuJONZQVBCNq00CkyQY4+ed7Ag
	uiOZN8Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKh-00000005rpV-2HTP;
	Fri, 03 Jul 2026 02:08:47 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKf-00000005rnY-3k3G
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 02:08:46 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-847ac21582cso87991b3a.2
        for <kexec@lists.infradead.org>; Thu, 02 Jul 2026 19:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783044525; x=1783649325; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R42hNae76A7CXiYkYtHihW2CvpPOkdd31plc72X+MXE=;
        b=V5uQYVzzk+AWSO0kBmxal4HGKpQhi1jgXgRLUSxGYEda/rksytdl05zx02Crw5U6xu
         bXayyFMJYehrainP8YqBRTr5bHiliIscE0le04mk4k+XmsKLtfN8JkySkpME8QUuO0fO
         YjaSu4CsTl5ofuCmLfcDaRb1TJEME0vjjmI+iNiOn2EFZdTiWJY5JVb0Fy+f6ZAJ5DOf
         7FWwxzLFU363PFp5GnjA1uI6qiJl0BsCnF1ycr7Jw5XHIULPiUfyLC9ZlF7IugKiY9Xs
         qu/q09hQjUveKZoz/plUdTVohospNNR9PKwA214Vi/WeWQmvZcbp5ib8XLP+iWad+Cgq
         /tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044525; x=1783649325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R42hNae76A7CXiYkYtHihW2CvpPOkdd31plc72X+MXE=;
        b=PTkCMF2DLw3TYePKOhFQyEocQ444M3kwAgPcNPgOE8LX0KeBzQFhwOeMw3wp3IHl58
         6AM6HjH7pHkTIYkqumgZtSmiVbHZO629yjY5AtMtgdodGkaP1zJw190mxWrUfEBCjwJ3
         BMcMVKj/9Muwi6cCnkRMiRaZq8lYp5AXAERY9Y0FohsUPRBpJ/B7rnx/Tzj9LgVAiDkm
         o/YqADP4DbZdgoSG8XKdVnhdmeOgii4I0j3PB/+HwgH+zHl5J73oRsVZDTQNDT3XoKU4
         GJpreqRH5UKXTuR7IyESQyTlC+JOjWdxxaEMWYxW6CfgCBy0BaeJO6nmV1oL2uIpueLh
         WqTA==
X-Forwarded-Encrypted: i=1; AFNElJ/wXHQfP3l0S3Swz2nCZAKV+nFlreJs7MRIbjq0EzIrAdUhkbuvDyvqN5l1rPbiOpeOytMX9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmBLDVS4FZLkfxDBpFEL5Rc43PM35rVgGiwBO8htvJaSn/+sBX
	Y13F/fgIkPaRB4iqdFJzW3w2tbI4DE/x7RCu51CTlAHiIbcS5PnZVt5h1dMrYYe8scYAvc2OpFL
	n1Q==
X-Received: from pfcg5.prod.google.com ([2002:a05:6a00:23c5:b0:847:92f6:92e1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2918:b0:845:c373:6525
 with SMTP id d2e1a72fcca58-847c09344f7mr8276323b3a.41.1783044524457; Thu, 02
 Jul 2026 19:08:44 -0700 (PDT)
Date: Fri,  3 Jul 2026 02:08:32 +0000
In-Reply-To: <20260703020832.1731864-1-praan@google.com>
Mime-Version: 1.0
References: <20260703020832.1731864-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703020832.1731864-5-praan@google.com>
Subject: [RFC PATCH 4/4] kho: Introduce kho_split_preserved_pages() helper
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_190845_936476_E2442FD3 
X-CRM114-Status: GOOD (  13.76  )
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

A driver may need to split a high-order allocation that has already
been preserved. If the pages are split using split_page() manually,
the refcounts would change but KHO won't record the change in the
preserved page-type, resulting in a metadata mismatch during
restoration in the new kernel.

Introduce kho_split_preserved_pages() to handle splitting of preserved
pages. The helper follows an unpreserve -> split -> re-preserve sequence,
while ensuring that the KHO radix tree is updated with the correct
KHO_PAGE_SPLIT type bits.

The helper returns 0 on success, or a negative error code if the
re-preservation fails. Callers must ensure the provided order matches
the original allocation and that the operation is serialized against
other preservation API calls.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/kexec_handover.h     |  7 +++++++
 kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..452e38bb2076 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -24,6 +24,7 @@ int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned long nr_pages);
 void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
+int kho_split_preserved_pages(struct page *page, unsigned int order);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 void *kho_alloc_preserve(size_t size);
@@ -65,6 +66,12 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 
 static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
 
+static inline int kho_split_preserved_pages(struct page *page,
+					    unsigned int order)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index f6ca5e24c740..ea08248901b5 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1018,6 +1018,29 @@ void kho_unpreserve_pages(struct page *page, unsigned long nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
 
+/**
+ * kho_split_preserved_pages - split contiguous pages that are preserved
+ * @page: first page in the list.
+ * @order: the order of the original allocation.
+ *
+ * This function allows to split a high-order allocation that has been
+ * preserved across kexec. It unpreserves the pages, splits them using
+ * split_page() and then re-preserves them as individual pages.
+ *
+ * This function MUST only be called on pages that are currently preserved.
+ * The @order provided MUST match the order used during the initial
+ * preservation.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int kho_split_preserved_pages(struct page *page, unsigned int order)
+{
+	kho_unpreserve_pages(page, 1UL << order);
+	split_page(page, order);
+	return kho_preserve_pages(page, 1UL << order);
+}
+EXPORT_SYMBOL_GPL(kho_split_preserved_pages);
+
 /* vmalloc flags KHO supports */
 #define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


