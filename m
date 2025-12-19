Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B7D74969
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WWn9WiYIbmVbreSUly6Wmiv5y6Py0BUHLhyaBm5H3ic=; b=UWODNJ6WLUuHrM8OPkQY5f+shB
	0MzSeXEIKJU8uq8q9IpUXlM9gwbof7eWt2NZArEqKlD/wqjN0ecLPK8P8ClXNpm/VbYz+dWNe+ime
	r0irzpVUD8+/y/XBUd5mije2PnUV9cGniq0L2yZ8WfbkG42KjSEy1eD3gbpHmE4G9zA7oCvlzNplX
	FFQ+nP6j+6D1x4lK5d+mIJhdIcq8hC8B9cvZU8N8LVDQ3r1+RAjFs1s7kWtsRb/Ov4DIukPNQIKdG
	//DfjEQkKTSmYiUk8GqryScPlYuMEroRRQYXUdYhlRCoWIgr+Z3bvktjhUbVjjyt2rmtJdJPOQAQX
	R7jQ/mOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWsX-00000009xjR-462S;
	Fri, 19 Dec 2025 09:34:29 +0000
Received: from smtpbgsg2.qq.com ([54.254.200.128])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWsU-00000009xe2-2X7t;
	Fri, 19 Dec 2025 09:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766136809;
	bh=WWn9WiYIbmVbreSUly6Wmiv5y6Py0BUHLhyaBm5H3ic=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EpDrLpB4l//0Jr36ar0gPhc2EN9d59TMF8RVlSsx5xJDutibm3hY2c+gJcbnqlsaO
	 8fEIuM65coxmHtf1V3zOTGuCNWnczBKVZVq7gbErSqlf2pvgvQAAXHD0A4kKQP/CEh
	 two3/pSvRBI96tnMquY8VfEFRDhM7VMi3vqhvHnI=
X-QQ-mid: zesmtpsz5t1766136788t261ff1c4
X-QQ-Originating-IP: jf07Gpyl0qD+bKxLoVmk/7qgC6XNX6SupesXVPgyPi8=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Dec 2025 17:33:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16359547072487399879
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 2/4] kexec: add kexec flag to control debug printing
Date: Fri, 19 Dec 2025 17:31:32 +0800
Message-Id: <20251219093134.2268620-3-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251219093134.2268620-1-maqianga@uniontech.com>
References: <20251219093134.2268620-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: My1XIh02ZBMDWl+6BS3GkG0UjUkGXJPoBumDkAGKi2aB9tsWOIfri/9X
	ze7Yi4xYcwxYUhrfJyBdZ07mWYQCOQmHgC0nwscZuiCMOWObDbNFLjcoKlEZTtCIjo/7Oos
	N2trCJgWHLZSfj+XshICiqyzW1E1LWS7FfzAQJovLjfvhFsWlYowcStq6AHdIDt9Mss6J7B
	gkmUh6E/kDgnbB8UFU6MhHKJsqJICzVzIBUC2LOB0y+FBqfLbMEIfwx9l9nWHx3vNKz1wsP
	62SZuWspKjK0vZpfLGTF7QlKbeYmJdcZlJbwA49FgPvk15F5LR5/iCs3a4JbLz7vVf4FAb3
	FdvSP8D2x50JyeME8rjCalhqGQoY4FCl9dvOgV6f2RMADoJwiIJ9I0t5VAm4Jms2ZG0fq7m
	T6tH+Ub2lL3XsrCkXH241yRKDce3U/rgoK4peUk50wWFoC8EgThJyFV4NImeti+m+yzQc2k
	k1OTnOkBMFTxav6BQ3h7axK3K6yEq0mMFWcmpHkkXZsHfuK2kMeWPziVDpA6fB/pt2k3C16
	zP4HHP7fhDvjqSaie5CbLmWIw3amJSq023hOXy6/0CeHHta6XqV1lSKQHdtadz6arof86/z
	S9nOIG0bz7eeVgmD0mE30EFFQD3/deJL+Mqogt42vnTJwZ9SrpxXjniv25uqNYtXFQrI0Cm
	AEbEklP1Uu1qd8VaPucPlHy2yQ9/yRxX4mn3PSDT5QXroOOuE/VozzfX0XYmhOYI8CkTTIR
	cAwsiZCKOHvKatfctR3c90J5E3QnaZSOGZkFsLPIGnnO8JqWTzyWMUh19ewwdwmGFrzMEiE
	Y4ohizPaN4rUEd9jeuJgYfd33qOTIXGmktx2iai3GpkFiZZgvC96D2obvRf+2ISgg10W0XZ
	AsEC6eAKx5b6H6ccI3fIvTpUSNy5MU5ZCRP888J9QiaqZ7O+b0XYEu4LoHpD1cAQ6daSCco
	paYa8IRvq8XA5up7wkYfQXqHD1yK7tcGrUbumhRjLdw+nHjJetAssWmFZVpcGzQkV8u45LM
	R5vdzktkaFebJ/CzZHpiifa+w+W6a8N88Dql5ujXyJQ1SWt73cRLNBgpDrAcCi8f+QauWqu
	CnYJpXSsL+X5NWWb/3WVt5iGAo+CfDlIsplawEq99ky
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_013427_005926_2D0ADF09 
X-CRM114-Status: GOOD (  19.18  )
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

