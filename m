Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB422CF8861
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VqtJVjFf2VTiEsbahcHSK1+SUTx0HAzBAG6cy3z+p1Y=; b=d/+znSZS4bvXINIxtmpxOuNKzG
	h/VdkcJANcTlg0UYQ08uNwBfsme2REb77gD9wgAyMAi8uCVueBDD5DSdyHdbldoD+U7PE5dyjl7Ba
	wpsClEhUwIOEOlKNa6bqF1NLRobHb33sGAY1eAhMCjOZiRyrFuVDIA65PwYL8IwbiAaa6LE7B44v8
	QnU8mVRM/P8smlwb4X0b06P8IhCAxB5z8wRZncHEvgDl3iUz7IlPg5XIk2mIRzbt7jmyswOQ9AvOd
	5bGk0q12EkRCT2DYVy3G53+5nm35v4HbC1dYd1qa6/BZNhIJ760wNEVEfdcfTaWzqq4QLlLnA5Kiw
	6wupOHMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM5rr-00000006rXb-2K85;
	Thu, 20 Nov 2025 14:42:39 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM5ro-00000006rW7-2fhL
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 14:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Vq
	tJVjFf2VTiEsbahcHSK1+SUTx0HAzBAG6cy3z+p1Y=; b=T6DiTPF0QphyeJ6ynn
	rpY6XD2TiGV6q27qAf8VLfdX98bhKJJh+KtuE1Hrjnxm4LekyutigidujNaJZWUG
	r84wyEXl/6O4Z5VDNM9CPz8nx5HVZn7NGs0xkQwThGDFvJjgCC4iACP8KbFJO8vA
	U8CfGhL9bNzEy5/5EKKrUSi7E=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wA3yJmuKB9pTEQrBQ--.727S4;
	Thu, 20 Nov 2025 22:41:55 +0800 (CST)
From: ranxiaokai627@163.com
To: catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	changyuanl@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH 2/2] liveupdate: Fix boot failure due to kmemleak access to unmapped pages
Date: Thu, 20 Nov 2025 14:41:47 +0000
Message-ID: <20251120144147.90508-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120144147.90508-1-ranxiaokai627@163.com>
References: <20251120144147.90508-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3yJmuKB9pTEQrBQ--.727S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48CF43Jw4DKryfuFWktFb_yoW8tr4xpF
	yvkF1DCw4jy34jqFWxZa4v934Fga90kw17AFyj934avr9Fv3s3tws5ZryUtryUXrZ3KF4j
	vFWDK3yruw4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEs2-UUUUUU=
X-Originating-IP: [117.176.242.6]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEBwMTGkfJUZRjQABsE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_064237_017663_52012767 
X-CRM114-Status: UNSURE (   8.55  )
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
With debug_pagealloc enabled, __free_pages() invokes
debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
freed pages in the direct mapping.
Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
releases the KHO scratch region via init_cma_reserved_pageblock(),
unmapping its physical pages. Subsequent kmemleak scanning accesses
these unmapped pages, triggering fatal page faults.

Call kmemleak_no_scan_phys() from kho_reserve_scratch() to
exclude the reserved region from scanning before
it is released to the buddy allocator.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/liveupdate/kexec_handover.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 224bdf5becb6..dd4942d1d76c 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -11,6 +11,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
@@ -654,6 +655,7 @@ static void __init kho_reserve_scratch(void)
 	if (!addr)
 		goto err_free_scratch_desc;
 
+	kmemleak_no_scan_phys(addr);
 	kho_scratch[i].addr = addr;
 	kho_scratch[i].size = size;
 	i++;
@@ -664,6 +666,7 @@ static void __init kho_reserve_scratch(void)
 	if (!addr)
 		goto err_free_scratch_areas;
 
+	kmemleak_no_scan_phys(addr);
 	kho_scratch[i].addr = addr;
 	kho_scratch[i].size = size;
 	i++;
@@ -676,6 +679,7 @@ static void __init kho_reserve_scratch(void)
 		if (!addr)
 			goto err_free_scratch_areas;
 
+		kmemleak_no_scan_phys(addr);
 		kho_scratch[i].addr = addr;
 		kho_scratch[i].size = size;
 		i++;
-- 
2.25.1



