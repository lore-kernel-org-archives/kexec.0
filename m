Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007A1CE8D6F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffjFNwR3lXfHPjG3OmQVmnhwINj2hMoShbrtcOYEMn4=; b=DkGFSGwwLpOX6oxtlDMNGV7CQ6
	jbYFagMYPYsuCoRH4LvJzppPXC0YCp4VmomZ2Gl3mJbz9OwbCbZTe2lh6aYQxLAhH6luAEzfn1Ik9
	Z8E2UJ/7C+ayiiRFUPmswQb/xpY6i/d9vbd1WAdnW1A2OJTS78N6jShTYghUp7aoiyRW+XcSPhfIe
	2Wnnf4Y882I+qjnEIKaoGnPirZzqPENpI/MhdMCJ0OOXbvd3VRSjByWF9IlQZptHezuCCGgneGOzR
	XTpgfAMRtWm+dJ+RY20jYPuz011elLseYTg+00Qvrm3HSC+QyaP19NaSjNRmEfMGr+TZjRT4CMPOr
	WZ1d93sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz22-0000000CzaQ-1X9x;
	Fri, 14 Nov 2025 19:00:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz21-0000000CzYY-1evP
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=ffjFNwR3lXfHPjG3OmQVmnhwINj2hMoShbrtcOYEMn4=; b=MQ4ZW/Nz0kYuBKgXC9AGsh0ss4
	XZQ9t+RyNrnmq37b+TnfB1Mam9S6A4u6FXBfEaFA0ON1tUSAxPqlGc43QQxb9DehXZkJKp+ynJxln
	v5T0OL9lpA2tHP0hNAL7UcbBqqklRCqv0ekZPSAu6v4hyXdpApkf/DIEHFPspVRrQ0dWs34BRpuUG
	SBrYIdTR+8rdKQXZYLhqnnXn0TE2aYIpi878waNmy8UbeQ+4dkPPJh7hQPjWGWi9MAQYZ6TAXyFjf
	qxdXu5JBSnvKbu6UEGwr0jPXGBkhNeULtZ24DegXoVKJBMdPg5LjdX+7JpZX4eTVxq63cLKOkDtt/
	ckynoApQ==;
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyAJ-00000003JqL-17E2
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:57 +0000
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-63e393c4a8aso1864170d50.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146820; x=1763751620; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffjFNwR3lXfHPjG3OmQVmnhwINj2hMoShbrtcOYEMn4=;
        b=RqJer8J4ONUzGzMFzvW+toOmXZRdEFW5NSLBfnK/eg4l6yZc05A4oLnaTGM190dPn1
         JUbJ17fX+zub3n69UL8mAL9bbsVSqCOUjL8GcMbrbIyuN6pxoAIvPEFlPwrZbfvqKjY0
         Q+6ZdjMlvNwbCyydcE4DBvAwstkxiguAOw9NQaCDdTBdIPwQ+DNIvPtHjQRYeFdlLRxk
         pCXw64OIAyzZytQhr7AacUHpC7NIH+mPbRIIk1hbo9PA1GUl17QzVbCx9S36paIB/eqK
         kZ+litf94iw16dT0AgEeVq+DaGfATWz1xqDxQ4JNFldX6vqIQNnCdrjacJcfZTNXSI9N
         eygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146820; x=1763751620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffjFNwR3lXfHPjG3OmQVmnhwINj2hMoShbrtcOYEMn4=;
        b=XrnePuRfNTNXbfp/najndGVeEHM9PBiHPU8huPvX4PM0tJFyxm1ExwWcpjF6nIPWyb
         nOIs0QClhT4d4CBetrc3Hd+P3Jmw5ciztS/4nrgF9Pavaf/A19WRuRGThCgxyqMB+I+q
         tTCnA4qtOPUnr9+n9H8X1UzekXH/MIxRPZEONFi5cY/2BuXYg2l6thcC8HpJ1XHTORM6
         6/0L8/mEDr3SqAMOVxw0zpv7BCtOwRacws5Ww/VZUZvIUzlgB+vD3B7OJj95m5i8Yw81
         Bdi/sUqEUg0MnD83t6a5+yFyB+TfGEOQEUjLBpKwvt8jSYeh+5dbG7ppYYMraJf4WFcL
         78Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUyCiNvKj6r81lQIHga8cEPKUbywG86BMz1qupfzAfmz1uaV1onf3/er3V/rFxLFF4Ky1X/Xw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyezORBez9VrxxwU4jQRhhUi466BJgtT7F69HO+lf0bVz3lqDEX
	j0KSSEdjmed4N+f2iRpm+Pn8nggLCnsIprDQxzs0GdATofCeizV3vCeQHIyxpL5YrfM=
X-Gm-Gg: ASbGncvgRD88H8xvpIRlzm63j0NDaNjeNnRMuywVwltR+nR+v1u2/ds2ExE4EKVJRxe
	AJ8Cn1fqJNAVvdLTbkTODkiqJnOOnpHjmqYuzeu9+r7EkwxYmpRhJOQ7SF3Sgb92DjOs4KqHDpK
	G3BllY1cqghL7LqVxhZpViAEk+UvZftVyiZd1c9veAoAvKuuTEFaa62PfRcOiPVbTKRvSvvK5fY
	VzV9pjhUohxjqmqQbIoMMxUkSbJHB2JIgM7gG20tSCVehR4pCl0wCDXXrfq/OxhTGJV7rNhdLzQ
	tl3QpOvbjGmxp6uWUy/vDCtIn5X27xhJ22BJfR2ddj86SuwREjLyL7AYTO0RjkCmmASBvkHKbkh
	yWKf02eNJbMsrhZ4e1eIL90CS7TONTxOwXeA4fp1HU+79e4mKhrIBnVuZxgS8D45Fb4kMtFkv0V
	NN7paCBg+oKxxWS4ngeEukp/Y8zmubiNNOsGhuHQOG8AvaB0OQDUgXYSDGUsFChaWT3nlg
