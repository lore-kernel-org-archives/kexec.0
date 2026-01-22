Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4EBD3EE63
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e+6gDoaU6sjJYiXvvo+102yEP3zTOi6BPXPONrmdz8k=; b=rIelTBplTc/RLN0JvbBEcgxd5P
	2dhdjprwc5cNIvvbROQ6wzI74NHdTKtodMDgcH3iE6Awu4CCiunfXj4hGI8F0xJKLSndX5XFfbgSt
	9jxTDr/2DAVrqLAZ06ej70m9XOytaQHnWJA45qUSDEhMwi+WWYVFlI4ESr6ZMaGhhwKiqfmLg0udg
	8llKWSsYzuSEok4ntAmfvYsxUPsNEOS03C3Vi3MwDGe/QocsLeNlPMY5t58BbWMrykZXencJL+qpN
	4WmYIA6cx6uUGjb4MKL2DHky9swicPxHqE350sMyGBVExY88q6Xgn2aXlRYbM9h8DKVQrxuEKGAQk
	lBJLOrZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viuk3-000000079Mh-1Cr4;
	Thu, 22 Jan 2026 13:28:55 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viujz-000000079M7-193e
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 13:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e+
	6gDoaU6sjJYiXvvo+102yEP3zTOi6BPXPONrmdz8k=; b=dC1wa78esyeMyra8fB
	Ue5iSWNlHlVvxuY3NcWOQse2SSMGWXKuMf6PBV/dz1nnHH2I/C4v74o5OT5qoye7
	M21pKWJm/hmqwHr0UcNJiKjxzX+ocJ4dj9uLykTa1YoKx5Hnu6EcPpzUexqLwxjV
	BNOA1Ag/wMheQnO8B32WwAWEs=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnE2TOJXJpoBt0MQ--.31S2;
	Thu, 22 Jan 2026 21:27:46 +0800 (CST)
From: ranxiaokai627@163.com
To: pratyush@kernel.org,
	surenb@google.com,
	akpm@linux-foundation.org
Cc: pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	rppt@kernel.org,
	graf@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3] kho: init alloc tags when restoring pages from reserved memory
Date: Thu, 22 Jan 2026 13:27:40 +0000
Message-ID: <20260122132740.176468-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAnE2TOJXJpoBt0MQ--.31S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkWr1xuFWrXFyruw4xXrb_yoW8CFWDpr
	WUJr1kt3y5JwnrZws2va4vk34fXws5C3y5Jasru34fZF13Awn2yas7ZFy0vF15Zr4FvF48
	Wr4UXrZ0v3WYk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFdgJUUUUU=
X-Originating-IP: [218.203.227.98]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxRJ0wGlyJdLrAwAA3n
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_052851_645179_2C1FFE29 
X-CRM114-Status: UNSURE (   9.29  )
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

Memblock pages (including reserved memory) should have their allocation
tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
released to the page allocator. When kho restores pages through
kho_restore_page(), missing this call causes mismatched
allocation/deallocation tracking and below warning message:

alloc_tag was not set
WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
RIP: 0010:___free_pages+0xb8/0x260
 kho_restore_vmalloc+0x187/0x2e0
 kho_test_init+0x3c4/0xa30
 do_one_initcall+0x62/0x2b0
 kernel_init_freeable+0x25b/0x480
 kernel_init+0x1a/0x1c0
 ret_from_fork+0x2d1/0x360

Add missing clear_page_tag_ref() annotation in kho_restore_page() to
fix this.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---

v2 -> v3: 
 - also call clear_page_tag_ref() for non-compound order-0 tail pages

 kernel/liveupdate/kexec_handover.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d4482b6e3cae..96767b106cac 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	if (is_folio && info.order)
 		prep_compound_page(page, info.order);
 
+	/* Always mark headpage's codetag as empty to avoid accounting mismatch */
+	clear_page_tag_ref(page);
+	if (!is_folio) {
+		/* Also do that for the non-compound tail pages */
+		for (unsigned int i = 1; i < nr_pages; i++)
+			clear_page_tag_ref(page + i);
+	}
+
 	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
-- 
2.25.1



