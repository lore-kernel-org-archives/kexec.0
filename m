Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F2DC19F2C
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 04:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yjI27iIdJf2siRZC7SSSWVbI1SXSHljKl5HyWtwR7CU=; b=zbw6lfvAYY2ag9
	pmu6vvTc6mETcuELm8gBbW03edSimiNoxPvo5BIA/Cyx85qEWmgJoxQzzigYNBiGASPWIufNuBfeo
	RGpYBwn+tpJe5eBxQw+S41EOCz29pBrJXsMuD6NPMf0UWZm82es0fzjbdBere3o8OX6lf7zBSOxpi
	kwMbWKVniK75kTMgyy6/iQZm4ERwQDFuFkSIrug0UF8cRz6ZiQRwDJsw447fV2MNpkJoTppxLk1YN
	jF5XRy5ZeOUSY7WCDmW+SSoOMkNg1lYLUcrbKXLzg9+kcZQP1OohRcWTO71j8Xs5HlY2/Asnf5pEz
	ye+cPiE0iRsNFgivXXTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN5L-001jBo-Il; Mon, 01 Aug 2022 04:31:19 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN4z-001iwI-3Z; Mon, 01 Aug 2022 04:31:00 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VL.kDev_1659328252;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VL.kDev_1659328252)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 12:30:53 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: crash-utility@redhat.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	hschauhan@nulltrace.org,
	huanyi.xj@alibaba-inc.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V2 9/9] RISCV64: Add the implementation of symbol verify
Date: Mon,  1 Aug 2022 12:30:40 +0800
Message-Id: <20220801043040.2003264-10-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
References: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220731_213057_332391_CFEBFD4C 
X-CRM114-Status: UNSURE (   7.77  )
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

Verify the symbol to accept or reject a symbol from the kernel namelist.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/riscv64.c b/riscv64.c
index dfb3950..a5bae49 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -164,11 +164,20 @@ riscv64_cmd_mach(void)
 	riscv64_display_machine_stats();
 }
 
+/*
+ * Accept or reject a symbol from the kernel namelist.
+ */
 static int
 riscv64_verify_symbol(const char *name, ulong value, char type)
 {
-	/* TODO: */
-	return TRUE;
+	if (CRASHDEBUG(8) && name && strlen(name))
+		fprintf(fp, "%08lx %s\n", value, name);
+
+	if (STREQ(name, "_text") || STREQ(name, "_stext"))
+		machdep->flags |= KSYMS_START;
+
+	return (name && strlen(name) && (machdep->flags & KSYMS_START) &&
+		!STRNEQ(name, "__func__.") && !STRNEQ(name, "__crc_"));
 }
 
 void
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