The commit cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control
debug printing") added the kexec_file flag to control debug printing.
However, for arm64, after commit 6f8c1da071a4 ("kexec_file, arm64: print
out debugging message if required"), when using the kexec_load interface,
the kexec_image_info function is called to print debug message, but
it uses kexec_dprintk, which is only available under kexec_file,
then when specifying 'kexec -d', kexec_load interface will print nothing.

For riscv, commit eb7622d908a09 ("kexec_file, riscv: print out debugging
message if required") remove kexec_image_info(), because the content has
been printed out in generic code in kexec_file_load, but not in kexec_load.

Therefore, in order to solve the two problems mentioned above, for this
patchset, several things need to be done:

1. Enabling kexec_dprintk is available for kexec_load.
2. Add some debugging message of the deleted kexec_image_info
   to generic code.
3. Remove duplicate debugging prints for arm64

Since kexec_load and kexec_file_load are not triggered simultaneously,
we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.

In this way, kexec_dprintk is available for kexec_load and kexec_file_load.

The following are the key points of the specific changes:

1. rename kexec_file_dbg_print to kexec_dbg_print
2. Add KEXEC_DEBUG
3. Initialize kexec_dbg_print for kexec
4. Set the reset of kexec_dbg_print to kimage_free

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 include/linux/kexec.h      | 9 +++++----
 include/uapi/linux/kexec.h | 1 +
 kernel/kexec.c             | 1 +
 kernel/kexec_core.c        | 4 +++-
 kernel/kexec_file.c        | 4 +---
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..23f10aec0b34 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -455,10 +455,11 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT | \
+			KEXEC_DEBUG)
 #else
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
-			KEXEC_CRASH_HOTPLUG_SUPPORT)
+			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_DEBUG)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -525,10 +526,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
-extern bool kexec_file_dbg_print;
+extern bool kexec_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
+	do { if (kexec_dbg_print) pr_info(fmt, ##arg); } while (0)
 
 extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
 extern void kimage_unmap_segment(void *buffer);
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 55749cb0b81d..819c600af125 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -14,6 +14,7 @@
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
+#define KEXEC_DEBUG		0x00000010
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9bb1f2b6b268..f6c58c767eb0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	if (!image)
 		return -ENOMEM;
 
+	kexec_dbg_print = !!(flags & KEXEC_DEBUG);
 	image->start = entry;
 	image->nr_segments = nr_segments;
 	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 0f92acdd354d..d7c2a2b79214 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -55,7 +55,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-bool kexec_file_dbg_print;
+bool kexec_dbg_print;
 
 /*
  * When kexec transitions to the new kernel there is a one-to-one
@@ -578,6 +578,8 @@ void kimage_free(struct kimage *image)
 	kimage_entry_t *ptr, entry;
 	kimage_entry_t ind = 0;
 
+	kexec_dbg_print = false;
+
 	if (!image)
 		return;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a9794242..3f1d6c4e8ff2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	 */
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
-
-	kexec_file_dbg_print = false;
 }
 
 #ifdef CONFIG_KEXEC_SIG
@@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!image)
 		return -ENOMEM;
 
-	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
+	kexec_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
 	image->file_mode = 1;
 
 #ifdef CONFIG_CRASH_DUMP
-- 
2.20.1


