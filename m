Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB8CCE8D76
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ihe0loas1LrTsn9bRuxuUBOFUFQUEsXdHcA1ZYhZ3IY=; b=Q8y6xWXUy5NBAB3L04JD6tdaPh
	UeN7BFwQ0iV2W3o1j5bZnIIeH0zSio8iekMlNg0qL9FMGdUnd8tVkpYlxqEsGe39Ee5CmtM4PNkKT
	7XP/Wj687nEP+xQ3kTNv0MYg4CCmjszQgeDo8nrsbKSfTsttXnSkYDNkacT3X35gYh5LyJHH9nkln
	OgzZyWkoNKHllYjmRvbDd4bSVPC+bHUM0OLrFJl7AAoHzGErvl0u0bJjwo2pRBLv2dJWIPW57NPBF
	It4w1UApbKneAzEP8EYBO8WZJPuYusQdgDMx5j4PuLi0+9zfL3sXJUrt4uA7kghw5R7x0gsOyVGgy
	02h0iyNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1t-0000000CzOF-1U9j;
	Fri, 14 Nov 2025 19:00:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1q-0000000CzMB-3uzE
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=Ihe0loas1LrTsn9bRuxuUBOFUFQUEsXdHcA1ZYhZ3IY=; b=o2u/J8H8F6DREhiFMEP5OtnhdZ
	oDyx06gHUBbmySj5ghFF3MYkb26rN1VtqjuefkoElWrQN8PH6yuW5YZK4P3EIyjiQBQRaYQ0mUYf9
	Iabsb/A4RjrXsn07oS9QYEQn/rn37t+/Bo6/zLoejurBt1Wpg+D72Brz02mXxF3tONLvj4ncqWLds
	IW7Fx9BH5OppDQbFyeS6EzWkv/1LrFsiA67B1guGBy8fgNLlLH1vVF1kNfHz47+Jv3/pbNTkaY1CC
	MDrLbYSiif68KQlnBycbuAv0Mz32x6unIF+sJrQ6aXQ1WTyDKoe36MqpHnkqA7rKOtOSS8siWbmaq
	DgD+twaA==;
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyA9-00000003Jmv-2XGZ
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:47 +0000
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-63bc1aeb427so2104584d50.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146810; x=1763751610; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ihe0loas1LrTsn9bRuxuUBOFUFQUEsXdHcA1ZYhZ3IY=;
        b=D0U2r+9/LcfbP4jDiprWMY7l6Bfn3dD+oosq5dE7D4sMcySVtetKFDCojaETDBkAx+
         3B9lvjxlRTOVQtpgnCJV7sLI2I8DsD39eXtsVYjqTI5vSDldSY6Gg05Hk0pD/MG2G2Ez
         RysWginkonn48u7BuVTV7wn96ge58+s3TxZCPYKT6cneoV3KdPmQ3p2wO6FHQJjGoTv5
         3/QUUhV6DWrL+tSpNsVOR5y5BLMzbwPmoLjbwqpCDxjk8vHdWlIoR/VdsCEk6zKV3b2i
         5CazouRZMJ/rQY0vdKKUJ8d0NNwB2txMIW5hzzdgKPoXzHr6AlwHhbXWOUjGBoyYWHNi
         rMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146810; x=1763751610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ihe0loas1LrTsn9bRuxuUBOFUFQUEsXdHcA1ZYhZ3IY=;
        b=anUZJiSmmGkK6+BPbNfgrvvri4OSLi4AQ1j+nETn40GafcHVHzEPamjGm+3vQ8B1ue
         RL2mqvTVDDr2iruDwpvguez8j+Touqy2d6Xx24OnxkjcUoSvedJ9cQtm7+TyglVGFWtD
         MXNkcMh7qhOy2AWZXlKeAQzYBFE4X2INrJ4BnsbAKpG299tcXOT1gMf7qzjUvwi82z99
         H5CySnCW81HVn7hqut4rKv2khFBe6rUC6PaJTsky9jPmf1mtxPfDeBcH0uSVvUsOw16/
         atdnmWRRKw2tvRYIpRVYcY/TaeORm+7lMhiozRtCAGvJDlyWurMsO2itRATZHaTFuhvs
         m0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp+4yHkd3aj0oMMCasAsGB8W3R8TiY1lN/xWqF/xIZqKn8MHIf6IUOQirCsgEMAxLVO4vntg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzRgGrUTWqE1D0n1lJ7X9sEurRRhMzf5vcTGHyktmPFRM0ncPd
	T3kz0a9dPhEA7WAV6TPDZnzh0b/wvEmeKwodK2bwIb/lbPMS6UJMgslEmTjoOBwhgIg=
