Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A21CC369D5
	for <kexec@archiver.kernel.org>; Mon, 28 Apr 2025 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c0UvLdnJAnEcldJCrg7fUnvsa2jYd0T46tbsL1Y8DGc=; b=gsVUynPcFyuZ+IhKPI/Q4Cr4hE
	tYPb9nAymOaYjRdXK0iLk/11z1UsuXBbLkG37TAk2U6D6asivLkFFk6wLT/pyJ+fcYhMm+wwxR7U+
	ryxHk0mIC6q7aqPwLb7mjgaomnhoV4GgLCH2xCN9HOOhOcyaNWOaQ2bT8O6jVyEtsoAhGRiu9NdXm
	NpormfzQd4XcCbSwSl1Er7iSS9KVPLT5Tajz5cn7Fdtw/hGfzrIJAtBQdow8WxBmCeq9Ex76rSla8
	AbF4XbFpOsFB7QRp9ByS6tdP7hGbWX/7dw/KQphenmql8kjYApBCRxznqMY4HS/wfyqMp+wGGCKVz
	aEKnx+7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Uf5-00000007PBA-44Y2;
	Mon, 28 Apr 2025 20:01:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Tgm-00000007HPQ-0U6Z
	for kexec@lists.infradead.org;
	Mon, 28 Apr 2025 18:58:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 19DF6614AE;
	Mon, 28 Apr 2025 18:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9430CC4CEE4;
	Mon, 28 Apr 2025 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745866726;
	bh=3VCd8sb9clb1yt3MBURC3qhM+BaPjp5B0hpHooYxT8M=;
	h=From:To:Cc:Subject:Date:From;
	b=ImJr+nYmf6CFo6O6cHaZMXMvIRVbRLuqZg8DKIT+J3rbRD7O6BrbyOBXwP4y1VqBv
	 oGY2sJdEHERB25VZJ3q0wA58HeAdgYuyrkJz82fmKpYQ4NjELfagkkW4sLuoEM3bDT
	 10C0mHmMZsA/OHJ9uCVum1cCUA30qM3IGNaaG87eMZfQhD5JYoQ+w8Q02+DcVQf3uF
	 IvOlSyJwPR3+nodmrgRWqvbWVfcKVXM4rT0BqR8f60+Hkt/JZbEPzIJAI5Mljh9h5R
	 fnihr+SbyTM2oB+BY2cboDMO4XLQe1C+J2q7YRO/AAkYL7FCtnFz4015J2SpPaHSf8
	 ziDx+encDvVQw==
From: Eric Biggers <ebiggers@kernel.org>
To: kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH] kexec_file: use SHA-256 library API instead of crypto_shash API
Date: Mon, 28 Apr 2025 11:57:20 -0700
Message-ID: <20250428185721.844686-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Eric Biggers <ebiggers@google.com>

This user of SHA-256 does not support any other algorithm, so the
crypto_shash abstraction provides no value.  Just use the SHA-256
library API instead, which is much simpler and easier to use.

Tested with '/sbin/kexec --kexec-file-syscall'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

This patch is targeting the mm tree for 6.16.

 kernel/Kconfig.kexec |  3 +-
 kernel/kexec_file.c  | 78 +++++++++-----------------------------------
 2 files changed, 16 insertions(+), 65 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4fa212909d699..7c0d934d0bd76 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -36,12 +36,11 @@ config KEXEC
 	  made.
 
 config KEXEC_FILE
 	bool "Enable kexec file based system call"
 	depends on ARCH_SUPPORTS_KEXEC_FILE
-	select CRYPTO
-	select CRYPTO_SHA256
+	select CRYPTO_LIB_SHA256
 	select KEXEC_CORE
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
 	  for kernel and initramfs as opposed to list of segments as
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 77758c5331229..ac915eabb9014 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -17,11 +17,10 @@
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
 #include <linux/ima.h>
-#include <crypto/hash.h>
 #include <crypto/sha2.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
@@ -723,56 +722,30 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 }
 
 /* Calculate and store the digest of segments */
 static int kexec_calculate_store_digests(struct kimage *image)
 {
-	struct crypto_shash *tfm;
-	struct shash_desc *desc;
+	struct sha256_state state;
 	int ret = 0, i, j, zero_buf_sz, sha_region_sz;
-	size_t desc_size, nullsz;
-	char *digest;
+	size_t nullsz;
+	u8 digest[SHA256_DIGEST_SIZE];
 	void *zero_buf;
 	struct kexec_sha_region *sha_regions;
 	struct purgatory_info *pi = &image->purgatory_info;
 
 	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY))
 		return 0;
 
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
 	zero_buf_sz = PAGE_SIZE;
 
-	tfm = crypto_alloc_shash("sha256", 0, 0);
-	if (IS_ERR(tfm)) {
-		ret = PTR_ERR(tfm);
-		goto out;
-	}
-
-	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
-	desc = kzalloc(desc_size, GFP_KERNEL);
-	if (!desc) {
-		ret = -ENOMEM;
-		goto out_free_tfm;
-	}
-
 	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
 	sha_regions = vzalloc(sha_region_sz);
-	if (!sha_regions) {
-		ret = -ENOMEM;
-		goto out_free_desc;
-	}
-
-	desc->tfm   = tfm;
-
-	ret = crypto_shash_init(desc);
-	if (ret < 0)
-		goto out_free_sha_regions;
+	if (!sha_regions)
+		return -ENOMEM;
 
-	digest = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
-	if (!digest) {
-		ret = -ENOMEM;
-		goto out_free_sha_regions;
-	}
+	sha256_init(&state);
 
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
 #ifdef CONFIG_CRASH_HOTPLUG
@@ -787,14 +760,11 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		 * info in purgatory.
 		 */
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
-		ret = crypto_shash_update(desc, ksegment->kbuf,
-					  ksegment->bufsz);
-		if (ret)
-			break;
+		sha256_update(&state, ksegment->kbuf, ksegment->bufsz);
 
 		/*
 		 * Assume rest of the buffer is filled with zero and
 		 * update digest accordingly.
 		 */
@@ -802,48 +772,30 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		while (nullsz) {
 			unsigned long bytes = nullsz;
 
 			if (bytes > zero_buf_sz)
 				bytes = zero_buf_sz;
-			ret = crypto_shash_update(desc, zero_buf, bytes);
-			if (ret)
-				break;
+			sha256_update(&state, zero_buf, bytes);
 			nullsz -= bytes;
 		}
 
-		if (ret)
-			break;
-
 		sha_regions[j].start = ksegment->mem;
 		sha_regions[j].len = ksegment->memsz;
 		j++;
 	}
 
-	if (!ret) {
-		ret = crypto_shash_final(desc, digest);
-		if (ret)
-			goto out_free_digest;
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-						     sha_regions, sha_region_sz, 0);
-		if (ret)
-			goto out_free_digest;
+	sha256_final(&state, digest);
 
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
-						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
-	}
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
+					     sha_regions, sha_region_sz, 0);
+	if (ret)
+		goto out_free_sha_regions;
 
-out_free_digest:
-	kfree(digest);
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
+					     digest, SHA256_DIGEST_SIZE, 0);
 out_free_sha_regions:
 	vfree(sha_regions);
-out_free_desc:
-	kfree(desc);
-out_free_tfm:
-	kfree(tfm);
-out:
 	return ret;
 }
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 /*

base-commit: 33035b665157558254b3c21c3f049fd728e72368
-- 
2.49.0


