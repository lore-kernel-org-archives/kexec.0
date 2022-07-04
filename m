Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A554C43334
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QcS6bhjX1pz/5D2XVR39Vtj08VQUa0bGlqvLW8BZQGY=; b=UAB2uUcGyUuJku
	G/sJnZWhj2DJmlNMXzGOZwa1aX+36pQyoIfZqJ/4siVzztTmg/q+M1+Rcii00x4NS5k9qA8j+9ajJ
	CflQkLulSFgTuu2hdpXRnuid8mAGtJRefgcEj87rM47GSUWEZC3XqvOFkOqC2iSAD/kF0/uB3/Z8M
	wMOoLxSCS87WQi9ieCANLF05tjBTEeC492CfV1c5iOaZdSv0nSOCkYPlpNtDqKpHEm8SlluBrB357
	CKPPK7E/4+dveG49eE434UoonbKMOgnEMkXXB57OlsE4Spt7TylOO2gOPxMNowVh2ydva/Cnt9V/n
	VZhIkCgGUXriymXs9sHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8KZ7-0084NC-R6; Mon, 04 Jul 2022 11:48:33 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8KSa-007vYE-89
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 11:41:49 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VILd0lZ_1656934899;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VILd0lZ_1656934899)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 19:41:42 +0800
From: Kaihao Bai <carlo.bai@linux.alibaba.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	carlo.bai@linux.alibaba.com
Subject: [PATCH 1/2] kexec: accumulate kexec_crash_size if crashk_low_res defined
Date: Mon,  4 Jul 2022 19:41:34 +0800
Message-Id: <1656934895-12334-2-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_044148_505113_BEB0B619 
X-CRM114-Status: UNSURE (   9.38  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently x86 and arm64 support to reserve low memory range for
crashkernel. When crashkernel=Y,low is defined, the main kernel would
reserve another memblock (instead of crashkernel=X,high, which stored
in crashk_res) for crashkernel and store it in crashk_low_res. But
the value of /sys/kernel/kexec_crash_size only calculates the size of
crashk_res size is not calculated.

To ensure the consistency of /sys/kernel/kexec_crash_size, when
crashk_low_res is defined, its size needs to be accumulated to
kexec_crash_size.

Signed-off-by: Kaihao Bai <carlo.bai@linux.alibaba.com>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78..137f6eb 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1016,6 +1016,8 @@ size_t crash_get_memory_size(void)
 	mutex_lock(&kexec_mutex);
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
+	if (crashk_low_res.end != crashk_low_res.start)
+		size += resource_size(&crashk_low_res);
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