X-Gm-Gg: ASbGnct5XhketRaL4owzirmXrJ2W90gzxtNem24GksKlNF0ISeKbDILZipyCDpY4xvt
	WwhcKVFmZSsvDGKWhZNH5oVx934agn7yjtveNvmv4Pb5rwG8IEAacidIEUMSba3uUw4dHROss6x
	zLrR2jtWQCo3EHFWyaPIunANPdMl8ZmWONQGEDIEg6Co/w5h+n6j4qojpjtZPQeXqgH0AOmSMXS
	QyJ0DlI4Ha+E+o8+Q2glo1N25LUbfZ0HggHjlsqxHXzHpEPH2qIkNw11oAZhHdaqXdgM4YB4cVu
	CXA01V6X+HMnIx6St9RroGCJA/TNgUGLP0q6D3Tl4vcTMjSgpA4JSJgGJ2crskIPJI1hkwL5Yxz
	eRA24TgqspPk1L/tE//W6oQtluvcGT2rKPfydWpvo2A1u0/CFyyUfWVvq4/rZvu/0V9SHIfStiX
	nypkiJzCmGi3PKWXXRj4nUeheBoXd+4Wl0QJfsh2YTeqLYu76KaeSeza2lYwdmLbhO9ktoFnuZa
	NYFxKI=
X-Google-Smtp-Source: AGHT+IHtcsADCaRWmb9vZYl521slB2k1TyP9yi6kP/peGKq0p/n4sbxoK2XQz6YSUfgIDyLwv/pwEw==
X-Received: by 2002:a05:690e:23c3:b0:636:563a:6725 with SMTP id 956f58d0204a3-641e7644cefmr2737299d50.49.1763146810418;
        Fri, 14 Nov 2025 11:00:10 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:10 -0800 (PST)
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
Subject: [PATCH v2 03/13] kho: Introduce high-level memory allocation API
Date: Fri, 14 Nov 2025 13:59:52 -0500
Message-ID: <20251114190002.3311679-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180445_742127_6DF35765 
X-CRM114-Status: GOOD (  19.85  )
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
- kho_unpreserve_free(ptr): Unpreserves and frees the memory
  in the current kernel.
- kho_restore_free(ptr): Restores the struct page state of
  preserved memory in the new kernel and immediately frees it to the
  page allocator.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h     | 22 +++++---
 kernel/liveupdate/kexec_handover.c | 87 ++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 80ece4232617..38a9487a1a00 100644
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
+void kho_unpreserve_free(void *mem);
+void kho_restore_free(void *mem);
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
+void kho_unpreserve_free(void *mem) { }
+void kho_restore_free(void *mem) { }
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
index bc7f046a1313..5c5c9c46fe92 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
  * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
  * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
 #define pr_fmt(fmt) "KHO: " fmt
@@ -1117,6 +1118,92 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
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
+ * kho_unpreserve_free - Unpreserve and free memory.
+ * @mem:  Pointer to the memory allocated by kho_alloc_preserve().
+ *
+ * Unregisters the memory from KHO preservation and frees the underlying
+ * pages back to the system. This function should be called to clean up
+ * memory allocated with kho_alloc_preserve().
+ */
+void kho_unpreserve_free(void *mem)
+{
+	struct folio *folio;
+
+	if (!mem)
+		return;
+
+	folio = virt_to_folio(mem);
+	WARN_ON_ONCE(kho_unpreserve_folio(folio));
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_free);
+
+/**
+ * kho_restore_free - Restore and free memory after kexec.
+ * @mem:  Pointer to the memory (in the new kernel's address space)
+ * that was allocated by the old kernel.
+ *
+ * This function is intended to be called in the new kernel (post-kexec)
+ * to take ownership of and free a memory region that was preserved by the
+ * old kernel using kho_alloc_preserve().
+ *
+ * It first restores the pages from KHO (using their physical address)
+ * and then frees the pages back to the new kernel's page allocator.
+ */
+void kho_restore_free(void *mem)
+{
+	struct folio *folio;
+
+	if (!mem)
+		return;
+
+	folio = kho_restore_folio(__pa(mem));
+	if (!WARN_ON(!folio))
+		folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(kho_restore_free);
+
 static void __kho_abort(void)
 {
 	if (kho_out.preserved_mem_map) {
-- 
2.52.0.rc1.455.g30608eb744-goog


