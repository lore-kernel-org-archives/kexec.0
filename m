Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD69606A333
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xTORbmGS;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=FNjChv5s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6x1S3ZqdbkxHt3USof+znmMvAt7VbtHwbOPxHgeUp/E=; b=xTORbmGSKEciBo
	xzmNysEU8IKnz3BXUjYmYFzpQDQCgK0TOdYB58PrcRijcGoW24LolZuYceJK2WrMtRnKMciJFfT5D
	3TkEIeqrOZiOfkNmLCrtMhY7e1Yj/pk4PfVqMRx9XFTBt9opJmYpSY/TojmtBVKwFYgmMnGVsWxqn
	3LVXJJ7/Eyf6l+N3DUrv05EOEeK0pkjBYQFTd0lN72XMtrQChh++jpMbfJP1DBptEWaKLNsjMnmCR
	dC6Mg0sz8h+dZGRfnfE1vlQ32QEFVOwQhub4PTVewr77mbOi4HWv7jCIEWNOflEtXMjjrgeCbtEeN
	4yG+nvSXNYbiklLTykzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cq-00000001Euj-0GH6;
	Sun, 25 Oct 2026 17:40:28 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cn-00000001Eqp-1roO
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:26 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5eb14d0837fso1669919e0c.3
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950024; x=1793554824; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6x1S3ZqdbkxHt3USof+znmMvAt7VbtHwbOPxHgeUp/E=;
        b=FNjChv5sjErTdTJh+5zrO3spFkMSYA8sNIHce/J8yb6ycXBcriRZumtbP0gZrRS5Rv
         UCdqgbKC31ELFph94IgwsjZdFuzMgnLKoIGREz/sNjtRzTukJXu4EveZG3PjArJoH5Gr
         EMHKfUiKa94x17mJWBc777r6OVefvR9TxoCm17r39jUSdEmM2qQWLVMxyxPuYGNLykQU
         GG/c5CS/dhNe5uVEJG8cVmdWjDeCtj92aRTjsJYRcU1r5OOTpEaIqHSY2cUauKvgBeTX
         q24pP0+pTU0x9IOWKVws37KlfGhpU0teKXcIAj5YtRnLRF2xIj2f5vcwVYVjFlefxyvN
         trbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950024; x=1793554824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6x1S3ZqdbkxHt3USof+znmMvAt7VbtHwbOPxHgeUp/E=;
        b=N9vPT95IXGSN2zMMakOvkpwdTlsyPsCDynL5VoE2BqOXgINQ+tdNKAnKo+FdjjZqf9
         pcxZOerpRtvL+Vy8KCiQmSyr2MDfc+zDM5UhpWNj9odA1Ntg+1lq9WWp700Cm7IUB/Yy
         ZhtwgJwqQbL8obO3GxDZlJiCjNOJyytSEitcFuJpwd5PWAtKLifd0F8PRfxoXjKs0oYD
         WkwstBepJ8ZH3FxAv9+M+bTEDK/7xustqcN2ptTuKYYsFUmg2K65bHtjMwO5fEGh7pe8
         LLOTwYuiwInSHcFH9IvfrJq0IK4p/HO20Zdd64s11QUKdAC5FYMt03TaRvvL2vcnyYmz
         2fcw==
X-Forwarded-Encrypted: i=1; AKwUvBzqh3cHvx59YEN3cVOhLHxZbOoV9cMDA1nxfsV9MYI64Ouk396dHUKb49zT842y7Qlf+UV/fw==@lists.infradead.org
X-Gm-Message-State: AFq9FYI2YIqBLoqCtAx82lCp2C+v7fk5UN+sc38GmQLnRWw70SPBzJgw
	4xPYX99YT2DcfVqXsv/9C26g5atOndCazD8Njplgqa0xj4AhVJ3peqW/tJaScu6erhs=
