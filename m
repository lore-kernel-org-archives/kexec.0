Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E7EC79F83
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTixsxuGb1ShvX5LUOrF9FQYyrN030TPzy93bsFnjSQ=; b=BwkXgvKWhqkTYMuluWKJJfyvnn
	utZGmqr1JGKpxYGC69BrhxD+sISHWEJQsVC3EogA3uCZkF9cAXooXcmq5yMx+gd64vP7xF/IXCftj
	4umjKSR6pO1Xt99ZxqDjWBRCm7ZwRB6FNE6sLD5HhjnSK2nRq18xOIe0+rpPKKqNAmCaBbdx9i95f
	qmTl8X78Wpfzvp+Yna+ArYz/yOGqJhRVL2gQNefUC2D1Lf1NV/MdXs7MXjUOZ0nwAZbflXEYICqfz
	NZpaIDO+jcafGJpMJ+JGvReY900R7NN+myWgQDcsSstR2CrjveCF5XXEbyn4EzchM89TsDBxz4WcP
	C2YaqA2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsU-00000001cjh-0wQf;
	Fri, 04 Sep 2026 10:10:34 +0000
Received: from out-95.mta1.migadu.com ([95.215.58.95] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsP-00000001cgq-1rXN
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 10:10:31 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=PHW2ypkolV+36MeBrIflBY2kZtvuYhFSqnZa7Us0mSc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788516627; v=1; x=1789121427;
 b=PXOgys016DDQhBb/QNKwSkffh+43zc78rYU4UKbXwE6RWxIzonFp+epRA1onkLuvSzHVdEL+
 VNsS5zGIUqkzkGmkoqh91TGfrg5FhVDnPYpbgM595l95zXwS+ioLRT2IssUtaRA8U+rJAL9eGUb
 AG038oagG6EWQpo4yMmgyNv4=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id b181acf3ff0b524f;
	Fri, 04 Sep 2026 10:10:27 +0000
X-Mizu-Trace-ID: b181acf3ff0b524f
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 2/5] liveupdate: synchronize EFI KHO channel at execution
Date: Fri,  4 Sep 2026 18:08:49 +0800
Message-ID: <20260904100852.26006-3-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904100852.26006-1-dongtai.guo@linux.dev>
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_031029_626814_4C2C1CCE 
X-CRM114-Status: GOOD (  15.45  )
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

From: George Guo <guodongtai@kylinos.cn>

The EFI KHO configuration table is a global channel. Updating it while
a candidate kexec image is still being loaded can leave the channel
pointing at the failed candidate even though the previous image remains
installed. Synchronize it instead from the image selected for execution.

Use the actual scratch payload size rather than its page-aligned segment
size, and propagate update failures before live-update serialization.
Keep clearing the channel for cold and crash images best-effort.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/crash_core.c                |  7 +++++++
 kernel/kexec_core.c                |  5 +++++
 kernel/kexec_internal.h            |  3 +++
 kernel/liveupdate/kexec_handover.c | 33 ++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..6166ce4203d3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -138,6 +138,13 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
+			/*
+			 * A crash image carries no KHO state: clear the
+			 * transport so the crash kernel boots cold instead
+			 * of reviving from stale state.
+			 */
+			(void)kho_sync_channel(kexec_crash_image);
+
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..147f5b5b23d4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1146,6 +1146,11 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	/* Synchronize the handover transport with the image being executed. */
+	error = kho_sync_channel(kexec_image);
+	if (error)
+		goto Unlock;
+
 	if (!kexec_image->preserve_context) {
 		error = liveupdate_reboot();
 		if (error)
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 228bb88c018b..4d4c2290e85c 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -46,6 +46,7 @@ struct kexec_buf;
 int kho_locate_mem_hole(struct kexec_buf *kbuf,
 			int (*func)(struct resource *, void *));
 int kho_fill_kimage(struct kimage *image);
+int kho_sync_channel(struct kimage *image);
 #else
 static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 				      int (*func)(struct resource *, void *))
@@ -54,5 +55,7 @@ static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 }
 
 static inline int kho_fill_kimage(struct kimage *image) { return 0; }
+
+static inline int kho_sync_channel(struct kimage *image) { return 0; }
 #endif /* CONFIG_KEXEC_HANDOVER */
 #endif /* LINUX_KEXEC_INTERNAL_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 39f489a258d9..3aa5c66dfc6d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -14,6 +14,7 @@
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
+#include <linux/efi.h>
 #include <linux/kasan.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
@@ -2074,6 +2075,38 @@ int kho_fill_kimage(struct kimage *image)
 	return 0;
 }
 
+/*
+ * Synchronize the handover transport with the image that is about to be
+ * executed.  The EFI config table channel is global, while kexec keeps
+ * separate images for a normal reboot and for crash.  Write the state of the
+ * selected image immediately before it is executed, rather than while a
+ * candidate image is being loaded, so a failed replacement cannot leave the
+ * channel pointing at that failed image.
+ *
+ * An image loaded through the legacy kexec_load() syscall, a crash image, or
+ * an image loaded while KHO is disabled carries no handover state.  Clear the
+ * channel for those images so the next kernel boots cold instead of reviving
+ * from stale state.  Clearing is best-effort because an absent channel cannot
+ * affect a cold boot.
+ */
+int kho_sync_channel(struct kimage *image)
+{
+	int err;
+
+	if (!image->kho.fdt || !image->kho.scratch) {
+		efi_kho_update(0, 0, 0, 0);
+		return 0;
+	}
+
+	err = efi_kho_update(image->kho.fdt, PAGE_SIZE,
+			     image->kho.scratch->mem,
+			     image->kho.scratch->bufsz);
+	if (err)
+		pr_warn("failed to update EFI config table: %d\n", err);
+
+	return err;
+}
+
 static int kho_walk_scratch(struct kexec_buf *kbuf,
 			    int (*func)(struct resource *, void *))
 {
-- 
2.53.0


