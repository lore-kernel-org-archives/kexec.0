Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FF606A31C
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tLY3pBpt;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pyvxl3u/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=; b=tLY3pBpt2FXuxMDJ6YUZ8z2wRE
	PEoP6wS2csl3SgfGthsAFrb1lVuwmf0oiozimvz+xR3E2IKrUIaIeXNFLv41I0BLlacdLG70C2HPC
	fK48LW23PAixZ56Z4ssZbPWdzG+EMwb2jXqBy7+bw9D5MFbxnua24MRuSG5Ur8cvHH1vo3K2f4jdD
	K10CVaoeF6ACeUNso++kTS/37Lz/Qi4PxCG6DRQmeuwkLWvf/WYMjXpjDLY8kA3mIfFoTKJFmkx+t
	wuIrErUwlGghk59nT5Eyla+4pDBEaWh0RBAp+HfGAvKE3HHFZSfqQanvEO8TTygvwh6ZdpwXs8R+v
	7H4wFTjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe0b-00000002Skr-4BFx;
	Tue, 10 Nov 2026 05:03:02 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe03-00000002Rb8-2itY
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:36 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6b570bd4817so1659969a12.1
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286946; x=1794891746; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
        b=Pyvxl3u/wSqQFoeUkbfjl1jyiSmyMjuGIK0qSyq5IWFbyadua4d8CY+NOrTMraRi2V
         Tg7Y5HcG9znUvGH2kgr+DoeqMS2b1qXP8M3DQqkj6T3aCtYhWnH+pq/HmZ0rGeLYr/B6
         3J4qgGUc8Cx61qrt1E0oQ+QKcG48zlmBxu201UsWXC+hTRolbTdh6Np6SRzbpGcwxpYl
         9EZ5RcftMHLXJ5wzSVEj98X6C2QRbS6gT88qGqa9yoMi9dD9lsOdkOxvGtmIopCMDCB5
         YM21IFzz9D64ZX3Gz1pzX6kdBTvVrd6ujQ+pcWZkNPWMqYmaonVt3h3AAX+FKqRbyA9e
         P+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286946; x=1794891746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
        b=E3HTX12EzE0Nnx2enkedUciLmferZoOfc2351JgFa/g1WslmimEjD+qAvhiG1KA7Fy
         Lraw4yIV3pH+GMNoGqalqW4uaTvvSwM+vwdMold50NP9TyjCqGe0GfPNfdiveoGdq+ZT
         qG914u05OYBM/rPEBC+9sZwcQfx+7A2Z9rvlxJ/0jXORoJ9tqurHE2aUSwa3a0xl7uTk
         ilJtjUwrhLR/SP0aNrDREVOAEOXXmbFT6Z/HZrGzq2C1LZqTO8NtpMQJWipFemeTsKdx
         D1aD/b9vTOvRuHAja2H6PsG7KbB3jSLZ8vFX7byV25unAe6kSNZU6hyGX6BAXkaMaP8W
         prcg==
X-Forwarded-Encrypted: i=1; AL+hErHon8uincz+bEwUAtqLN3MHA/jM7m+f8sQf0pMExs+6rxnlECgbqSWrpdsySW3zVwYPbyd9KA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8wCvCbvRfH2oJx3P//irtazr0ucNibG0iAgfIvabWiefMHIwKE
	8UgIfo4EDl8JbS9QrC08gfgQaDNrDnkX037dhPWneeHHZlmoc82ZAAO0M40F4S7gR/ufBNW2Ron
	TjSryaCREocqlH7HyYw==
X-Received: from edqu26.prod.google.com ([2002:aa7:d89a:0:b0:6b7:37e3:4968])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2422:b0:6b7:dc8:c824 with SMTP id 4fb4d7f45d1cf-6b756b08c35mr1192059a12.42.1794286944980;
 Mon, 09 Nov 2026 21:02:24 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:01 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-19-tarunsahu@google.com>
