Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B960A5BE3
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nkq1c9eM;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EEXW/BWt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gCVasoLTZkfDLPIf3+UIMM+CIyIOn5HRothnXhPkfvs=; b=Nkq1c9eMVMtXtXV01bCtwrSmF9
	frF/p9EmeX19skj5Xgro7ZjeDj3syL7YchcUMbk3/HzLHna/dGmtMck3NekOH3CBACJBORNIFXM1q
	12dg7BTO5tzwbVdnSIklSFsw02FhD15Uus9ok/8MxcdbqKp8Ru2IPhsFGTepyWwdoExy7aojTW8Qd
	wTOXyelm/g+i0Li38VO5d8sDNO+Gpgfw2/oZ2sjB8eKGArX+iNBMyau3GcQdm42yge22WhY80bMkp
	qCx6fhmg5LRkJO3AwKCTgY6oafysOP7ZLKyjNUmJdTf0DAxFIXpPSVR+syNJu/05J0Q4Kc4SVDGzG
	1CDvV/kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzo-00000002RHW-30D1;
	Tue, 10 Nov 2026 05:02:12 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzl-00000002RDI-2hJi
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:11 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c4322d31021so170411266b.3
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286928; x=1794891728; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCVasoLTZkfDLPIf3+UIMM+CIyIOn5HRothnXhPkfvs=;
        b=EEXW/BWtxz5unu5ApGgePovvwiig6zggJPKT4vZdQ6EZjGaT0EMEIvwz3y2YsbxhON
         t3pGWBW6PdkPLltTcB6jQlg7DxETuSgv33wSY5SKuELURSOoKXoQa1lj7maKzdjXSMTi
         eGqDSTpIDbqIq35POT2lEe0Tep+6qQ/aeYoySpD/pJ9UT0dQbcgbKlBFWGtS3gfa9s5u
         0fZOh7PlTrBtM+LdPxevK7oxH8ByolSbt3Nc1PuDn+23ZqUCmhTAOK1PoILrtdVs2rUq
         c/yFyNyIzflYZNWgihDveGw5qzJLHbB+9fv6wGfL03S9cvOPqpWE1hMY8ZMJqjTDlr+r
         TCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286928; x=1794891728;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCVasoLTZkfDLPIf3+UIMM+CIyIOn5HRothnXhPkfvs=;
        b=IZeg319ovvafEaQQ7JQ4mYhRrrmPlvpQjpR1qK9rgTuCVqDW1zXC30lRWoDeTLPzyL
         5hTOZJjq+Gti2tZOR3theQGmk0ElQeJTHjqZ7LyQxinmwxzPglo9b9YRuApLWMaCcDcC
         oZtxBfM9sr9m3aIgTTnOtl1E4U2/zuAgvneyk6c9UJ/31XW/D6/NLIWI3agkeUeJ63ej
         CP2uymv8w2d2+VYYRkPXPOFDuiBw6FFylqj+xpB4dZ3K+nWof5oxgphWcKR+FveaFg4S
         xIQIkDjfJJVAKU+5aHqqGpQ6zygAJVtkz4ai9ENygicBdDga4e5e/jOJ4rWuq06WHuvv
         Moyw==
X-Forwarded-Encrypted: i=1; AL+hErHZFmG42kuhhkvbgPGvjbeRClGRuI2tHfqNC3rAyThKc7VmkN6u+qaXipMdk+lmRMUYtlL9Ow==@lists.infradead.org
X-Gm-Message-State: APuU4Z+wCDsNvTicSonn1RUI6hYXR/hCopgSNhcECwbe5M+FjXofJvTr
	wWmLUxwVs0pRV47ln7hiQNOsPZMdGBWa98cEzlRFsmTttffOulQXZkQcVUVjaUjh481k6nJUzZu
	uNTls2xAOvZvldWZbzw==
X-Received: from ejzl18.prod.google.com ([2002:a17:906:a412:b0:c4d:1fbc:e718])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3dac:b0:c31:5bb8:4b3b with SMTP id a640c23a62f3a-c5048f79e02mr108053466b.2.1794286927522;
 Mon, 09 Nov 2026 21:02:07 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:45 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-3-tarunsahu@google.com>
Subject: [PATCH v4 02/19] kho: block: Record the entry size in the block header
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
X-CRM114-CacheID: sfid-20261109_210209_727375_D3822B6A 
X-CRM114-Status: GOOD (  27.93  )
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

Subsystems using the KHO Serialization Blocks framework currently do
not record the serialized entry size in the block header. The entry size
is only known to individual callers, which must track and store it in an
owning serialized data structure. If a newer source kernel adds fields
to an entry, the changed entry size breaks the stride when an older
target kernel iterates over blocks.

Add an entry_size field to struct kho_block_header_ser. On the outgoing
side, record bs->entry_size into every block header during allocation.
During restoration, derive the entry stride directly from the block
header instead of relying on caller-supplied dimensions. The
kho_block_set_init() interface remains unchanged. A zero entry size,
or one that differs between blocks of a set, is rejected during
restoration.

