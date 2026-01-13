Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2ECD29DC8
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 03:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kG53ciijNmoTnssyHfq8vIOccM9yp/KKrUz9IyCeyAI=; b=M4XfcEDgMZpGN3yVmcqXlflSeY
	/m/Fa2jYS7YfN1RqOcMg8TmBsqRNMCoL+YEJDmR7yW2HvDgVj/d4yLlRvAKi6JUoKdUw83aBj99p5
	dYtz5WnIUpndxJZtaaVb8FsQBxdBLdSkhCJ+xkc9+Gtk0YAWagT5w8AlghUYhFcE4jDh+iuwCVeDM
	1yYk96XbthuUoFE/fi/7QWJjl10+/URHbF0EsNuidgiwKB4VAGDOk0SS5LcDUtB2fLpRj1UhcHDHH
	QiVbAWvGazXj8PScl1rchsX2lznqPkjuXrCUugSMM3XgAgDeC/aP/2iEbO9VgoXjp7GUSRo9X+0eG
	aSBl3h4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfVBe-00000006URh-1Rml;
	Tue, 13 Jan 2026 03:35:18 +0000
Received: from m16.mail.163.com ([220.197.31.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfVBZ-00000006UQl-0Tzd
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 03:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kG
	53ciijNmoTnssyHfq8vIOccM9yp/KKrUz9IyCeyAI=; b=VIzHpzDfyJdSbzSux5
	I1/9+g9NxthwkYv7DqlCSW6qOd6sJCanUCdh2As/A6GDW5ij84JEAT8VgzQCedFh
	RRdbDg8LY+knitxcpFzlojQPjb/dVEnLt5LaszOodbmsifYafDD1mIQhYYr71Ag5
	J9VbKNuBa8Xq9y3xLFn0SknkE=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXrf0wvWVpTNjGFQ--.289S2;
	Tue, 13 Jan 2026 11:34:10 +0800 (CST)
From: ranxiaokai627@163.com
To: graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH v2] kho: init alloc tags when restoring pages from reserved memory
Date: Tue, 13 Jan 2026 03:34:03 +0000
Message-ID: <20260113033403.161869-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXrf0wvWVpTNjGFQ--.289S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkWr1xuFWrXFyruw4xXrb_yoW8WFy5pr
	y8Xr18J3y8J3ZrZayvq3Wq934fXan5W3y3Ja4Du34fZrnxCwn7ta97Za40qFy5Zr4vvF43
	KF4UXrWYq3WY9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piOtx3UUUUU=
X-Originating-IP: [117.176.243.29]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxhIve2llvTIqUAAA35
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_193513_464265_55E51CE7 
X-CRM114-Status: UNSURE (   7.40  )
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
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/liveupdate/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cd6b3fb9dcae..2d47f2c50bd8 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	else
 		kho_init_pages(page, nr_pages);
 
+	clear_page_tag_ref(page);
 	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
-- 
2.25.1



