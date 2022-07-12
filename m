Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6DEC433EF
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LMYUrof+iCraHXBztpMGhx2uxvfw8wbS+kiuHd0K3yU=; b=sGaxi74YxhhJfI
	pcEKRyL+pI+mS/Ckk04PiiL6/QXirqw5wtE7fwH+FG6zzLQ6C1NMn3Qhfma9W+ZG48bOxE+ZcCCQ6
	uKWjCDFj2tJsgUtnnzWU2biDS9Nmsoz1VPDpEbdwDIj3CLNFMSSpVyCRoDxc5dGLoE1K/mwNqi2tl
	M80h9HmwJOhfIICSijJDhrySM1dD9EeRjlyTFk2zxFjjx6hLy5Pr6c43J4G9F+4dhtClqVdP1kOqR
	hgtZ7DJCLgKUUrjRefYEXCpBUj0Ee+d1BuHG55CI6MGjTvB0HbXinIM0uj0IjxzYn3ehK4nozlLjX
	qPgQOdE9HxDbSgTugEIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB4HF-006Gj0-Li; Tue, 12 Jul 2022 01:01:25 +0000
Received: from mail-m971.mail.163.com ([123.126.97.1])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB4H9-006Gfi-Qk
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 01:01:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3punI
	vIPkKlM/8SU3deWci59gXZoY5NLzvTD+3wQ/HI=; b=jQ6ztP6l8lXtFdHuNcI8e
	my363dV1FP2DSjoPRiQ/KULXg4CxC6BdQ9HJnVmEQcVva6FHvpXaAlgJJMjZnmff
	7wElftY53IZCdzRjwykHkuVas7T7nNAop4esWQ9bIeeB3b88yMnDcTtmGixIy1rL
	bR8rR7s0+svSjQPfAY1i7U=
Received: from localhost.localdomain (unknown [123.112.69.106])
	by smtp1 (Coremail) with SMTP id GdxpCgCXzonJx8xiSfUyNw--.11337S4;
	Tue, 12 Jul 2022 09:01:14 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v4] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Tue, 12 Jul 2022 09:00:55 +0800
Message-Id: <20220712010055.2328111-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: GdxpCgCXzonJx8xiSfUyNw--.11337S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFyDCr1xAr1rCryUJrb_yoWkKrc_Cw
	4UKr4xX3yrGa13Gr4UK3W5tw42kw1Y9rn8Xr1xCF9rJayrKwsxWrZ7urZ3Ar93JrsY9345
	uw4SkrW7u345KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFRo8jF5mLvq-eQAAsV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_180120_294307_DE18DDC2 
X-CRM114-Status: UNSURE (   9.80  )
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

elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
predefined value. If parse_crash_elf_headers() occurs some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/proc/vmcore.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..390515c249dd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1569,15 +1569,16 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
-	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
-	return 0;
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
+	return rc;
 }
 fs_initcall(vmcore_init);
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
