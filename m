Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B204DC43334
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6htARm8a+QcwN9oCMLowt/yXYp7LiCCba1qwkS3pmKY=; b=tmR7zUUFztUAIW
	7VTPAuNAUA7oB3bGuIvmfdocOjx8gtySeUXUv//9mUprM0XhJkVfr/XzHKRF4fpgw/2v8hIuw+67I
	6Wt0YjmUph7QQjpkKevdd5TLSyTlSI2e/GFvKxHANY+kPV4o84yAwPco1RDGslMzxGTCOIalirDPq
	wVSfaCqTcKQp86VDCnClPGsnt5L+Rlj8VD0wfYYh7CMI78KrOJKNtOwUIUlebDMDcaN9KjnX1h5KY
	/6l9ODbTZP+TUG3iQaIw4Z+3SFhhAW5AGcYv1HqYQLCRUurOrSlayNsB0IF8znH8jPfF2wbd4r6hD
	l2hBv+HKfK/dlMsfB71g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAnyd-00Gtfb-8x; Mon, 11 Jul 2022 07:37:07 +0000
Received: from mail-m971.mail.163.com ([123.126.97.1])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAnwf-00GsSc-66
	for kexec@lists.infradead.org; Mon, 11 Jul 2022 07:35:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Cj/Rb
	6wa9GFxUQqhUdh2NDMpVy+s4rRoTrJKhdx+R5k=; b=Kaw7MUWjV/9FhP0wKMv1y
	J7FdyTKnUHsOOrQAx6FUpGNRz9Vjljp4Pv0tL27WOa6KrI3fZLMZXmPVt2FGnHx2
	dH5fGdkzMSMBedQRUdSovOj83dy9CVuPSmhSBFA2k7aJeBH2q05IVTFhGAn1ZfPh
	Hyb8IkgCJ3TmrSIojgPr3o=
Received: from localhost.localdomain (unknown [123.112.69.106])
	by smtp1 (Coremail) with SMTP id GdxpCgDnPZGa0stioLW2Ng--.8571S4;
	Mon, 11 Jul 2022 15:34:58 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v3] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Mon, 11 Jul 2022 15:34:49 +0800
Message-Id: <20220711073449.2319585-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: GdxpCgDnPZGa0stioLW2Ng--.8571S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFyDCr1xAr1rCryUJrb_yoWkurb_uF
	4UKr4xX3yrGa1fGr4UKryrJw42kr1j9rs8Xr1xCF9rJa4rKwsxWrZ7urZ3Ar9xJrsY9345
	uw4FkFy29ry5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREWrW3UUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQwg7jFc7ajRQVQAAsL
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_003505_606637_771AC7EC 
X-CRM114-Status: GOOD (  10.65  )
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
 fs/proc/vmcore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..125efe63f281 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
 	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
@@ -1578,6 +1578,9 @@ static int __init vmcore_init(void)
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
 	return 0;
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
