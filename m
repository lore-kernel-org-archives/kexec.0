Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B3BCED60C
	for <kexec@archiver.kernel.org>; Wed,  9 Oct 2024 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NK1AUfglfXLF6H8yn6rwPTvNXMO7nKPga0QIl7+1R3Q=; b=EJp/Qv3Z23tVBq
	PwtA37FMjPz37coQHoOcB6y0BjN5clllN65XeEGUyZ15ral+vhMmpBz3+YjrQ+BCL5gtuAjIpS+nz
	JZJIrSVFFn8kYBC0PFFVA2aggoLmC015xuzmGGJNQ+k6QX6Ly4yajEez/I8BlUDfYbIH4vOKE63sz
	LjFzNlmxXeH0uuXeuGMl8zAermITSBbhQr8nhPtZ4yL/owY7SofvOY8i9ORiuD9UdnUzTOoriF4jK
	2m+BvgetqUjvODa6tBBcNekR588VKOUXy2Va17l2/uZXAZKCwy/rf/qbZSRvv1tHo2OuICqA9XMVZ
	H2HiFFcR62TdRAR9zjTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syPuX-000000083Gw-3phw;
	Wed, 09 Oct 2024 06:11:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syPqZ-000000082cR-1Il4
	for kexec@bombadil.infradead.org;
	Wed, 09 Oct 2024 06:06:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=HPoCPBS56LAgsHD7stngFB6Z4wS4hr3u3X/2SsXQfMU=; b=q1NtRDIv6GH7KgfPyFu7sjQ3GM
	IsaW1hfHhhQOpVq8ZoSwfrlOVp+Cy8CxaPGy/NV48wOdogLniuXFLRouwgquRwfg8HzFv9+gGexwL
	A3hG4EVvV8oh5NUn9Rgz3gAcQp41JrehwsH6+49ekuIoBqKezQBqLyIJxjeNPqp66U8Lv9toDfWhD
	XeRB0rkA95tvYd4x35wzKsIo6UzRfH1BWc+jRBcLxfDs2gIoOcoxw++ohIURPMaaI6VvPZafl2PDR
	fknw8HWlADWKSUzhaR6huQTOf2Jikqk8DdaUv+BVQTxPQKCqweGDssLDJUqbu3xPfX/a0M1eFx185
	BVP7GZoA==;
Received: from mail.loongson.cn ([114.242.206.163])
	by casper.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syPqU-0000000495U-0Njp
	for kexec@lists.infradead.org;
	Wed, 09 Oct 2024 06:06:53 +0000
Received: from loongson.cn (unknown [10.180.128.250])
	by gateway (Coremail) with SMTP id _____8BxnmtsHQZn2ZwQAA--.23324S3;
	Wed, 09 Oct 2024 14:06:37 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
	by front1 (Coremail) with SMTP id qMiowMCxrtdrHQZnYf8gAA--.36903S2;
	Wed, 09 Oct 2024 14:06:35 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com,
	lixuefeng@loongson.cn,
	gaojuxin@loongson.cn,
	yamazaki-msmt@nec.com
Subject: [PATCH v2] Fix: Exclude pages correctly in exclude_nodata_pages()
Date: Wed,  9 Oct 2024 14:06:35 +0800
Message-Id: <20241009060635.1799444-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CM-TRANSID: qMiowMCxrtdrHQZnYf8gAA--.36903S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAgEFEmcFIKESjAAAsp
X-Coremail-Antispam: 1Uk129KBj9xXoWruw1UJrW8Zw1ruw4UGw4Dtrc_yoWftrb_Xa
	y0yr47u345XFWrZrWjkFW0qryrWw1fur15uFy8JrW2vay5Ja1DGF1qkFWkZwnrWw1UAFyf
	XwnFqrWfZF17uosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sj
	jDUUUUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_070651_332360_52AC49D9 
X-CRM114-Status: UNSURE (   9.25  )
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

The calculation of the starting PFN for exclusion in
exclude_nodata_pages() was rounding down, potentially excluding
the last valid page of a LOAD segment.

This commit fixes the issue by rounding up the calculated PFN to the
nearest page boundary, ensuring that the last valid page is included and
not erroneously excluded.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2fa67e7..b356eb3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5215,7 +5215,7 @@ exclude_nodata_pages(struct cycle *cycle)
 				   NULL, &file_size)) {
 		unsigned long long pfn, pfn_end;
 
-		pfn = paddr_to_pfn(phys_start + file_size);
+		pfn = paddr_to_pfn(roundup(phys_start + file_size, PAGESIZE()));
 		pfn_end = paddr_to_pfn(roundup(phys_end, PAGESIZE()));
 
 		if (pfn < cycle->start_pfn)
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