Subject: [PATCH v4 18/19] mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210227_830028_54538C7F 
X-CRM114-Status: GOOD (  18.55  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Precede each serialized folio entry in the preserved memfd folio array
with struct kho_ser_hdr via DECLARE_KHO_SER so future per-folio memfd
features can append fields to struct memfd_luo_folio_ser without breaking
compatibility between adjacent kernels.

Allocate the preserved folio array using kho_ser_size(memfd_luo_folio_ser)
per entry and initialize each entry feature header in
memfd_luo_preserve_folios(). On the incoming path in
memfd_luo_discard_folios() and memfd_luo_retrieve_folios(), validate each
entry feature header with kho_ser_validate() and advance between entries
using fhdr->size so entries written with a different feature layout are
traversed accurately.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h |  6 ++--
 mm/memfd_luo.c                | 66 +++++++++++++++++++++++++----------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 27f8880ee593..1aad47ce7322 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -51,6 +51,8 @@
  * @pfn:       The page frame number of the folio.
  * @flags:     Flags to describe the state of the folio.
  * @index:     The page offset (pgoff_t) of the folio within the original file.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct memfd_luo_folio_ser {
 	u64 pfn:52;
@@ -58,9 +60,7 @@ struct memfd_luo_folio_ser {
 	u64 index;
 };
 
-static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct memfd_luo_folio_ser) == 8);
+DECLARE_KHO_SER(memfd_luo_folio_ser, 16, 0, 0);
 
 /*
  * The set of seals this version supports preserving. If support for any new
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 94510f73a606..c00daa8a508e 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -86,10 +86,10 @@
 
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct memfd_luo_ser *ser,
-				     struct memfd_luo_folio_ser **out_folios_ser)
+				     DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, **out_folios_ser))
 {
 	struct inode *inode = file_inode(file);
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	unsigned int max_folios;
 	long i, size, nr_pinned;
 	struct folio **folios;
@@ -138,14 +138,16 @@ static int memfd_luo_preserve_folios(struct file *file,
 	}
 	nr_folios = nr_pinned;
 
-	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
+	folios_ser = vcalloc(nr_folios, kho_ser_size(memfd_luo_folio_ser));
 	if (!folios_ser) {
 		err = -ENOMEM;
 		goto err_unpin;
 	}
 
 	for (i = 0; i < nr_folios; i++) {
-		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =
+			(void *)folios_ser + i * kho_ser_size(memfd_luo_folio_ser);
+		struct memfd_luo_folio_ser *pfolio;
 		struct folio *folio = folios[i];
 
 		err = kho_preserve_folio(folio);
@@ -195,6 +197,8 @@ static int memfd_luo_preserve_folios(struct file *file,
 
 		folio_unlock(folio);
 
+		kho_ser_init(fhdr, memfd_luo_folio_ser);
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		pfolio->pfn = folio_pfn(folio);
 		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
 		pfolio->index = folio->index;
@@ -228,7 +232,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 }
 
 static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr),
-					struct memfd_luo_folio_ser *folios_ser,
+					const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 					u64 nr_folios)
 {
 	long i;
@@ -239,7 +243,10 @@ static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios
 	kho_unpreserve_vmalloc(folios_fhdr);
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =
+			(const void *)folios_ser + i * kho_ser_size(memfd_luo_folio_ser);
+		const struct memfd_luo_folio_ser *pfolio =
+			kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		struct folio *folio;
 
 		if (!pfolio->pfn)
@@ -277,7 +284,7 @@ memfd_luo_ser_init(DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr))
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	int err = 0, seals;
@@ -384,16 +391,23 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 }
 
-static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
+static void memfd_luo_discard_folios(const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 				     u64 nr_folios)
 {
+	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) = folios_ser;
 	u64 i;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	for (i = 0; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		struct folio *folio;
 		phys_addr_t phys;
 
+		if (kho_ser_validate(fhdr, memfd_luo_folio_ser)) {
+			pr_warn("invalid folio feature header, folios not discarded\n");
+			return;
+		}
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -411,7 +425,7 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
@@ -447,9 +461,10 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 }
 
 static int memfd_luo_retrieve_folios(struct file *file,
-				     struct memfd_luo_folio_ser *folios_ser,
+				     const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 				     u64 nr_folios)
 {
+	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) = folios_ser;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -457,12 +472,20 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	int err = -EIO;
 	long i;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	for (i = 0; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		phys_addr_t phys;
 		u64 index;
 		int flags;
 
+		err = kho_ser_validate(fhdr, memfd_luo_folio_ser);
+		if (err) {
+			pr_err("memfd_luo_folio_ser feature validation failed: %pe\n",
+			       ERR_PTR(err));
+			goto put_folios;
+		}
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -472,7 +495,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			pr_err("Unable to restore folio at physical address: %llx\n",
 			       phys);
 			err = -EIO;
-			goto put_folios;
+			goto next_put_folios;
 		}
 		index = pfolio->index;
 		flags = pfolio->flags;
@@ -524,15 +547,22 @@ static int memfd_luo_retrieve_folios(struct file *file,
 unlock_folio:
 	folio_unlock(folio);
 	folio_put(folio);
+next_put_folios:
+	i++;
+	fhdr = (const void *)fhdr + fhdr->size;
 put_folios:
 	/*
 	 * Note: don't free the folios already added to the file. They will be
 	 * freed when the file is freed. Free the ones not added yet here.
 	 */
-	for (long j = i + 1; j < nr_folios; j++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+	for (; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		phys_addr_t phys;
 
+		if (kho_ser_validate(fhdr, memfd_luo_folio_ser))
+			break;
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -549,7 +579,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	struct file *file;
-- 
2.56.0.506.g506a7eabc5-goog


