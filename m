Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B44EDEBFD
	for <kexec@archiver.kernel.org>; Wed,  4 Mar 2026 01:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O06w/78QzQFDv5hj451AeQoXCtGxqRbOzwUB/Ki19oM=; b=GW8UrSh6m46FQRedneuPmF7ziS
	0cihEkrDGWRjzViAVt+KPTYan5qd7ETU7Uoz8aNEm3NR8ygX/YqWnS/ijtXSMZcmelsoqNLsnx5hC
	CgEaHZ4tfCHCLQfBUe1OakDePcRWxsU0MuvK3FYM8AZVKdfNJvZ9g9Km7mQiipBRqp6/+XNKHibR6
	aL5iCqZsTYe1qRcOBtRL3jG3agHAAmFLOn3P1dYdkl81tFzBal1D8UIsNspjbk6uh/A+VNfUh8ltp
	VNsgVkC2YiIarSznpHCeNBGpcYuQCdJRzSy/+E0cPLJIS7PAPdKZ/GKsr+0jtLOrrfmqSmRhNhOg7
	4qxT11cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxatk-0000000GEE2-2mug;
	Wed, 04 Mar 2026 01:19:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxatj-0000000GEDU-3Uy3
	for kexec@bombadil.infradead.org;
	Wed, 04 Mar 2026 01:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=O06w/78QzQFDv5hj451AeQoXCtGxqRbOzwUB/Ki19oM=; b=NiZlmvcVH9NT+dheWDkmFDlf21
	xfCK2umxeDUy2XM2eByYw4X/hL+xmiyQ07rZFPRZQgo3d14FgBuWYBZWL3CmCZrdbt+9GXxeIXdNc
	RiFp91bRbw4O2E5wktBLyfQDOssu8CSxIAxEfEEe81QxsdMRxex0lBvv+KZ2Bkd+wRjQLzTjRzap7
	49l6AGXgP0EQBWpc4NvuDpEvJlWIAfymMxpwx1Zy4mYdqI3lV1l2XbIXCFcCqimNBNBKcS42Tn5o8
	BPfPD5iWlJBckV/BQC61iE4kJuDiMcYKXFxQNR9Sa5Elo/SGJGj9ur1lNrSxjVZQBuSMlu+D5yk/0
	+rvtq7Bg==;
Received: from mail.loongson.cn ([114.242.206.163])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxatb-00000003eH7-2qf8
	for kexec@lists.infradead.org;
	Wed, 04 Mar 2026 01:19:32 +0000
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8DxNMGUiKdpUkIXAA--.22694S3;
	Wed, 04 Mar 2026 09:19:17 +0800 (CST)
Received: from ubuntu.. (unknown [111.207.111.194])
	by front1 (Coremail) with SMTP id qMiowJCxHOGTiKdp5vFNAA--.17480S2;
	Wed, 04 Mar 2026 09:19:15 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH] LoongArch: Increase MAX_MEMORY_RANGES to 1024
Date: Wed,  4 Mar 2026 09:19:14 +0800
Message-ID: <20260304011914.880120-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxHOGTiKdp5vFNAA--.17480S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAgEQEmmmeCEbPQAAsx
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFy3XFyUKr45ZFWUGry7CFX_yoWkWFg_WF
	17Zw18WrWrCa17Jw4jga45tayjqFy8AF15ZFn3WF4xGw15JF4ayr4rW345ur1UKrWDZFs5
	J3sYqrsxZw1UtosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1GQ6JUU
	UUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_011928_828603_FAE2CF93 
X-CRM114-Status: UNSURE (   9.85  )
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

On some LoongArch systems, especially multi-socket machines like 3D6000,
the current limit of MAX_MEMORY_RANGES (64) is too small to accommodate
all memory range entries in /proc/iomem.

When the limit is reached, get_memory_ranges() stops parsing, which causes
kexec to fail with "locate_hole failed" because it cannot correctly identify
the crash kernel reserved memory or necessary RAM segments.

Increase MAX_MEMORY_RANGES to 1024 to support systems with complex
memory layouts.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 kexec/arch/loongarch/kexec-loongarch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
index 2e65eb0..895809c 100644
--- a/kexec/arch/loongarch/kexec-loongarch.h
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -8,7 +8,7 @@
 #define BOOT_BLOCK_VERSION 17
 #define BOOT_BLOCK_LAST_COMP_VERSION 16
 
-#define MAX_MEMORY_RANGES 64
+#define MAX_MEMORY_RANGES 1024
 #define MAX_LINE 160
 
 #define CORE_TYPE_ELF64 1
-- 
2.43.0