X-Google-Smtp-Source: AGHT+IHr72sxnwnDW01eveiKOMN8ReuV1UUnXNulAeH1fLWng/AE/xORbhmHjOyCI/0xtighT8mEng==
X-Received: by 2002:a05:690e:1546:20b0:640:e5e1:190e with SMTP id 956f58d0204a3-641e769b270mr3139275d50.57.1763146820114;
        Fri, 14 Nov 2025 11:00:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:19 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 12/13] kho: Allow memory preservation state updates after finalization
Date: Fri, 14 Nov 2025 14:00:01 -0500
Message-ID: <20251114190002.3311679-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180455_407957_B64C8662 
X-CRM114-Status: GOOD (  15.15  )
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

Currently, kho_preserve_* and kho_unpreserve_* return -EBUSY if
KHO is finalized. This enforces a rigid "freeze" on the KHO memory
state.

With the introduction of re-entrant finalization, this restriction is
no longer necessary. Users should be allowed to modify the preservation
set (e.g., adding new pages or freeing old ones) even after an initial
finalization.

The intended workflow for updates is now:
1. Modify state (preserve/unpreserve).
2. Call kho_finalize() again to refresh the serialized metadata.

Remove the kho_out.finalized checks to enable this dynamic behavior.

This also allows to convert kho_unpreserve_* functions to void, as they
do not return any error anymore.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h     | 21 ++++--------
 kernel/liveupdate/kexec_handover.c | 55 +++++++-----------------------
 2 files changed, 19 insertions(+), 57 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 38a9487a1a00..6dd0dcdf0ec1 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -44,11 +44,11 @@ bool kho_is_enabled(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
-int kho_unpreserve_folio(struct folio *folio);
+void kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
-int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
+void kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
-int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
+void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
@@ -79,20 +79,14 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
-static inline int kho_unpreserve_folio(struct folio *folio)
-{
-	return -EOPNOTSUPP;
-}
+static inline void kho_unpreserve_folio(struct folio *folio) { }
 
 static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
-{
-	return -EOPNOTSUPP;
-}
+static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
 
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
@@ -100,10 +94,7 @@ static inline int kho_preserve_vmalloc(void *ptr,
 	return -EOPNOTSUPP;
 }
 
-static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
-{
-	return -EOPNOTSUPP;
-}
+static inline void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation) { }
 
 void *kho_alloc_preserve(size_t size)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4596e67de832..a7f876ece445 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -185,10 +185,6 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	const unsigned long pfn_high = pfn >> order;
 
 	might_sleep();
-
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -807,20 +803,14 @@ EXPORT_SYMBOL_GPL(kho_preserve_folio);
  * Instructs KHO to unpreserve a folio that was preserved by
  * kho_preserve_folio() before. The provided @folio (pfn and order)
  * must exactly match a previously preserved folio.
- *
- * Return: 0 on success, error code on failure
  */
-int kho_unpreserve_folio(struct folio *folio)
+void kho_unpreserve_folio(struct folio *folio)
 {
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	__kho_unpreserve_order(track, pfn, order);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
 
@@ -877,21 +867,14 @@ EXPORT_SYMBOL_GPL(kho_preserve_pages);
  * This must be called with the same @page and @nr_pages as the corresponding
  * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
  * preserved blocks is not supported.
- *
- * Return: 0 on success, error code on failure
  */
-int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+void kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
 {
 	struct kho_mem_track *track = &kho_out.track;
 	const unsigned long start_pfn = page_to_pfn(page);
 	const unsigned long end_pfn = start_pfn + nr_pages;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	__kho_unpreserve(track, start_pfn, end_pfn);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
 
@@ -976,20 +959,6 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
 	}
 }
 
-static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
-{
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
-
-	while (chunk) {
-		struct kho_vmalloc_chunk *tmp = chunk;
-
-		kho_vmalloc_unpreserve_chunk(chunk, kho_vmalloc->order);
-
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		free_page((unsigned long)tmp);
-	}
-}
-
 /**
  * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
  * @ptr: pointer to the area in vmalloc address space
@@ -1051,7 +1020,7 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
 	return 0;
 
 err_free:
-	kho_vmalloc_free_chunks(preservation);
+	kho_unpreserve_vmalloc(preservation);
 	return err;
 }
 EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
@@ -1062,17 +1031,19 @@ EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
  *
  * Instructs KHO to unpreserve the area in vmalloc address space that was
  * previously preserved with kho_preserve_vmalloc().
- *
- * Return: 0 on success, error code on failure
  */
-int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
 {
-	if (kho_out.finalized)
-		return -EBUSY;
+	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
 
-	kho_vmalloc_free_chunks(preservation);
+	while (chunk) {
+		struct kho_vmalloc_chunk *tmp = chunk;
 
-	return 0;
+		kho_vmalloc_unpreserve_chunk(chunk, preservation->order);
+
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		free_page((unsigned long)tmp);
+	}
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
 
@@ -1221,7 +1192,7 @@ void kho_unpreserve_free(void *mem)
 		return;
 
 	folio = virt_to_folio(mem);
-	WARN_ON_ONCE(kho_unpreserve_folio(folio));
+	kho_unpreserve_folio(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_free);
-- 
2.52.0.rc1.455.g30608eb744-goog


