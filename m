Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A37C07CA9
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oSgsim3vZqvqSYYt64TQIVV7w2oP875g9+CMpPwCxas=; b=l9ZdzjdHTTnCde
	KpcXEScBiuB0DybgNOfs/AVwgGECChKofyUFrImJjjXy0MmV/XQRiCDcM8MLnUei1taQvMgwpd6hJ
	2C2oyJli/ABaOJbxLxkts86IepMl++IVRR27AhGT0jaHKm6IldKmOUx6S3VP9bksLAeH0wC8XrOb5
	bmhB1M2ecYe4vN2snsdUO1ao/Bc5hQYzXtlH6LVCVuf5cQ/YVRa8UJBUCM9KLmQARruas8DRp7+pK
	tpbwRXolRwEWT4cQSIbgKkpQ7mCAZdL+Dvuo5dJCFhry6301aIHWWSXxsh4/mswprGex97v48L7b1
	+D6MKtz5nP4chwrriqqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7RoB-0011O0-1D;
	Mon, 27 Nov 2023 02:57:15 +0000
Received: from mail-m12815.netease.com ([103.209.128.15])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Ro7-0011F0-17
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 02:57:13 +0000
Received: from fedora.. (unknown [211.103.144.18])
	by mail-m2838.qiye.163.com (Hmail) with ESMTPA id E2BBA3C0140;
	Mon, 27 Nov 2023 10:56:53 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Mon, 27 Nov 2023 10:56:39 +0800
Message-ID: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkMdVhkYGEtMTRkfSU0dSFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c0eb555fa8420kuqwe2bba3c0140
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Pxw5TDErKy0POVYIPA80
	FSJPChxVSlVKTEtKS05IQ0pOS09DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJSUhLNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_185711_663433_CEECE818 
X-CRM114-Status: UNSURE (   9.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When the split happened, judge whether mem->nr_ranges is equal to
mem->max_nr_ranges. If it is true, return -ENOMEM.

The advantage of doing this is that it can avoid array bounds caused by
some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
extra range for crashkres_low."), reserve both high and low memories for
the crashkernel may cause out of bounds.

On the other hand, move this code before the split to ensure that the
array will not be changed when return error.

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
---
 kernel/crash_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..ffdc246cf425 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		}
 
 		if (p_start > start && p_end < end) {
+			/* Split happened */
+			if (mem->nr_ranges == mem->max_nr_ranges)
+				return -ENOMEM;
 			/* Split original range */
 			mem->ranges[i].end = p_start - 1;
 			temp_range.start = p_end + 1;
@@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	if (!temp_range.end)
 		return 0;
 
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
 
 	/* Location where new range should go */
 	j = i + 1;
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
