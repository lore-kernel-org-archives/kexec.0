Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A99EE021A
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IH2AWyk1tDPUEa75oSvS31QVhp8btZGdcueK9vY+lWU=; b=hMaFbIhe14nclN
	HPpCMBL+ivi7m2AidDYWsQW01fpm2LJzQ4un6w5cWLrEniy5bPNTyoy2xZ4C/hay5DktjvLqG8rGg
	z09L7K4XjDFi7V7np7DKpU0DrF8wxQmLfcbRrrErNjns20P06X+2nIMeLyfn867JF847fP3lqPtiK
	SMDa1tAMK9I6WqajSpSsWGm/KXI4wd6CN1aaGg5JcD/9It6I5a8dIritJZCDrtCSCU+A27YpFrpgL
	qi1/9JkVDja0vaVBR6s+noWWn9KTzPPOrmo/nCqBKfrgonbdQ1sPqbxBt99TnZhHLfuZSldXC1cnY
	vEpp9SKzaKJJz0E6Sltw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzy3-009hpp-2O;
	Fri, 15 Sep 2023 03:58:07 +0000
Received: from bg2.exmail.qq.com ([114.132.197.227])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzy0-009hpN-2t
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:58:06 +0000
X-QQ-mid: bizesmtp74t1694750258tima96fh
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:57:36 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 7QbCsSX/jDYbaopCa3UpPo6wbLZIJTT0T0cFYdRoqRQDMz7aqJ0YFdl5yPvMS
	zMITf4CQmut3tJX7nLkHfwvpa9af7o6NPvU+A/CWUsy20Rr+umy2jQOf9H7KVNZmv80pjXx
	iSGpkFiAoTUgTFZRkBVrsEtDJgW//Xh5dmk609fwc95rxmfz78Vq3xc7BanM1blD629eW3R
	Y8iWd2dDymQ/ifQ28Ner0gFFARL1hW0tocOu3rsmtXxb3nN9C9/vfx5Bvn8eMdADWuptB4G
	fnsXhNlCdon4w46nhGkvsTa+VX3un7r97m26c+aAYALDkrGiIgDDr4KFeWMY5SIupSM34DL
	2ULwdiTCGrHUfsXPKwWZvNLk8yXqKvsV26QyWD8EfE6DVrgxjsqSw1sCl5GnKW+IWKjePVn
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2346430415574310994
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 6/7] RISC-V: Separate elf_riscv_find_pbase out
Date: Fri, 15 Sep 2023 11:50:12 +0800
Message-Id: <20230915035013.1582679-7-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205805_264190_1BED5C78 
X-CRM114-Status: GOOD (  18.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

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
index 2b9f66d..49deedb 100644
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
+	ret = elf_riscv_find_pbase(info, &new_base_addr, kernel_size, KERNEL_ALIGN);
 	if (ret < 0) {
 		fprintf(stderr, "Could not find a memory region for the "
 				"provided ELF image\n");
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index 4500aa9..74feef2 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -51,6 +51,61 @@ static struct fdt_image provided_fdt = {0};
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
+int elf_riscv_find_pbase(struct kexec_info *info, off_t *addr,
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
index f136c7e..233b137 100644
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
+int elf_riscv_find_pbase(struct kexec_info *info, off_t *addr,
+				off_t size, off_t align);
 
 int elf_riscv_probe(const char *buf, off_t len);
 void elf_riscv_usage(void);
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
