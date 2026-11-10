Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C7606E4B9
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sMw/q8qT;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PZjXcPdt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=; b=sMw/q8qThVGtoml9pYmzQmyklK
	vtFJzyeazWYdpwa4l3bfOxTxgEvi3PcAHVT7ZIRti614eDleX2Jaaa9Hp2q80Yn5p7YyKWMX/eorV
	ZsKPrzSFu1JgTnPRTREQCzUPSXFUN88To+Ae+dqyvuvhYVwh4j3NFxLBaMfFWQHMRuXa+U7LvFehe
	SOZehXP4Tc5O37bJ33W1lb+Z94juKi37WFDWHUYKjJ/eCkOOO8KNSa8vP+cjbOxfq/4AE/cmK+IoO
	YXp5oxzON16pXrK6TpB156Xc5BqQre82Y0lJkXVnJYUAqtsYxWJUb9qYwvKSIk1GWWbsEh5I8SUqH
	k05ZhGfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe02-00000002Rbs-3YHP;
	Tue, 10 Nov 2026 05:02:26 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzq-00000002RHg-2Jp2
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:17 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c3f04e0e481so77175566b.1
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286932; x=1794891732; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
        b=PZjXcPdtFk/aauNMpDGXn+Est/QaraQoCX80W3zcqf8MX3u1wvaDOeReasisWdeaRM
         s5zYBmLcgYUDtkS1OFOfuBjxgdYd1FMh0Meg01TDaqUWYD/rKz3CAVlCfgRvAwlM1R7g
         xqhjUc9h/Q918HLApfMSZ6r8eFXrbquciOv4zte24B2h3drtgXuFaaKz0GV5chGgJvuQ
         qf3I4m5+jSANP8kK1MKpBsECw+MuEpKsnl4L441V/l3HM4gvXttgttdDVxIdYyqAYMys
         TWq/r49mEFBzJsIoZ8dQi3poOQzUiTfG/s6VCAH5tSjPIWQ/0bfLt1tsPccR15FDTfGl
         8/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286932; x=1794891732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
        b=DXz23JSv70ckeY8lOERSf8LKaVhC0/Qj3VViU7Nv/b0X0tvnJjG6GLhFQbuoadctad
         9Or+fNzkcqe1MtdAIlzZRZwdXKtZ2g/01VC6GekYIvSgWMAmIsxqIYP66kdNvdHvkrz/
         5axeyaIo7Htd0CxNjaRpqHZdFDaTpglnOzvw06fNMtzRy1OZNrH5uX2i2el04l963DgT
         D2kTPBTvp77GrAeVkYl8cNNjrOR61DNqVXORoRF6WqVx5IiJhZVspuSCwQM6OhUDSliq
         mr4xj+aCU87eFSMrf3/q89uHXS/E1EPm92AZhSJT/Bk3H7Pd65VW1fxk+qEsIHJHXrSB
         UYTg==
X-Forwarded-Encrypted: i=1; AL+hErEz5jUg0tKoRsJBd4bSfpVHlzIAV4rXadkwQYdN0KbPCUE0W0JrHmflmBCHp0HVhCQFbUcoGA==@lists.infradead.org
X-Gm-Message-State: APuU4Z91F1afC8banZsGC0eKIW/HBZZfsOozp0Ogpm/2M/uNoP/8GGSy
	Rpqz2iemxb8tbCyCCHLMLc3p0m4RIAwOJx/Y6rl/vyVNzKfOs/4TmgWHcRTezMu27L3RZb0IQ7t
	z6ydc/6j/PKdnwlKxsg==
X-Received: from ejbwr20.prod.google.com ([2002:a17:907:7014:b0:c3f:b33c:8124])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f0d:b0:c2e:4a61:d436 with SMTP id a640c23a62f3a-c50495d6ee1mr114117566b.36.1794286931810;
 Mon, 09 Nov 2026 21:02:11 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:49 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-7-tarunsahu@google.com>
Subject: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
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
X-CRM114-CacheID: sfid-20261109_210214_653997_4DCA28B7 
X-CRM114-Status: GOOD (  20.20  )
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

The kexec metadata subtree currently uses a monolithic u32 version field
to identify the metadata structure layout. Any change to the structure,
even an optional additive field, requires incrementing the version and
breaks compatibility between adjacent kernels.

Replace the u32 version field in struct kho_kexec_metadata with
struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
under new feature indices without breaking compatibility across kexec.
Also make the 3-byte padding hole between previous_release and kexec_count
explicit as reserved[3].

During deserialization, validate the blob size against the header size
and reject unknown required features. A legacy v1 metadata blob is
ignored with a warning.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_metadata.h | 17 +++++++-----
 kernel/liveupdate/kexec_handover.c     | 38 ++++++++++++++------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
