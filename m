Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DDCD4415B
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlpIS4p5oycsQ08DmcPjo7M49fd+td9zG0Th5DgBMX8=; b=Xymkh8c8byHS1tSRM2u7SbH8Tg
	sFuBZ2Rg0zB52LroVU7hU95KC+iqgT7HEvZk94T6zBLNDN7YAupvKOHGyiu2WB+O5X4l5/VkKxxJ8
	wZd6IbpKRQ0NrniOWhrb1sTNyp/FBr6tfNoY86oAxFo6uLNYgl7YctNBnO5cd5iJbanIgzTbJTI8w
	q0rfTBWJhmEZ/VwI80LP3kFWJuaNbO7QTWm2QfU4bCTtnmLHW2DPHtEmWBvPc3U9GP1rPvxPKI7sE
	9pNHutoLaEDmszPCzVeZrQqTV/ZktkBdQxE9iIrDm3ICfFfjqD3JBYyKY9JXWWX/3MUsUDV5Z9Dim
	BXUTCc+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzve-00000000OFf-0FXc;
	Fri, 12 Dec 2025 09:59:14 +0000
Received: from smtpbgbr1.qq.com ([54.207.19.206])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzva-00000000O6X-0TIx;
	Fri, 12 Dec 2025 09:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765533489;
	bh=hlpIS4p5oycsQ08DmcPjo7M49fd+td9zG0Th5DgBMX8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lSIqpiQvTvPXBtA/vWLd2ccSX0jzsmI4Sbj9aMl+2wkWFjqspzQuU6ulbSMntuxvw
	 SqpnSC8/5+niEsdqoHmycKBukpvKDSxXCCSVbD2bqk/3qLywCwfSN+SAIc/9aMWFCB
	 y9gURLj6VMMURzLnNQIntMqTKqbAiP/qTPXB03Cw=
X-QQ-mid: esmtpsz10t1765533471t617c6373
X-QQ-Originating-IP: NmfuHu3jgBsBZAchuScf++VUIUA1fKMHyTrHgj5sgTk=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Dec 2025 17:57:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1668247607997901334
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
Subject: [PATCH v1 1/3] kexec: add kexec flag to control debug printing
Date: Fri, 12 Dec 2025 17:56:47 +0800
Message-Id: <20251212095649.857796-2-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251212095649.857796-1-maqianga@uniontech.com>
References: <20251212095649.857796-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQeVWkiXADQbQ5CI45avQ8S0Y/+Kq379lM1ZgR92PNSXkiZFxDQ+hktE
	RZf13LhZAuI6c502NV/mPudYwcNAafoSZfiC16cZq6T1W2d9JR5yDduABYjdMx46TERNh4E
	oCT/eLdRuw4cIwh4TpWAiLur5FqIofcGmwNEYv8eatQea77y0roBZJy/yN67SzNCuXilGsl
	r9R9P8RQn2GE/zgvRUS/Csl3j4pWJwjrO/bcrI6waRxsYdlfjorHzC8Ep+4FCNs5Xc1GYhj
	DMC/5FoMT1orENwU9oMxRJqOdXYgwfTvPYaVnZTfyHjOXM7MYd9LuSPK2dFSdju1U0T6k+B
	rZq3eAwYF+h+LZCCHpVXPdmHOLfWGnAxa/KsTgdSJsWBAo0O0T+zN4xznDT6SclK7pxxKFD
	TLZkS3cWzqJMjl100SFhtEnK4Xhh+TOobqZR4D7VEh4RBg4X3A1UDqx91yeUeIc/owVEqAh
	ou1ePDs87OAFWMU+rY9aBF0aEWsVfbHbE6lWGIhS7NQUxA8M66H5WOOZMpTReWVRiIfZLcy
	vWjFDFtMVdH3mZL+pNcxRBW3nJMd3gQifMl21lz06evsTTUoFLmkqcPV6ViORyHZCeKnWIj
	eWFmVh+uiJA+MlejBgaH2n3WqOMNe7WpdgoCqFSmfJHXuiKsgMXPBkXfeWyngaHJ0qCjB5v
	cEbFdBt63ZrAoU0i1M7O7xbJeoAV9m9NJo+ORqu+KeMMPDJ8Z558Fy8eMGg3i5LbkHOhDnv
	ocEeJ+PFY2sL8ylnpn+2XKsltmOS5URNE34+QMBuLMn4ExO0b8IxTpX05lXt+wSeUxsao2e
	kV5cXXSTE7q3ocwGNKXIYR2s4bKmXZnlWMpbL9baKa/LWqWsD4vIo3ngrjSwmC/3DyJhWYM
	VUZFsGBfzEkUrR77rKOjBgOM3v2FIKFJ5BxvmuQML7W7xWs1k31XS6Lu8aeKLk1ybt/JnJ3
	HoCK943Pv3B/DYwBcaxxspCguPW1uepSGHW+Jhj6UnYBKIkuYFVjAQZY0OhXPB8N7fQNbRe
	vYsy4ceAanGG/npUQq+yYNwnvqaIU/t5aa6dGl5ak+qOwJIS9Hnmsy1671otjyfAgvjCAlr
	VzoLE294cfT99OdreZMUKCikssEGPRXYA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_015911_162490_7FFC0363 
X-CRM114-Status: GOOD (  19.05  )
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
index fa00b239c5d9..7bc1cd4105fc 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,7 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-bool kexec_file_dbg_print;
+bool kexec_dbg_print;
 
 /*
  * When kexec transitions to the new kernel there is a one-to-one
@@ -576,6 +576,8 @@ void kimage_free(struct kimage *image)
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


