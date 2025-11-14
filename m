Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B435CE8D4A
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Uap8NJrH5Pb6CWLHsw3prb3WSqz01SCPOCj0nxF8f0=; b=ARSCOpti9OIf8iqvgfSQJ2vu/F
	eNhskVDxK01UQ5orIeqJ9BMUP8pn7GTg86uJPMNa0ufb30J6RJjGRyDIMpOb7Tv0KJD/SkNHstsn9
	76GZkduCvArOjmYfJUMz8li130/3ua8+SuR+VwxftTiEB/YviSshgJuYSd8EBmQwwmEwEuQMubEwj
	x0+4+Tf4yELZ7zCdFzIlPsCWpM30O5BSSw3z1Z6hByidinZB7Cvzy5DmrM2ACZecjWXS4IVvqg4FQ
	XbmZNokx0FXgCwpR0/r0b9/S4od0eJ+YqHzXmoCl29M+R1Z/O5CSjTE0wCcxW8Hd2OSM0hxvumJtc
	/cbXhfbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw80-0000000Cczq-1qJX;
	Fri, 14 Nov 2025 15:54:24 +0000
Received: from mail-yw1-f171.google.com ([209.85.128.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7t-0000000Ccqy-23bN
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:20 +0000
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-787e84ceaf7so25406007b3.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135656; x=1763740456; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Uap8NJrH5Pb6CWLHsw3prb3WSqz01SCPOCj0nxF8f0=;
        b=UFXWadKMt1OR0/RnGpIIcPQt30YYiS6k6MmMSpZNRKhKu9sv3gVA14Q+Ao3siGAiqg
         kZmtLRGP+A3UQYEJuGfN6SkC8kNf7UHUdcFfgEcS6frfCO1ckquLfCGzXx79Tlyqmv7p
         CG8DZ9IgEkhrSusHKYV4aPkDn2TGi7MihKbenmbH7LVcrL6CYlNR07zCXl1IoAppR1LI
         ee1ZJzLo8aRZQ/P/u4SxQlA5l/ZPe5grl/YYGKExQQT7FYreYd+MRIZgyi6KCv6UPCs0
         AxdKuKqDPHgOwnaFm3+tKL7IwZvmjRTACoDf/iYBsm0v9O065TkYolLwynq82fH31sem
         H4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135656; x=1763740456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Uap8NJrH5Pb6CWLHsw3prb3WSqz01SCPOCj0nxF8f0=;
        b=DMoJX6SWeng2qHi1FD6DTnHy7XqNiWa54XCtnV6DzEFO5pStjQ3CcB4s1LC1gHJiy8
         YQuogEZ1/FkQ08yHeL0FKHfXi/zU0ynzaDFAEdx44eLwpv5gc2oBaMd6jXkX2mFkTsqO
         OZ/rugRoMfea/3ffPDgwF1nA3jXHl3ZSc3LYrWKtpW619GNQZoCgkhnqQnhknAua6N2P
         Cv1dtGb+afmxxCrfuJtTllknJlYAWEY4UB337Gn8BUJwpRSwGYNB/dVkvdscfOuVQLGI
         RsLvrbAsVvS/Do1+S2EPs7iAbRhbAjfeIW3bNFGENfExGN9zMpSq2n+AQNV9btNIJoCY
         9bmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW98gPh+V1k03rOjNqlJ220XY4ETBOhtRi2DdlmFEyyI/C2sMGFMLswOncoA8LrD8hC+KQShA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKPErPCTVaP0GK84oWIXV4Q2UY3qGLzq+IIwVjF4qcFq8BCoXn
	iLkvN8xtNgp0bc8cR6I9jg9TJlyM9ZqbTLhfm20pO4bCOpvRTbi0JH+uleVXLVuXpMc=
X-Gm-Gg: ASbGnctFooeoOSDKVMf3TOelHgZQfbjwjLClFvNZHzDnSAc0xlvmO6ZnpZcvf+Hx+HF
	DJMdD9YeEGKaQBRSgmSeDFKF4wzSEeYmAOnoUTu+cMSn0k8XuZ5Qjzkz7esXgidP3EtJmQAc1YQ
	IFjs9S0yE2kao5+FF0oFDW7QW+GRxKOVar3dcsPdrAOB0XpOjdZKkaivXSbUqv1+t/aUbglpMUS
	WKI6uBFzMKD6SnDNBvrDZUB/c+GJeRpImcDqq02jURwb17RSqcsLvktXfnpcmfvej311SGNqAdi
	WNMOj584MczWHoq5jd9hv7Awv+JT3iZONR3kdGnxo4gDbuKF9nO9RuItBhTV55V3UKP4OIAOagV
	FopEkT6HmIt23uc0ZScHAZERrJtHkfdsm8RZZwlAHITe0/VSFmlTdSgcS5It/2p1933U80m3uFM
	dOO0xCpfJfJnEgcLvQHf54WBe6VWslwzJwqZK5q0m2rMwmlK6in8Gy8qRUtMd1+FZChmJl
X-Google-Smtp-Source: AGHT+IHNxNYIjWa6M85ng5fm7KdMGmaCp0p2DckarVLQ1uVdBIpVIya/6LO6pSDb2OyOlRX9dHvrhw==
X-Received: by 2002:a05:690c:5a14:b0:787:deea:1baf with SMTP id 00721157ae682-78929f16b28mr27160997b3.52.1763135656118;
        Fri, 14 Nov 2025 07:54:16 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:15 -0800 (PST)
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
Subject: [PATCH v1 13/13] kho: Introduce high-level memory allocation API
Date: Fri, 14 Nov 2025 10:53:58 -0500
Message-ID: <20251114155358.2884014-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075419_272236_B3F3CE5E 
X-CRM114-Status: GOOD (  20.40  )
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

Currently, clients of KHO must manually allocate memory (e.g., via
alloc_pages), calculate the page order, and explicitly call
kho_preserve_folio(). Similarly, cleanup requires separate calls to
unpreserve and free the memory.

Introduce a high-level API to streamline this common pattern:

- kho_alloc_preserve(size): Allocates physically contiguous, zeroed
  memory and immediately marks it for preservation.
- kho_free_unpreserve(ptr, size): Unpreserves and frees the memory
  in the current kernel.
- kho_free_restore(ptr, size): Restores the struct page state of
  preserved memory in the new kernel and immediately frees it to the
  page allocator.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h     |  22 +++++--
 kernel/liveupdate/kexec_handover.c | 101 +++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 80ece4232617..76c496e01877 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -2,8 +2,9 @@
 #ifndef LINUX_KEXEC_HANDOVER_H
 #define LINUX_KEXEC_HANDOVER_H
 
-#include <linux/types.h>
+#include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/types.h>
 
 struct kho_scratch {
 	phys_addr_t addr;
@@ -48,6 +49,9 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages);
 int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
+void *kho_alloc_preserve(size_t size);
+void kho_free_unpreserve(void *mem, size_t size);
+void kho_free_restore(void *mem, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
@@ -101,6 +105,14 @@ static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
 	return -EOPNOTSUPP;
 }
 
+void *kho_alloc_preserve(size_t size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+void kho_free_unpreserve(void *mem, size_t size) { }
+void kho_free_restore(void *mem, size_t size) { }
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
@@ -122,18 +134,14 @@ static inline int kho_add_subtree(const char *name, void *fdt)
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_remove_subtree(void *fdt)
-{
-}
+static inline void kho_remove_subtree(void *fdt) { }
 
 static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_memory_init(void)
-{
-}
+static inline void kho_memory_init(void) { }
 
 static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a905bccf5f65..9f05849fd68e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
  * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
  * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
 #define pr_fmt(fmt) "KHO: " fmt
@@ -1151,6 +1152,106 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
+/**
+ * kho_alloc_preserve - Allocate, zero, and preserve memory.
+ * @size: The number of bytes to allocate.
+ *
+ * Allocates a physically contiguous block of zeroed pages that is large
+ * enough to hold @size bytes. The allocated memory is then registered with
+ * KHO for preservation across a kexec.
+ *
+ * Note: The actual allocated size will be rounded up to the nearest
+ * power-of-two page boundary.
+ *
+ * @return A virtual pointer to the allocated and preserved memory on success,
+ * or an ERR_PTR() encoded error on failure.
+ */
+void *kho_alloc_preserve(size_t size)
+{
+	struct folio *folio;
+	int order, ret;
+
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	order = get_order(size);
+	if (order > MAX_PAGE_ORDER)
+		return ERR_PTR(-E2BIG);
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kho_preserve_folio(folio);
+	if (ret) {
+		folio_put(folio);
+		return ERR_PTR(ret);
+	}
+
+	return folio_address(folio);
+}
+EXPORT_SYMBOL_GPL(kho_alloc_preserve);
+
+/**
+ * kho_free_unpreserve - Unpreserve and free memory.
+ * @mem:  Pointer to the memory allocated by kho_alloc_preserve().
+ * @size: The original size requested during allocation. This is used to
+ *        recalculate the correct order for freeing the pages.
+ *
+ * Unregisters the memory from KHO preservation and frees the underlying
+ * pages back to the system. This function should be called to clean up
+ * memory allocated with kho_alloc_preserve().
+ */
+void kho_free_unpreserve(void *mem, size_t size)
+{
+	struct folio *folio;
+	unsigned int order;
+
+	if (!mem || !size)
+		return;
+
+	order = get_order(size);
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
+		return;
+
+	folio = virt_to_folio(mem);
+	WARN_ON_ONCE(kho_unpreserve_folio(folio));
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(kho_free_unpreserve);
+
+/**
+ * kho_free_restore - Restore and free memory after kexec.
+ * @mem:  Pointer to the memory (in the new kernel's address space)
+ * that was allocated by the old kernel.
+ * @size: The original size requested during allocation. This is used to
+ * recalculate the correct order for freeing the pages.
+ *
+ * This function is intended to be called in the new kernel (post-kexec)
+ * to take ownership of and free a memory region that was preserved by the
+ * old kernel using kho_alloc_preserve().
+ *
+ * It first restores the pages from KHO (using their physical address)
+ * and then frees the pages back to the new kernel's page allocator.
+ */
+void kho_free_restore(void *mem, size_t size)
+{
+	struct folio *folio;
+	unsigned int order;
+
+	if (!mem || !size)
+		return;
+
+	order = get_order(size);
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
+		return;
+
+	folio = kho_restore_folio(__pa(mem));
+	if (!WARN_ON(!folio))
+		free_pages((unsigned long)mem, order);
+}
+EXPORT_SYMBOL_GPL(kho_free_restore);
+
 int kho_finalize(void)
 {
 	int ret;
-- 
2.52.0.rc1.455.g30608eb744-goog


