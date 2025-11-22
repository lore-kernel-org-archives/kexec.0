Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CCACFC51F
	for <kexec@archiver.kernel.org>; Sat, 22 Nov 2025 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lzi5XhSukkOja/rLxys4R+45N3tXtMtHv0ZgIb+J524=; b=3eORzcD4rAEWdGnugfsjIP1Eaa
	f/Ge2L+i3bU26eIsn6xk06qYVfScgu5zEIkKo97tnBGrS/ovUsGpy5rpzt+YyoPzbM3uJA9QCY6Kd
	SeiX3YPDKIjOIEuJw5PJynGrAW0hFTkHmltsCAp6oeHgqy+w0F+0JRxI8AvLEn6rlfocyXmWXu/f5
	ofDURVLk6/PTP780k1X8G0eNo46uq1eokl06DmZ1+JIk7hEtJVc7XXI3nrAJCbs+Dy+k6rxLyH8wt
	9hvYazfreMdrnhYFwcu9oWFd0rlzQIyK2Ksuvw3B2TIhgkhKJAJGEmIhGlCsBBHJUhO1yZDtWcuhK
	5GQU1C+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMsNP-00000009nFy-0raT;
	Sat, 22 Nov 2025 18:30:27 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMsNJ-00000009nET-3Ytf
	for kexec@lists.infradead.org;
	Sat, 22 Nov 2025 18:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lz
	i5XhSukkOja/rLxys4R+45N3tXtMtHv0ZgIb+J524=; b=mn4CZRL25YqENFPbeC
	zzmszo5bXyD5ImU4Twxaw4QauOcVVtpknuhgWv8997zhNpt/tfjWP/7+xAnSvtqJ
	FDodX9LF3oDGZd9wX8ALhdH/y6xPKiv7j3t/4fMom2tK6E3hwqWOArtOIbLzqpUD
	//96jurS2czrCIjSCqei8tM90=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHm2QMASJpWaXTCA--.28911S2;
	Sun, 23 Nov 2025 02:29:32 +0800 (CST)
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
Subject: [PATCH v2] KHO: Fix boot failure due to kmemleak access to non-PRESENT pages
Date: Sat, 22 Nov 2025 18:29:29 +0000
Message-ID: <20251122182929.92634-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHm2QMASJpWaXTCA--.28911S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48CF43Jw4kJrWxtw1rCrg_yoW8Aw1fpF
	yvkF1jk3yUt3ZrXFnFv3Wv9rySqws8Cw43Ja4jvry3Zr9xJ3Z3twsYyryIvF1UWFZYgF43
	ZFWYq3yrur48XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pin2-UUUUUU=
X-Originating-IP: [117.176.242.91]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEBoOTGkh99DNGAAAsy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_103022_204743_A9771F7B 
X-CRM114-Status: UNSURE (   7.65  )
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
Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
triggers this when releases the KHO scratch region calling
init_cma_reserved_pageblock(). Subsequent kmemleak scanning accesses
these non-PRESENT pages, leading to fatal page faults.

Call kmemleak_ignore_phys() from kho_init() to exclude
the reserved region from kmemleak scanning before
it is released to the buddy allocator to fix this.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/liveupdate/kexec_handover.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 224bdf5becb6..c729d455ee7b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -11,6 +11,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
@@ -1369,6 +1370,7 @@ static __init int kho_init(void)
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
 		unsigned long pfn;
 
+		kmemleak_ignore_phys(kho_scratch[i].addr);
 		for (pfn = base_pfn; pfn < base_pfn + count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
-- 
2.25.1



