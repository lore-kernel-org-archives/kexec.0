Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D7C6FA82
	for <kexec@archiver.kernel.org>; Tue, 13 Sep 2022 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sDQz6en+q9wPVg66NwECixhKprwxQVv0+pjnwRz/Kp0=; b=K9gENRVRfJ4ymy
	zM+kAGgBzggRBNV4MceTqu4TMinj/H+vt6DUd3ndAID/PXH59qpCFVmOZ22IwrNf8j8zMDo7LSjr2
	ZK94BuabMLnbCT8pnn/263v4S1nQs80XLCLF/WhTuaXcm0fo5U+TxOwwuPbfdw1n5CCFDD2Abd2c5
	bESY6vnER7ll9Sp7lRSimEoE9s5XLgtWJr91iEbaA9h4e4jLre4CXIdzDxb/Dp1mxvD5F5WTHgcOf
	dCMEHNAbf1T4phzl33Wrq0NKUd2Z1fbFCg/5aXRSeJesjnLsYKLL7utX19JDOEF/kqjMbJVDasSnH
	BqDBnYSjCpYzpOmxqE8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzQX-00323U-Ud; Tue, 13 Sep 2022 06:29:46 +0000
Received: from mail-m974.mail.163.com ([123.126.97.4])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzMJ-002xTn-QJ
	for kexec@lists.infradead.org; Tue, 13 Sep 2022 06:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dUKqH
	1exOk0lpXq/SvhuwXEQkuHHI1k0zmxmjV1BOdc=; b=IpzwCIgHxLNhDNGMlaSp2
	QTStWigvTg7MrDACTCpH7HDS8v14HLeL5/Go8rYzk4duPiGvLYEdZutCIvbpTU2C
	tjpHpd7eV4XtXAC/xzxd8LCpsjFotx1IXL97zS8Cnsd6eFhyjHKd4aIfYcnpK+QB
	0IEM2uBcG93YA2Kvkr+32I=
Received: from localhost.localdomain (unknown [36.112.3.164])
	by smtp4 (Coremail) with SMTP id HNxpCgBHzLU_IiBjHTGQcg--.34490S4;
	Tue, 13 Sep 2022 14:25:11 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Tue, 13 Sep 2022 14:25:01 +0800
Message-Id: <20220913062501.82546-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: HNxpCgBHzLU_IiBjHTGQcg--.34490S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKrWUtFW5Gw4xXFWfXr17Awb_yoW8Jry5pF
	18Gw48CrykWrn7ur48Jw47Zrn5Aa1UXayjqry7CF4ayrnxWw4vyrWYkFWF9F1Yvr10ga98
	XFWkua13Aa98WaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0PfJUUUUU=
X-Originating-IP: [36.112.3.164]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPgd7jFxBuB+RyAAAst
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_232524_332104_09DF30BF 
X-CRM114-Status: UNSURE (   9.81  )
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
predefined value. If parse_crash_elf_headers() gets some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

Fix it by calling elfcorehdr_free() when parse_crash_elf_headers() fails.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/proc/vmcore.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f2aa86c421f2..163cb266f5fd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,15 +1568,17 @@ static int __init vmcore_init(void)
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
+
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