X-Gm-Gg: AYBFou0d2fU0qWbfRjJLlcHVjNw8Ef1RHjY4p0mBRy0xr+dMayuomd3yHp4zMCxNc4+
	EIblAR292gyjE6YJbPfCNGXgUXIFsmeos/Qz/95/b8zEY1UxngE+jJ9ruDYuQbD99M24syr9Eeo
	3jqye7G0b1JAlZ9CTBrhQFnO1jxUP72Hym6IrWpQtZCBtTeVIDdm+pSRsXpc5YNb/XJh8XvQ3jy
	BWzYjYrvWBPm0azFAWuQ9GBUe23vS6s3l+qItAcu+9lQoWDKgQCll8x9j4wMOtoj6/xk2ifuzdU
	H9BJlaNyM7D8JV7ZJFWrXn7zDLNoKuY1thCnEEotaRoQT1Rwaj/tyZRvokPqTrNMgEEcKaT7j4l
	Iq7Iv99xgaFJjI9BGm++v0xNN1SIFCwHMtd1LIGcqFSwE+WsRu70H7ovGVRQn+9W1hbl8u3NYrf
	lKtjNEALAUFRZb/GMuk4ndb/Up6BTAEQTNIGDaXpFpbAuabSy3MLW0RBbAA84L1TmQKtqDqEIn9
	iivfZnKOyW5BMoxjqMqdhYDNvFsxAI7sbDDVsiS0eVZFKA4ofTTJk8Nk865QIyXwogEIq7gO8Cq
	W4FaHfGzA6GjCaGyq2cxI3fj1/NOXS0CRVVuv5R0X7tgmhvIh9duhtq8w8EtIz1xlumyR0genX1
	kyVPVDXFxfN1HDmKKAY4xxQE=
X-Received: by 2002:a05:6122:21a9:b0:5ea:d5ff:3bc5 with SMTP id 71dfb90a1353d-5ec2309e769mr1605074e0c.2.1792950024405;
        Sun, 25 Oct 2026 10:40:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:24 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 3/9] kho: validate preservation metadata in kho_restore_vmalloc()
