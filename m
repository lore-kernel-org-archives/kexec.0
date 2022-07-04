Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382EEC433EF
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kfqsi9Y/Sj3aQLmkWq5u1Ohsq/IdLjyWhCeYkodT8XM=; b=v3MQ6YPK3YCvNF
	oMMQbI/t8lFm6uKmMq89h6FRbcF6M+h89rrqUpdi2BmUfY6VIqWfGaS+NDbrB6fqQaSUYnBVQf92s
	mMd6LILWf7vBv/n+5rq3S3DnJo6+YtZIFB0capLT2V+8nl0VphXqcT9CUVD3DbBPSmiGyiJTIkwiJ
	GQOGjKDN+cV4UKMPlvLJigJK4VqMhOp7B6rQvrixenUGrB/bs45ie5Tpxhdat7ZU5+GF3i6ZQG2lF
	CNyJ3aS7ijwjlXdiGkPljz4mNqbUsrSPiMpKFFHKxeBVb4zFkBZVZHZBXNtK5EITloz0k48yI4nga
	qmKuJAOndbBWC4fk3yEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8KZB-0084SZ-GP; Mon, 04 Jul 2022 11:48:37 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8KSb-007vbS-Vk
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 11:41:51 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIKqSvs_1656934902;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VIKqSvs_1656934902)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 19:41:45 +0800
From: Kaihao Bai <carlo.bai@linux.alibaba.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	carlo.bai@linux.alibaba.com
Subject: [PATCH 2/2] kexec: release reserved memory ranges to RAM if crashk_low_res defined
Date: Mon,  4 Jul 2022 19:41:35 +0800
Message-Id: <1656934895-12334-3-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_044150_260033_94B52EEB 
X-CRM114-Status: GOOD (  16.12  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

If reserving low memory range for crashkenrel, the range could not free
to System RAM all the time. However, the high memory range corresponding
to crashk_res can free to RAM through /sys/kernel/kexec_crash_size. If I
write a smaller size to /sys/kernel/kexec_crash_size,  the exceeded part
of  the new size would be released.

To support releasing the low memory range,  we should determine whether
the new size is greater than the accumulated size. If not, the reserved
high memory range will be released firstly. If the new size is smaller
than the size of low memory range, we continue to release the reserved
low memory range after completely releasing the high memory range.

Signed-off-by: Kaihao Bai <carlo.bai@linux.alibaba.com>
---
 kernel/kexec_core.c | 75 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 137f6eb..e89c171 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1031,12 +1031,42 @@ void __weak crash_free_reserved_phys_range(unsigned long begin,
 		free_reserved_page(boot_pfn_to_page(addr >> PAGE_SHIFT));
 }
 
+static int __crash_shrink_memory(struct resource *crashkernel,
+				 unsigned long start, unsigned long end)
+{
+	int ret = 0;
+	struct resource *ram_res;
+
+	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
+	if (!ram_res) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	crash_free_reserved_phys_range(end, crashkernel->end);
+
+	if ((start == end) && (crashkernel->parent != NULL))
+		release_resource(crashkernel);
+
+	ram_res->start = end;
+	ram_res->end = crashk_res.end;
+	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
+	ram_res->name = "System RAM";
+
+	crashkernel->end = end - 1;
+
+	insert_resource(&iomem_resource, ram_res);
+
+	return ret;
+}
+
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
 	unsigned long start, end;
+	unsigned long low_start, low_end;
 	unsigned long old_size;
-	struct resource *ram_res;
+	unsigned long low_old_size;
 
 	mutex_lock(&kexec_mutex);
 
@@ -1047,33 +1077,40 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	low_start = crashk_low_res.start;
+	low_end = crashk_low_res.end;
+	low_old_size = (low_end == 0) ? 0 : low_end - low_start + 1;
+	old_size += low_old_size;
+
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
 	}
+	if (start != end) {
+		start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
 
-	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
-	if (!ram_res) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
-	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
-
-	crash_free_reserved_phys_range(end, crashk_res.end);
+		/*
+		 * If the new_size is smaller than the reserved lower memory
+		 * range of crashkernel, it releases all higher memory range.
+		 * Otherwise it releases part of higher range.
+		 */
+		end = (new_size <= low_old_size) ?
+			roundup(start, KEXEC_CRASH_MEM_ALIGN) :
+			roundup(start + new_size - low_old_size,
+				KEXEC_CRASH_MEM_ALIGN);
 
-	if ((start == end) && (crashk_res.parent != NULL))
-		release_resource(&crashk_res);
+		ret = __crash_shrink_memory(&crashk_res, start, end);
 
-	ram_res->start = end;
-	ram_res->end = crashk_res.end;
-	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
-	ram_res->name = "System RAM";
+		if (ret)
+			goto unlock;
+	}
 
-	crashk_res.end = end - 1;
+	if (new_size < low_old_size) {
+		low_start = roundup(low_start, KEXEC_CRASH_MEM_ALIGN);
+		low_end = roundup(low_start + new_size, KEXEC_CRASH_MEM_ALIGN);
 
-	insert_resource(&iomem_resource, ram_res);
+		ret = __crash_shrink_memory(&crashk_low_res, low_start, low_end);
+	}
 
 unlock:
 	mutex_unlock(&kexec_mutex);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
