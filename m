Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843A0CA5FD7
	for <kexec@archiver.kernel.org>; Wed, 21 Jan 2026 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w/WDHKSYXm8Fddt+PSh+C072ZZ2mR98/5mghWuOHgEc=; b=vTewbW1OaT/LYgIulokplXkjnX
	CdtAjhLO0Qbd8RB+x47kYqYfSZRdRd6u6pSvv2FwTLxd2tj5ssFCTQZvN6G0JPezKD4VuSad2q/r0
	xR1xg8ZV0u4EUS9mRZYPwYBlHaQvhMLM/8AX7eb2cU8zv28uNM+mlbG3Qk8OjGA45Bw5j3KuGcbJG
	I+J04CNpfp3pTl534fgrtVwYPbjM5qRZSZDoFgODFdWwtSWw1aTsWKKUQv6cR9rJEq6bDx+oDezWv
	J3yOBdJ5OCChl4KeyU2gyyuYtx4zD07Z2Va3kKbKIoBTALQvAe3ieEnybScoimZn4saMd84XsuKgp
	T+6ojBtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viZJf-00000005bzA-3YyJ;
	Wed, 21 Jan 2026 14:36:15 +0000
Received: from m16.mail.163.com ([117.135.210.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viZJY-00000005byM-0Zrm
	for kexec@lists.infradead.org;
	Wed, 21 Jan 2026 14:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=w/
	WDHKSYXm8Fddt+PSh+C072ZZ2mR98/5mghWuOHgEc=; b=H11EW6zabDu1SOki7q
	DfOJPT+8F8W1lFgEMzRSRCSDRiA3xmPo9TLo2eko2FxeV7lHoWoKSp28ZMxGletz
	+ux56OGnr8BVOcIPtgYpn/mhAUOArjE5TDpgKRhg8QHAeXXV3NzMPZ5fpLWoK60x
	duqIyhzT4ikaLYVm9w7GdCgK0=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3oF_443Bpg3L7MA--.289S2;
	Wed, 21 Jan 2026 22:34:35 +0800 (CST)
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
	ranxiaokai627@163.com
Subject: [PATCH v3] kho: init alloc tags when restoring pages from reserved memory
Date: Wed, 21 Jan 2026 14:34:30 +0000
Message-ID: <20260121143430.175294-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgA3oF_443Bpg3L7MA--.289S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkWr1xuFWrXFyruw4xXrb_yoW8KFyfpr
	W8tw1ktayrJan8Za17ta1q934ftws5JayrJay7u34fXFnxA3Z2yas7Xa4jvFy5Gry8XF4x
	Ww4UJrZ0v3Z09aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFdgJUUUUU=
X-Originating-IP: [218.203.227.98]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxRyu+mlw4-xfYwAA33
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_063608_656696_430DB8D9 
X-CRM114-Status: GOOD (  11.69  )
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

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
It is based on linux-next 20260120. I dont konw whether this base is ok ?

 kernel/liveupdate/kexec_handover.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 43d9d2661163..8f7e09d67e1b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -219,8 +219,11 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 /* For physically contiguous 0-order pages. */
 static void kho_init_pages(struct page *page, unsigned long nr_pages)
 {
-	for (unsigned long i = 0; i < nr_pages; i++)
+	for (unsigned long i = 0; i < nr_pages; i++) {
 		set_page_count(page + i, 1);
+		/* Mark the codetag as empty to avoid accounting mismatch */
+		clear_page_tag_ref(page + i);
+	}
 }
 
 static void kho_init_folio(struct page *page, unsigned int order)
@@ -236,6 +239,9 @@ static void kho_init_folio(struct page *page, unsigned int order)
 
 	if (order > 0)
 		prep_compound_page(page, order);
+
+	/* Mark the codetag as empty to avoid accounting mismatch */
+	clear_page_tag_ref(page);
 }
 
 static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
@@ -265,7 +271,6 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	else
 		kho_init_pages(page, nr_pages);
 
-	clear_page_tag_ref(page);
 	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
-- 
2.25.1



