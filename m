Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C5D16804
	for <kexec@archiver.kernel.org>; Fri,  9 Jan 2026 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UMSWWS1xemY2qzOpfGQyi+YC3F7gxVgrd+oftHsiSGM=; b=PMfq3qd5FDbU7mFW3+OuMO+SIp
	JAyZyKSUJHrRmJWcnS74kSCWwDlpZ302HHFJ9T/yDp9sTVxDsDw4p+6S9cywTAqKCBIKyci264hdN
	7452oUqE5ZLW4YKT6HMUw9tAIwK06BTNdjk35na5ftqyj7rzGMe4Te0b+xLpxN4nSnFAjvTaHQWyn
	AUHvEsljn8Eld6cS/6aL1QV9NMCWtZ6icbpYEr0vBx0vt1SzaMK6b/6ZkR00p/Y37VedwMBi5oBm4
	uM8Kqd0MeofZbXRDLz7EzGIkdxGZ2M65NFChV7SjQTvF0arxtydl9v2j6wXEGDk1QjDfaL3/MRZCo
	C+DWTAkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve9xz-000000029Z0-0F2C;
	Fri, 09 Jan 2026 10:43:39 +0000
Received: from m16.mail.163.com ([117.135.210.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve9xs-000000029We-1zIZ
	for kexec@lists.infradead.org;
	Fri, 09 Jan 2026 10:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UM
	SWWS1xemY2qzOpfGQyi+YC3F7gxVgrd+oftHsiSGM=; b=Th7qhJpAIrAk3DDEpd
	x1cmCFonCnUnap0z9I64wocaYDT5kNojEw4/hWEK0k4crNmwaqqmoPh3RKiqTv1b
	yzgNCvbGaikev28ToeS1MjO3PthIPqcTXD6t/zRi4FNjWJ9cVbHNMWc2v+axcJDK
	2mxbSDdxZsMibYVZCnFvN2F20=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3vxit22BpF9M4Kw--.163S2;
	Fri, 09 Jan 2026 18:42:55 +0800 (CST)
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
Subject: [PATCH] kho: init alloc tags when restoring pages from reserved memory
Date: Fri,  9 Jan 2026 10:42:51 +0000
Message-ID: <20260109104251.157767-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgD3vxit22BpF9M4Kw--.163S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7Cr4fXF4rXw1xGrW5trb_yoWkGwb_XF
	4UJw4jgryqkFnIkan0ywsaqFW5K3yYgFWjyw1aqFW3Ja4Uta1q9a12vrnxZry5Wrs8CFZ8
	Crn0gF90yrySqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRta0PUUUUUU==
X-Originating-IP: [117.176.243.134]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxg+U4Glg268gtgAA3W
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_024333_378863_3BD80319 
X-CRM114-Status: UNSURE (   6.74  )
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
allocation/deallocation tracking and warning message:
alloc_tag was not set.

Add missing clear_page_tag_ref() annotation in kho_restore_page() to
fix this.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
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