This change modifies the serialized layout of struct kho_block_header_ser
and shifts the offset of serialized entries within preserved blocks.
Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
kernels cleanly reject mismatched handover state during boot. Also
update the stale compatible string example in the documentation.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/block.h          | 10 ++++----
 include/linux/kho/abi/kexec_handover.h |  6 ++---
 kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
index 36bdbaf9b3b8..a40b0906c821 100644
--- a/include/linux/kho/abi/block.h
+++ b/include/linux/kho/abi/block.h
@@ -40,9 +40,10 @@
 
 /**
  * struct kho_block_header_ser - Header for the serialized data block.
- * @next:  Physical address of the next struct kho_block_header_ser.
- * @count: The number of entries that immediately follow this header in the
- *         memory block.
+ * @next:       Physical address of the next struct kho_block_header_ser.
+ * @count:      The number of entries that immediately follow this header in the
+ *              memory block.
+ * @entry_size: The size in bytes of each serialized entry in the block.
  *
  * This structure is located at the beginning of a block of physical memory
  * preserved across a kexec. It provides the necessary metadata to interpret
@@ -51,9 +52,10 @@
 struct kho_block_header_ser {
 	u64 next;
 	u64 count;
+	u64 entry_size;
 };
 
-static_assert(sizeof(struct kho_block_header_ser) == 16);
+static_assert(sizeof(struct kho_block_header_ser) == 24);
 static_assert(!IS_ENABLED(CONFIG_64BIT) ||
 	      __alignof__(struct kho_block_header_ser) == 8);
 
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 2f4fb9c63942..6f12f5037ea5 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -41,7 +41,7 @@
  *   restore the preserved data.::
  *
  *     / {
- *         compatible = "kho-v3";
+ *         compatible = "kho-v5";
  *
  *         preserved-memory-map = <0x...>;
  *
@@ -62,7 +62,7 @@
  *     };
  *
  *   Root KHO Node (/):
- *     - compatible: "kho-v3"
+ *     - compatible: "kho-v5"
  *
  *       Identifies the overall KHO ABI version.
  *
@@ -90,7 +90,7 @@
  */
 
 /* The compatible string for the KHO FDT root node. */
-#define KHO_FDT_COMPATIBLE "kho-v4"
+#define KHO_FDT_COMPATIBLE "kho-v5"
 
 /* The FDT property for the preserved memory map. */
 #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..9b148009085e 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -16,6 +16,12 @@
  * array of serialized entries. Multiple blocks are linked together via a
  * physical pointer in the header, forming a linked list that can be easily
  * traversed in both the current and the next kernel.
+ *
+ * Each block header also records the size of its entries. A newer kernel may
+ * append fields to an entry, so the kernel that writes a block and the kernel
+ * that reads it can use different entry sizes. The reader steps through the
+ * entries with the recorded size, so every entry is found, and it does not read
+ * beyond the recorded size of an entry.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -110,6 +116,8 @@ static int kho_block_set_grow_one(struct kho_block_set *bs)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
+	ser->entry_size = bs->entry_size;
+
 	err = kho_block_add(bs, ser);
 	if (err) {
 		kho_block_free_ser(bs, ser);
@@ -242,7 +250,8 @@ static bool kho_block_set_is_cyclic(struct kho_block_set *bs)
  *
  * Restores a serialized block set from a given physical address. The caller is
  * responsible for ensuring that the block set @bs has been allocated and
- * initialized prior to calling this function.
+ * initialized prior to calling this function. The entry size and the number
+ * of entries per block are taken from the restored block headers.
  *
  * Return: 0 on success, or a negative errno on failure.
  */
@@ -250,6 +259,7 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
 {
 	struct kho_block_header_ser *ser;
 	u64 next_pa = head_pa;
+	u64 entry_size = 0;
 	int err;
 
 	/* Restored block sets use size from the previous kernel */
@@ -264,8 +274,21 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
 	}
 
 	while (next_pa) {
+		u64 capacity;
+
 		ser = phys_to_virt(next_pa);
-		if (!ser->count || ser->count > bs->count_per_block) {
+		if (!ser->entry_size || (entry_size && ser->entry_size != entry_size)) {
+			pr_warn("Block contains invalid entry size: %llu\n",
+				ser->entry_size);
+			err = -EINVAL;
+			goto err_destroy;
+		}
+		entry_size = ser->entry_size;
+		bs->entry_size = entry_size;
+		capacity = (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
+		bs->count_per_block = capacity;
+
+		if (!ser->count || ser->count > capacity) {
 			pr_warn("Block contains invalid entry count: %llu\n",
 				ser->count);
 			err = -EINVAL;
@@ -370,7 +393,10 @@ void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
  * @it: The block iterator.
  *
  * Iterates through previously written entries during state deserialization,
- * respecting the actual count stored in each block's header.
+ * respecting the actual count stored in each block's header. Entries are
+ * spaced by the entry size recorded by the kernel that wrote them, which can
+ * be smaller or larger than the caller's structure. Fields beyond that size
+ * are not present in the entry.
  *
  * Return: A pointer to the next serialized entry, or NULL if all serialized
  * entries have been read.
-- 
2.56.0.506.g506a7eabc5-goog