index e9e3f7e38a7c..316b3e5ad01b 100644
--- a/include/linux/kho/abi/kexec_metadata.h
+++ b/include/linux/kho/abi/kexec_metadata.h
@@ -18,28 +18,31 @@
 #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
 #define _LINUX_KHO_ABI_KEXEC_METADATA_H
 
+#include <linux/build_bug.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/types.h>
 #include <linux/utsname.h>
 
-#define KHO_KEXEC_METADATA_VERSION 1
-
 /**
  * struct kho_kexec_metadata - Kexec metadata passed between kernels
- * @version: ABI version of this struct (must be first field)
  * @previous_release: Kernel version string that initiated the kexec
+ * @reserved: Reserved for structure alignment; must be zero
  * @kexec_count: Number of kexec boots since last cold boot
  *
- * This structure is preserved across kexec and allows the new kernel to
+ * This structure is preserved across kexec and allows the target kernel to
  * identify which kernel it was booted from and how many kexec reboots
- * have occurred.
+ * have occurred. Preceded by &struct kho_ser_hdr.
  *
  * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
  */
 struct kho_kexec_metadata {
-	u32 version;
 	char previous_release[__NEW_UTS_LEN + 1];
+	u8 reserved[3];
 	u32 kexec_count;
-} __packed;
+} __aligned(8);
+
+/* Register kho_kexec_metadata with KHO serialization accessors */
+DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
 
 #define KHO_METADATA_NODE_NAME "kexec-metadata"
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4b1d173d48ff..641a3b4c88fb 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1762,6 +1762,7 @@ static __init int kho_out_fdt_setup(void)
 
 static void __init kho_in_kexec_metadata(void)
 {
+	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
 	struct kho_kexec_metadata *metadata;
 	phys_addr_t metadata_phys;
 	size_t blob_size;
@@ -1773,27 +1774,28 @@ static void __init kho_in_kexec_metadata(void)
 		/* This is fine, previous kernel didn't export metadata */
 		return;
 
-	/* Check that, at least, "version" is present */
-	if (blob_size < sizeof(u32)) {
+	if (blob_size < sizeof(*fhdr)) {
 		pr_warn("kexec-metadata blob too small (%zu bytes)\n",
 			blob_size);
 		return;
 	}
 
-	metadata = phys_to_virt(metadata_phys);
-
-	if (metadata->version != KHO_KEXEC_METADATA_VERSION) {
-		pr_warn("kexec-metadata version %u not supported (expected %u)\n",
-			metadata->version, KHO_KEXEC_METADATA_VERSION);
+	fhdr = phys_to_virt(metadata_phys);
+	if (fhdr->size != blob_size) {
+		pr_warn("kexec-metadata size invalid (%u != %zu), ignoring metadata\n",
+			fhdr->size, blob_size);
 		return;
 	}
 
-	if (blob_size < sizeof(*metadata)) {
-		pr_warn("kexec-metadata blob too small for v%u (%zu < %zu)\n",
-			metadata->version, blob_size, sizeof(*metadata));
+	err = kho_ser_validate(fhdr, kho_kexec_metadata);
+	if (err) {
+		pr_warn("kexec-metadata feature validation failed: %pe\n",
+			ERR_PTR(err));
 		return;
 	}
 
+	metadata = kho_ser_payload(fhdr, kho_kexec_metadata);
+
 	/*
 	 * Copy data to the kernel structure that will persist during
 	 * kernel lifetime.
@@ -1813,23 +1815,25 @@ static void __init kho_in_kexec_metadata(void)
  */
 static __init int kho_out_kexec_metadata(void)
 {
+	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
 	struct kho_kexec_metadata *metadata;
 	int err;
 
-	metadata = kho_alloc_preserve(sizeof(*metadata));
-	if (IS_ERR(metadata))
-		return PTR_ERR(metadata);
+	fhdr = kho_alloc_preserve(kho_ser_size(kho_kexec_metadata));
+	if (IS_ERR(fhdr))
+		return PTR_ERR(fhdr);
+	kho_ser_init(fhdr, kho_kexec_metadata);
 
-	metadata->version = KHO_KEXEC_METADATA_VERSION;
+	metadata = kho_ser_payload(fhdr, kho_kexec_metadata);
 	strscpy(metadata->previous_release, init_uts_ns.name.release,
 		sizeof(metadata->previous_release));
+	memset(metadata->reserved, 0, sizeof(metadata->reserved));
 	/* kho_in.kexec_count is set to 0 on cold boot */
 	metadata->kexec_count = kho_in.kexec_count + 1;
 
-	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata,
-			      sizeof(*metadata));
+	err = kho_add_subtree(KHO_METADATA_NODE_NAME, fhdr, fhdr->size);
 	if (err)
-		kho_unpreserve_free(metadata);
+		kho_unpreserve_free(fhdr);
 
 	return err;
 }
-- 
2.56.0.506.g506a7eabc5-goog


