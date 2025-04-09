Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C380C369A8
	for <kexec@archiver.kernel.org>; Wed,  9 Apr 2025 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RedsDQNgUnz2lctsdl37t3Z3E1tFNSX10+QqkqkoziU=; b=B61iAif8DwswLUcxxuj+FfoSQ9
	EYDThvfdcqovJ5vZgdfnHwWvP8Z4Z5p5GYTLzz4OBliiFZVC872EK2qyFUh2iuIbZUYXWyGCIumYy
	EVF2i1dkfLxpEloaD8Rl9BnRq4BoK9kXrCQoIlBfOO7ir1OP+PR+JGwJnEb2SfRRdmX8dKMyl+w+y
	5notgt4IEzjI063u7fJo4LkgmuNm3pHali0Ay+or1IQxTbU52Z89t3i/5reoHzdE2CGKTyG0LVyo/
	NsJORAVdL2Emfzv2bOStTzc49awhGHz7DAvWhBpNruuIIDslD9hxggOefn+zdnam+S6uagXMIP6PW
	yEO6zKTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2bp2-00000008PLp-0iE4;
	Wed, 09 Apr 2025 20:14:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2boz-00000008PJx-2f65;
	Wed, 09 Apr 2025 20:14:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5971E43F87;
	Wed,  9 Apr 2025 20:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C4AC4CEE2;
	Wed,  9 Apr 2025 20:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744229693;
	bh=uR77fvzFaelKDRCqYYg1N++6plABBaWdjbIY0SfRnAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9F2BT7QYT+bTOU4V4hsZ/fPcoKluFGN+xor/zHsBkp33+XldmatR7wPzLim5/VXl
	 zL+pT2x57hkxnAjoxWqSsyf1IpyKmEpUfhjT6mRFj+1+UKsGrl1p0ZL+g7Z9b0/s6q
	 X2BML6gulZBWPwdtXJG+HnDZ5Se0tFR4Ky4JnMEc6zy0GsKc/rdSxIyWw9d/g8ucsd
	 0h+tmbY1Yo427KBtd6dgq4OLcnEw1cgbDZur2sy9vNUcWILV7lwgvfmhqHnY20WvDi
	 kJ1UYRjYx2SZH1o9nq4H6pWSrDKdbo6nmulTQhgEl3LAz7h4S2CinL4BgcDINd+PZ0
	 kpBJDJsVfkSXQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Simon Horman <horms@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>,
	Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 3/4] RISC-V: Separate elf_riscv_find_pbase out
Date: Wed,  9 Apr 2025 22:14:25 +0200
Message-ID: <20250409201428.648717-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409201428.648717-1-bjorn@kernel.org>
References: <20250409201428.648717-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_131453_714134_1E536B56 
X-CRM114-Status: GOOD (  20.19  )
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

From: Song Shuai <songshuaishuai@tinylab.org>

The is the preparative patch for RISC-V kexec Image file support.

Separate the elf_riscv_find_pbase() function out to
allow kernel_load syscall load Image binary file.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/kexec-elf-riscv.c | 72 +-----------------------------
 kexec/arch/riscv/kexec-riscv.c     | 55 +++++++++++++++++++++++
 kexec/arch/riscv/kexec-riscv.h     | 13 ++++++
 3 files changed, 69 insertions(+), 71 deletions(-)

diff --git a/kexec/arch/riscv/kexec-elf-riscv.c b/kexec/arch/riscv/kexec-elf-riscv.c
index 2b9f66d782af..434873cf9f08 100644
--- a/kexec/arch/riscv/kexec-elf-riscv.c
+++ b/kexec/arch/riscv/kexec-elf-riscv.c
@@ -12,76 +12,6 @@
 #include "kexec-syscall.h"	/* For KEXEC_ON_CRASH */
 #include "kexec-riscv.h"
 
