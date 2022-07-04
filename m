Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F1C43334
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bwNK8c64VbA74wu4CwC0TCp0W6c/Gl474zXfqq/G7G4=; b=z9aIyqwVTbg5Jl
	p0r4C0qTWBnxEL8hgdGZGxldbx9uR2rxcjN7PCF6bTALSRZgnojBznre8ItdGiaFPdEwieFuGeIEK
	G/tHwAxO9HNmsG9NW4RF/KLsPYtd3h+sxrbMFXd726ORVXe+KxPkuqr5dxq4wFdcDNNKeqhzjnjG7
	eLnTeuduWHqNYhj3twKEAlc29m+O4bPb8mHrgVYt59uj8Fg4vpfpUVE545XPGhzWL8o8SZOyaKf0z
	U6yI88HDiJfDgLrP9AsJwUkzjGH4rAmr52joNLJ342zNYib+HwLokXMNbweuSqs42bzkZwUMhelvm
	EkueFC0skMb3HvxW7LAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8HIQ-00619I-96; Mon, 04 Jul 2022 08:19:06 +0000
Received: from mail-m975.mail.163.com ([123.126.97.5])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8HIN-006150-4e
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 08:19:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Annf+
	CpGtxX7J5YiGisq08DgMf6VciPGfyVKNVzY0eM=; b=aWBFwJl+YjL2aI3O18HP0
	uZTDhOo4jgMeV5EZM4nI+10hTqfWA74jHCK50nhs/Bn6G74biWLtfKr397VBrRgZ
	GB3FteUdzgpMhWSsnWCOlytW4goRNJdZ5CwnpKZRamDCwpA+ANV8HXjlhEAaJ3x1
	Me1+xECR1mAooIBidD81yA=
Received: from localhost.localdomain (unknown [123.112.69.106])
	by smtp5 (Coremail) with SMTP id HdxpCgD3_QpgosJiXllzMQ--.46554S4;
	Mon, 04 Jul 2022 16:18:53 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v2] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Mon,  4 Jul 2022 16:18:39 +0800
Message-Id: <20220704081839.2232996-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: HdxpCgD3_QpgosJiXllzMQ--.46554S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKrWUtFyDCr1xAr1rCryUJrb_yoW8JryxpF
	WxJw48Cr95Wrn7ur48Jws8ur1kAa1UXay0qryUuF4ayrnxWw1vvrWSkFWF9Fn0vr10ga98
	XFWkuw43AFZ8Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRDku3UUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMg00jFWBzzIEVgAAs8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_011903_652962_B5391D94 
X-CRM114-Status: GOOD (  10.60  )
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
index 4eaeb645e759..86887bd90263 100644
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
@@ -1577,6 +1577,9 @@ static int __init vmcore_init(void)
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
+
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
 	return 0;
 }
 fs_initcall(vmcore_init);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
