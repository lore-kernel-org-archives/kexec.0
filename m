Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBBDC3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LYQVSSaU/4cYgs0CO+bWeAoo0Jb/08vJXkRT/enpoBI=; b=Jtny+f7pWXjDBb
	jeR4lj0iGmiY4Q0UGX3PS+p+hJtnz114v0wdu3VzjEkFumxI3icKkeqU9zzxHpw1xG7xWp9HT07ID
	Ane6kbovrK9en/KAJQmdz+ifNZX1IgOvasiW8pbUNtdUdE0z2RrcI/ZiYiGxZjNt3VFoliUKrz7XQ
	oBX5rPlv49u1BIPpItdXQ/8aNku2jvdt4hZ1dMm3umNsFYT27dF/TbNvBeoQAQUdAJ6ZqmWMOW88+
	GTR1SlkKabaPYGDHTRJ53HbzyseKXDV7qvIWOfvtL/js2eZmXUuV1tFv9CZa0qNjSON94ZByku1Kq
	blE6BCP5NJJQucs6Uq2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpc7-00GEiZ-1C;
	Wed, 20 Dec 2023 05:59:27 +0000
Received: from mail-m12791.qiye.163.com ([115.236.127.91])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpc2-00GEgW-1t
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 05:59:24 +0000
Received: from fedora.. (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BD44F26015D;
	Wed, 20 Dec 2023 13:57:44 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kexec: Fix potential out of bounds in crash_exclude_mem_range()
Date: Wed, 20 Dec 2023 13:57:32 +0800
Message-ID: <20231220055733.100325-3-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxhPVk5IHksdTE0ZGk8YGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c85cd2dbc0276kunmbd44f26015d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Nxw6PzErFVEBDAMPCwgq
	Ng4aCj5VSlVKTEtIS05KQ01NSUNIVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJSExKNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_215922_825782_08DB1031 
X-CRM114-Status: GOOD (  10.15  )
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

When the split does not occur on the last array member, the current code
will not return an error. So the correct array out-of-bounds check should
be mem->nr_ranges >= mem->max_nr_ranges.

When the OOB happen, the cmem->ranges[] have changed, so return early to
avoid it.

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
---
 kernel/crash_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..b1ab61c74fd2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		}
 
 		if (p_start > start && p_end < end) {
+			/* Split happened */
+			if (mem->nr_ranges >= mem->max_nr_ranges)
+				return -ENOMEM;
 			/* Split original range */
 			mem->ranges[i].end = p_start - 1;
 			temp_range.start = p_end + 1;
@@ -626,10 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	if (!temp_range.end)
 		return 0;
 
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
 	/* Location where new range should go */
 	j = i + 1;
 	if (j < mem->nr_ranges) {
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