-
-/*********\
-* HELPERS *
-\*********/
-
-/*
- * Go through the available physical memory regions and
- * find one that can hold an image of the specified size.
- * Note: This is called after get_memory_ranges so
- * info->memory_range[] should be populated. Also note that
- * memory ranges are sorted, so we'll return the first region
- * that's big enough for holding the image.
- */
-static int elf_riscv_find_pbase(struct kexec_info *info, off_t *addr,
-				off_t size)
-{
-	int i = 0;
-	off_t start = 0;
-	off_t end = 0;
-	int ret = 0;
-
-	/*
-	 * If this image is for a crash kernel, use the region
-	 * the primary kernel has already reserved for us.
-	 */
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		ret = get_crash_kernel_load_range((uint64_t *) &start,
-						  (uint64_t *) &end);
-		if (!ret) {
-			/*
-			 * Kernel should be aligned to the nearest
-			 * hugepage (2MB for RV64, 4MB for RV32).
-			 */
-#if __riscv_xlen == 64
-			start = _ALIGN_UP(start, 0x200000);
-#else
-			start = _ALIGN_UP(start, 0x400000);
-#endif
-			if (end > start && ((end - start) >= size)) {
-				*addr = start;
-				return 0;
-			}
-
-			return -EFBIG;
-		} else
-			return ENOCRASHKERNEL;
-	}
-
-	for (i = 0; i < info->memory_ranges; i++) {
-		if (info->memory_range[i].type != RANGE_RAM)
-			continue;
-
-		start = info->memory_range[i].start;
-		end = info->memory_range[i].end;
-
-#if __riscv_xlen == 64
-		start = _ALIGN_UP(start, 0x200000);
-#else
-		start = _ALIGN_UP(start, 0x400000);
-#endif
-
-		if (end > start && ((end - start) >= size)) {
-			*addr = start;
-			return 0;
-		}
-	}
-
-	return -EFBIG;
-}
-
 /**************\
 * ENTRY POINTS *
 \**************/
@@ -182,7 +112,7 @@ int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
 		  kernel_size / 1024, old_base_addr, old_start_addr);
 
 	/* Get a continuous physical region that can hold the kernel */
-	ret = elf_riscv_find_pbase(info, &new_base_addr, kernel_size);
+	ret = riscv_find_pbase(info, &new_base_addr, kernel_size, KERNEL_ALIGN);
 	if (ret < 0) {
 		fprintf(stderr, "Could not find a memory region for the "
 				"provided ELF image\n");
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index bbc25c5cba41..631659301749 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -50,6 +50,61 @@ static struct fdt_image provided_fdt = {0};
 * COMMON HELPERS *
 \****************/
 
+/*
+ * Go through the available physical memory regions and
+ * find one that can hold an image of the specified size
+ * and start address should be aligned up with `align`.
+ * Note: This is called after get_memory_ranges so
+ * info->memory_range[] should be populated. Also note that
+ * memory ranges are sorted, so we'll return the first region
+ * that's big enough for holding the image.
+ */
+int riscv_find_pbase(struct kexec_info *info, off_t *addr,
+				off_t size, off_t align)
+{
+	int i = 0;
+	off_t start = 0;
+	off_t end = 0;
+	int ret = 0;
+
+	/*
+	 * If this image is for a crash kernel, use the region
+	 * the primary kernel has already reserved for us.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		ret = get_crash_kernel_load_range((uint64_t *) &start,
+						  (uint64_t *) &end);
+		if (!ret) {
+			start = _ALIGN_UP(start, align);
+
+			if (end > start && ((end - start) >= size)) {
+				*addr = start;
+				return 0;
+			}
+
+			return -EFBIG;
+		} else
+			return ENOCRASHKERNEL;
+	}
+
+	for (i = 0; i < info->memory_ranges; i++) {
+		if (info->memory_range[i].type != RANGE_RAM)
+			continue;
+
+		start = info->memory_range[i].start;
+		end = info->memory_range[i].end;
+
+		start = _ALIGN_UP(start, align);
+
+		if (end > start && ((end - start) >= size)) {
+			*addr = start;
+			return 0;
+		}
+	}
+
+	return -EFBIG;
+}
+
 int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 			uint64_t kernel_size, uint64_t max_addr)
 {
diff --git a/kexec/arch/riscv/kexec-riscv.h b/kexec/arch/riscv/kexec-riscv.h
index f136c7eab561..618099291117 100644
--- a/kexec/arch/riscv/kexec-riscv.h
+++ b/kexec/arch/riscv/kexec-riscv.h
@@ -4,6 +4,17 @@
  *              Nick Kossifidis <mick@ics.forth.gr>
  */
 
+/*
+ * Kernel should be aligned to the nearest
+ * hugepage (2MB for RV64, 4MB for RV32).
+ */
+
+#if __riscv_xlen == 64
+#define KERNEL_ALIGN 0x200000
+#else
+#define KERNEL_ALIGN 0x400000
+#endif
+
 struct fdt_image {
 	char	*buf;
 	off_t	size;
@@ -26,6 +37,8 @@ int load_elfcorehdr(struct kexec_info *info);
 int prepare_kexec_file_options(struct kexec_info *info);
 int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 			uint64_t kernel_size, uint64_t max_addr);
+int riscv_find_pbase(struct kexec_info *info, off_t *addr,
+				off_t size, off_t align);
 
 int elf_riscv_probe(const char *buf, off_t len);
 void elf_riscv_usage(void);
-- 
2.45.2


