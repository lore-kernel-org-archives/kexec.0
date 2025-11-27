Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F093AD11183
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5RbktsfuLErXNRL2ozcCIVf4lkgY78kG3x/0KHQBTFA=; b=NP0eHZ7hK+u8h3ydmuTrx3szES
	IF0YiJWtIYfTRU9nxv6M54RvK64xIeE1fSoit0wicAgSQEcB1yCqjzFrCbBii6Z/pcC86Aq2BbuR1
	aVRDWWUzA+fdId6g6XltlMiek9rSjgnwqewkpoOprSQKhyUkJOzlcVrsJ5QMcQrk28bqZdC1fINiZ
	1sKHUoRxHWVgGybTGKLxUrEcjLRvla5Zhsiatm1AHzrqFBlprgeD0Ce8iBaCaM9GEEH5aFHm2xAKb
	TlGmbBLFf5GYzTsMnfWKYXKJLMzJtDAS2B4KnCa/WE/MpZ5AyXPLYM+/jCOFfxRK3iurAMvfl72C3
	JKE4jPfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOb6Q-0000000GYS2-3Mw9;
	Thu, 27 Nov 2025 12:28:02 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOb6L-0000000GYP9-3qfH
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 12:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5R
	bktsfuLErXNRL2ozcCIVf4lkgY78kG3x/0KHQBTFA=; b=gAnweojtvdn39maxnJ
	Xbw4H1WjVl7mHX91s0G01F50JP0XedAi0gxi5ZhJe46mP8ps9OWdRUa0YyzDd98T
	aqXrM+ybex0txGqzfe/vbRutNoZW5tXnY6cJOOk2RfSQcN2wo0niV+RS3P7yzqge
	Po/Z7/pmVrPewN8nqMDyNuKgs=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHL8qbQyhpIwGSFQ--.45778S2;
	Thu, 27 Nov 2025 20:27:09 +0800 (CST)
From: ranxiaokai627@163.com
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	changyuanl@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH v4] KHO: Fix boot failure due to kmemleak access to non-PRESENT pages
Date: Thu, 27 Nov 2025 12:27:00 +0000
Message-ID: <20251127122700.103927-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgAHL8qbQyhpIwGSFQ--.45778S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48CF43Jw4kJrWxtw1rCrg_yoW8Kr13pF
	yvkF1jyws8t3W3WFsrZ3WvkrySqw4kC3y3J34DZry5Z3sxJFnaywsYyryIqFyUurZ2gF43
	ZF4YqrWfWr18XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pin2-UUUUUU=
X-Originating-IP: [117.176.242.91]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEA0QTGkkVSOLfAABsM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_042758_329454_61FF7E4F 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When booting with debug_pagealloc=on while having:
CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
the system fails to boot due to page faults during kmemleak scanning.

This occurs because:
With debug_pagealloc is enabled, __free_pages() invokes
debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
freed pages in the kernel page table.
KHO scratch areas are allocated from memblock and noted by kmemleak. But
these areas don't remain reserved but released later to the page allocator
using init_cma_reserved_pageblock(). This causes subsequent kmemleak scans
access non-PRESENT pages, leading to fatal page faults.

Mark scratch areas with kmemleak_ignore_phys() after they are allocated
from memblock to exclude them from kmemleak scanning before they are
released to buddy allocator to fix this.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 224bdf5becb6..55d66e65274f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -11,6 +11,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
@@ -1369,6 +1370,15 @@ static __init int kho_init(void)
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
 		unsigned long pfn;
 
+		/*
+		 * When debug_pagealloc is enabled, __free_pages() clears the
+		 * corresponding PRESENT bit in the kernel page table.
+		 * Subsequent kmemleak scans of these pages cause the
+		 * non-PRESENT page faults.
+		 * Mark scratch areas with kmemleak_ignore_phys() to exclude
+		 * them from kmemleak scanning.
+		 */
+		kmemleak_ignore_phys(kho_scratch[i].addr);
 		for (pfn = base_pfn; pfn < base_pfn + count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
-- 
2.25.1



