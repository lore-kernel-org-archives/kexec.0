Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E21CC52D7C
	for <kexec@archiver.kernel.org>; Wed, 14 Aug 2024 02:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c5TbFksVh5xZ+aFeH3d+aEV8VxIWNaiUiA+SRqmXkqw=; b=cmLOwfsGmQwJUG
	7FaG2RolXJ8S6jpTSrV4198r9J6AWeSnqDdFrrLaLSv8/ZorDEk5hfepheIe9Wh938QmlD+uSbEx6
	VDfUHbj4p569A7I/KmodC1XNVMoE1Xcm07gwR+r0ubn2k/9rp+dN1uuK4W6io5SBom16q5yMBZQjs
	0UrOBMksIbseFMHFxyRipDUShzBDqH8rDNGnTwhbbGh6TM4aDim3YQST6hCzjIlfoIduJWAI5hWWf
	WQmgF6GHmZupj9UyjmgyTfvMW/AdBMHCbNSL+e2TNXVuUb264WCixZdPMPvpaMcaTKFZvFOoJCDIh
	RaSg7D197ifn2oVAWL+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se3z8-00000005VxW-21aj;
	Wed, 14 Aug 2024 02:43:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se3z7-00000005VxH-0ZuK
	for kexec@bombadil.infradead.org;
	Wed, 14 Aug 2024 02:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=SSbDTbe+gNIrf61LdU18W+q4DDWFA6JUexQE3t3NKZY=; b=Kp0Z9K5BPVonQmKxqV2CPIWUw5
	RQYJeq8YgaDQRNe09WR00kgCCpjcpHyApcDP2cY2vuOyeVUTaQeirHI2mXdYZ5183aIfXQynX9IQP
	25Xk+3f5VBfw0vYIRtpJGBumUb/2P4wYd0UqQ1bdajaDKSbgO62RkjTlRZS2h8fMZol+zm7iQ5077
	/w81bJOFEGn5UHaG13u3tZeUuoIztujHh9K5PhmwuCWLkqHK6NzA8k8a6MXIQFs98BiLJTvDY2iwt
	U1pEOJXMIw2YWt6vu93Xg9grQVpsHBJPNGr6nojg40zvB8I2aPOjZo2rSsNrvFuyTxGLyFoqW6WW9
	JjYxd5pg==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se3z1-00000007twg-364s
	for kexec@lists.infradead.org;
	Wed, 14 Aug 2024 02:43:35 +0000
Received: from loongson.cn (unknown [10.180.128.250])
	by gateway (Coremail) with SMTP id _____8CxKJrFGbxmEAYTAA--.8956S3;
	Wed, 14 Aug 2024 10:43:18 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
	by front1 (Coremail) with SMTP id qMiowMDxkeHEGbxmvxQTAA--.24301S2;
	Wed, 14 Aug 2024 10:43:16 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com,
	lixuefeng@loongson.cn,
	gaojuxin@loongson.cn
Subject: [PATCH makedumpfile] Fix incorrect PFN exclusion when LOAD segments overlap
Date: Wed, 14 Aug 2024 10:43:15 +0800
Message-Id: <20240814024315.3166766-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CM-TRANSID: qMiowMDxkeHEGbxmvxQTAA--.24301S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEJEma7S-QKfAABsO
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw48tw47JF15Kw1xWrWfWFX_yoW8ury3pr
	yxKasa9FWrJr93uFy3A3WrG3WrXrZYkF4UJa13WrnYy3Z5XF1rJr47t3WrWFn0yFZ7W3Wa
	vrWqy3y8Gr129agCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UCD73U
	UUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_034332_695323_4D4E2DB0 
X-CRM114-Status: GOOD (  10.89  )
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

When iterating through LOAD segments to exclude pages in
`exclude_nodata_pages`, simply using `phys_end` to track allocated
PFNs can lead to the erroneous exclusion of valid pages from a
subsequent LOAD segment if its `phys_start` overlaps with the
previous segment's address range.

This patch addresses the issue by checking for such overlaps with the
next LOAD segment's physical address range. If an overlap is
detected, we continue including PFNs from the current segment until
reaching the end of the overlapping region.

This fix ensures that all valid pages within overlapping LOAD segments
are correctly included during PFN exclusion.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 makedumpfile.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ce0d40e..f07f831 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5207,7 +5207,7 @@ static void
 exclude_nodata_pages(struct cycle *cycle)
 {
 	int i;
-	unsigned long long phys_start, phys_end;
+	unsigned long long phys_start, phys_end, next_phys_start, next_phys_end, overlap;
 	off_t file_size;
 
 	i = 0;
@@ -5222,7 +5222,25 @@ exclude_nodata_pages(struct cycle *cycle)
 			pfn = cycle->start_pfn;
 		if (pfn_end >= cycle->end_pfn)
 			pfn_end = cycle->end_pfn;
-		while (pfn < pfn_end) {
+
+		/**
+		 * phys_start                        phys_end
+		 * LOAD[ 0]           200000          2186200
+		 * LOAD[ 1]           200000          ee00000
+		 * LOAD[ 2]         90400000         b8a00000
+		 *
+		 * In the above example, When iterating through LOAD segments, simply excluding
+		 * already allocated Physical Frames (PFNs) based on 'phys_end' can lead to an
+		 * incorrect exclusion of valid pages within load[1], particularly in overlapping
+		 * regions between load[0] and load[1].
+		 */
+		get_pt_load_extents(i + 1, &next_phys_start, &next_phys_end, NULL, &file_size);
+		if (next_phys_start == phys_start && next_phys_end > phys_end)
+			overlap = TRUE;
+		else
+			overlap = FALSE;
+
+		while (pfn < pfn_end && !overlap) {
 			clear_bit_on_2nd_bitmap(pfn, cycle);
 			++pfn;
 		}
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