Date: Sun, 25 Oct 2026 13:40:10 -0400
Message-ID: <20261025174017.3870481-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104025_508025_0EF56441 
X-CRM114-Status: GOOD (  19.88  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho_restore_vmalloc() currently dereferences preservation before
checking for NULL, does not reject unknown KHO vmalloc flags, and does
not validate preservation->first.phys, preservation->total_pages, or
preservation->order before allocating the pages array and shifting by
order.

Move kho_flags_to_vmalloc() to kexec_handover_common.c and introduce
kho_vmalloc_validate() and kho_vmalloc_walk() so both regular KHO and
the upcoming read-only KHO mode can share vmalloc header validation and
chunk-list traversal. Converting kho_restore_vmalloc() to
kho_vmalloc_walk() also restores each chunk page before reading its
contents and rejects non-terminal chunks that are not completely full.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c          | 99 ++++++++++-----------
 kernel/liveupdate/kexec_handover_common.c   | 87 ++++++++++++++++++
 kernel/liveupdate/kexec_handover_internal.h | 14 +++
 3 files changed, 150 insertions(+), 50 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index c24f25bfc96a..67efbdd39439 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1204,10 +1204,6 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
 /* vmalloc flags KHO supports */
 #define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
 
-/* KHO internal flags for vmalloc preservations */
-#define KHO_VMALLOC_ALLOC	0x0001
-#define KHO_VMALLOC_HUGE_VMAP	0x0002
-
 static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
 {
 	unsigned short kho_flags = 0;
@@ -1220,18 +1216,6 @@ static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
 	return kho_flags;
 }
 
-static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
-{
-	unsigned int vm_flags = 0;
-
-	if (kho_flags & KHO_VMALLOC_ALLOC)
-		vm_flags |= VM_ALLOC;
-	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
-		vm_flags |= VM_ALLOW_HUGE_VMAP;
-
-	return vm_flags;
-}
-
 static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
 {
 	struct kho_vmalloc_chunk *chunk;
@@ -1357,6 +1341,45 @@ void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
 
+struct kho_vmalloc_restore_ctx {
+	struct page **pages;
+	unsigned long contig_pages;
+	unsigned long idx;
+};
+
+static const struct kho_vmalloc_chunk *kho_get_chunk(phys_addr_t pa)
+{
+	struct page *page = kho_restore_pages(pa, 1);
+
+	return page ? page_to_virt(page) : NULL;
+}
+
+static void kho_put_chunk(const struct kho_vmalloc_chunk *chunk)
+{
+	free_page((unsigned long)chunk);
+}
+
+static int kho_vmalloc_restore_entry(phys_addr_t pa, void *priv)
+{
+	struct kho_vmalloc_restore_ctx *ctx = priv;
+	struct page *page;
+
+	page = kho_restore_pages(pa, ctx->contig_pages);
+	if (!page)
+		return -EINVAL;
+
+	for (unsigned long j = 0; j < ctx->contig_pages; j++)
+		ctx->pages[ctx->idx++] = page + j;
+
+	return 0;
+}
+
+static const struct kho_vmalloc_walk_ops kho_vmalloc_restore_ops = {
+	.get_chunk = kho_get_chunk,
+	.put_chunk = kho_put_chunk,
+	.entry = kho_vmalloc_restore_entry,
+};
+
 /**
  * kho_restore_vmalloc - recreates and populates an area in vmalloc address
  * space from the preserved memory.
@@ -1369,18 +1392,16 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
  */
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 {
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_PROT_NORMAL;
-	unsigned int align, order, shift, vm_flags;
-	unsigned long total_pages, contig_pages;
+	struct kho_vmalloc_restore_ctx ctx;
+	unsigned long total_pages, align;
+	unsigned int order, shift, vm_flags;
 	unsigned long addr, size;
 	struct vm_struct *area;
 	struct page **pages;
-	unsigned int idx = 0;
 	int err;
 
-	vm_flags = kho_flags_to_vmalloc(preservation->flags);
-	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+	if (!kho_vmalloc_validate(preservation, &vm_flags))
 		return NULL;
 
 	total_pages = preservation->total_pages;
@@ -1388,37 +1409,15 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	if (!pages)
 		return NULL;
 	order = preservation->order;
-	contig_pages = (1 << order);
 	shift = PAGE_SHIFT + order;
-	align = 1 << shift;
-
-	while (chunk) {
-		struct page *page;
+	align = 1UL << shift;
 
-		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
-			phys_addr_t phys = chunk->phys[i];
-
-			if (idx + contig_pages > total_pages)
-				goto err_free_pages_array;
-
-			page = kho_restore_pages(phys, contig_pages);
-			if (!page)
-				goto err_free_pages_array;
-
-			for (int j = 0; j < contig_pages; j++)
-				pages[idx++] = page + j;
-
-			phys += contig_pages * PAGE_SIZE;
-		}
-
-		page = kho_restore_pages(virt_to_phys(chunk), 1);
-		if (!page)
-			goto err_free_pages_array;
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		__free_page(page);
-	}
+	ctx = (struct kho_vmalloc_restore_ctx){
+		.pages = pages,
+		.contig_pages = 1UL << order,
+	};
 
-	if (idx != total_pages)
+	if (kho_vmalloc_walk(preservation, &kho_vmalloc_restore_ops, &ctx))
 		goto err_free_pages_array;
 
 	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
diff --git a/kernel/liveupdate/kexec_handover_common.c b/kernel/liveupdate/kexec_handover_common.c
index f2784f5c523c..dc25cb4c08af 100644
--- a/kernel/liveupdate/kexec_handover_common.c
+++ b/kernel/liveupdate/kexec_handover_common.c
@@ -19,9 +19,96 @@
 #include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
+#include <linux/vmalloc.h>
 
 #include "kexec_handover_internal.h"
 
+static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
+{
+	unsigned int vm_flags = 0;
+
+	if (kho_flags & KHO_VMALLOC_ALLOC)
+		vm_flags |= VM_ALLOC;
+	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
+		vm_flags |= VM_ALLOW_HUGE_VMAP;
+
+	return vm_flags;
+}
+
+bool kho_vmalloc_validate(const struct kho_vmalloc *preservation,
+			  unsigned int *vm_flags)
+{
+	if (!preservation || !preservation->first.phys ||
+	    !PAGE_ALIGNED(preservation->first.phys) ||
+	    !preservation->total_pages)
+		return false;
+
+	if (preservation->order >= BITS_PER_LONG - PAGE_SHIFT ||
+	    (1UL << preservation->order) > preservation->total_pages ||
+	    !IS_ALIGNED(preservation->total_pages, 1UL << preservation->order))
+		return false;
+
+	if (preservation->flags & ~(KHO_VMALLOC_ALLOC | KHO_VMALLOC_HUGE_VMAP))
+		return false;
+
+	*vm_flags = kho_flags_to_vmalloc(preservation->flags);
+	return true;
+}
+
+/**
+ * kho_vmalloc_walk - Walk the chunk list of a preserved vmalloc region.
+ * @preservation: Validated KHO vmalloc preservation metadata.
+ * @ops:          Callbacks to acquire/release chunks and process each entry.
+ * @priv:         Caller context passed to @ops->entry.
+ *
+ * Traverses the linked list of struct kho_vmalloc_chunk pages starting from
+ * @preservation->first.phys, invoking @ops->entry for each contiguous physical
+ * range and verifying that non-terminal chunks are full and that the total
+ * number of pages matches @preservation->total_pages.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int kho_vmalloc_walk(const struct kho_vmalloc *preservation,
+		     const struct kho_vmalloc_walk_ops *ops, void *priv)
+{
+	unsigned long contig_pages = 1UL << preservation->order;
+	unsigned long total_pages = preservation->total_pages;
+	unsigned long nr_pages = 0;
+	phys_addr_t chunk_pa;
+
+	for (chunk_pa = preservation->first.phys; chunk_pa; ) {
+		const struct kho_vmalloc_chunk *chunk;
+		phys_addr_t next_pa;
+		unsigned int i;
+
+		chunk = ops->get_chunk(chunk_pa);
+		if (!chunk)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
+			if (nr_pages + contig_pages > total_pages ||
+			    ops->entry(chunk->phys[i], priv))
+				goto err_put_chunk;
+
+			nr_pages += contig_pages;
+		}
+
+		next_pa = chunk->hdr.next.phys;
+		if (next_pa && i < ARRAY_SIZE(chunk->phys))
+			goto err_put_chunk;
+
+		ops->put_chunk(chunk);
+		chunk_pa = next_pa;
+		continue;
+
+err_put_chunk:
+		ops->put_chunk(chunk);
+		return -EINVAL;
+	}
+
+	return nr_pages == total_pages ? 0 : -EINVAL;
+}
+
 /**
  * kho_encode_radix_key - Encodes a physical address and order into a radix key.
  * @phys: The physical address of the page.
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index e73a2e310917..dd79e5006562 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -8,7 +8,21 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/* KHO internal flags for vmalloc preservations */
+#define KHO_VMALLOC_ALLOC	0x0001
+#define KHO_VMALLOC_HUGE_VMAP	0x0002
+
+struct kho_vmalloc_walk_ops {
+	const struct kho_vmalloc_chunk *(*get_chunk)(phys_addr_t pa);
+	void (*put_chunk)(const struct kho_vmalloc_chunk *chunk);
+	int (*entry)(phys_addr_t pa, void *priv);
+};
+
 const void *kho_get_fdt(void);
+bool kho_vmalloc_validate(const struct kho_vmalloc *preservation,
+			  unsigned int *vm_flags);
+int kho_vmalloc_walk(const struct kho_vmalloc *preservation,
+		     const struct kho_vmalloc_walk_ops *ops, void *priv);
 unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order);
 phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order);
 unsigned long kho_radix_get_bitmap_index(unsigned long key);
-- 
2.56.0.307.g5fe7bd680c-goog


