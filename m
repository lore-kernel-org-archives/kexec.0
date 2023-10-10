Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DEDCD8C89
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9v36xTUZZZD9WXCdWURpEbf7tNNdoxIePkvecrSQF2o=; b=V9ogfLl17ebvh/
	R7A2liqe1ueGQcZ561QHzAr1rlZQjBY+Eg4R4cXHu1h3gnrkNk/c89OPZpmCdYOQdCpDaAZ01YX6W
	IuqRENDxcBdInhPqjUbu5O957dQRQWZ73yHlxB6vMjOfP1KiKqBZUrXOuMLKZZeZNbq2QWknQseCB
	xZxfpZabM7gJWdXH6CdGpPEQzu6TKJO2HwC1gY9dzQ6joMVM6W5xm2pI7y/DNxpYivLIIH/M1PNAn
	qzz95HjA+RoWjVdQvUy1tYzkt45As0gTYqNu1albH1iAIj7mCyVycASe+6V8X/doK2+ArFsxIzUTF
	qGOUgwhm6lz1HvtfhLQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqDWE-00DXPH-0L;
	Tue, 10 Oct 2023 14:15:30 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqDW7-00DXOB-2h
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 14:15:28 +0000
X-QQ-mid: bizesmtp89t1696947305typpewhl
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Oct 2023 22:15:04 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: znfcQSa1hKYwK8XamPfdJvPiEQykmy+IsFht1Yiku9bAMoDnPeqZK5r4b7o1X
	sw7xJXOdih9uiz0J+I8e72Ed6KTs2lQ6/aRzaJ5uYyZMJcCVfwK41226C0tlOZU9kh2K9UT
	nfDTYB9knEStMZDtOLnPyYm4aiz8Va2jNI3AeGpgrrZBAGp1RFmUNrNK2XwP5LfU4COlymJ
	FVAFeuuLp6aJ5qUNsBuikqC9DDd2HhxyN5fM2KfFYYcgOOnnIJtqB4stdTPmZ6uuSJebNLz
	LisyQkMT7Zgd+7LDnkckN6aWHgsjOvrWo1FkTm2OzAns7+sdBhLMmkI5gTWnnuTcGqF6VaN
	OM4O4X20ohEEZ0abRnVia9z2/69xvBoIXb3mGPVNfs1MqYxDbM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16344369031090256494
From: Song Shuai <songshuaishuai@tinylab.org>
To: k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH makedumpfile V2 2/2] riscv64: Correct the pfn_start for flatmem
Date: Tue, 10 Oct 2023 22:12:44 +0800
Message-Id: <20231010141244.2261488-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231010141244.2261488-1-songshuaishuai@tinylab.org>
References: <20231010141244.2261488-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_071524_214462_832FD146 
X-CRM114-Status: UNSURE (   7.24  )
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

To let info->max_mapnr indicate the direct max PFN and then
make the kdump header's max_mapnr_64 correct, riscv64 port
didn't define ARCH_PFN_OFFSET.

As for FLATMEM type, the pfn region of mem_map_data should
be adjusted to start from info->phys_base instead of zero.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 makedumpfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 42d5565..3705bdd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3302,7 +3302,11 @@ get_mm_flatmem(void)
 	if (is_xen_memory())
 		dump_mem_map(0, info->dom0_mapnr, mem_map, 0);
 	else
+#ifdef __riscv64__
+		dump_mem_map((info->phys_base >> PAGESHIFT()), info->max_mapnr, mem_map, 0);
+#else
 		dump_mem_map(0, info->max_mapnr, mem_map, 0);
+#endif
 
 	return TRUE;
 }
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
