Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068AFC43334
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 06:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zEMa85vH4mwE63kIJp2o934H/b41xkSvrDSxo4T+Ogc=; b=svkpRRVgkqo6IH
	MNM9pWq9CIVJuEprs/hZRb7nJMy/LNgPjJXYqnTsQrCs3ZJiU1RgdtWhQXzmwKZ6ZKA5i1Jp8ADPM
	vG28+5w9HoJov9OZgQrJmlY7IKxTZfDkbmmspdU95US/MxA/ZHfit6c+TU0hhAH8ADkKQuJaJZdbc
	c4aYRjKV+KncFAXv+QQPR5ycn8vQXlOeYiqnlmmb8l/kumthUKWz9XIsXpnntd3+hAJFzDM/5/EJU
	N9jSnu+nBctaMtWDUltP1XAnrdHwTBxXbiUq21W81hP+4Uf/WMsQIop7G1gchb/effiIaZqKbIYun
	8U5cmV71msoevZzkWOMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBsll-00Bbh2-B5; Thu, 14 Jul 2022 06:56:17 +0000
Received: from mail-m971.mail.163.com ([123.126.97.1])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBsli-00Bbaa-0t
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 06:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6oc7w
	O6J7QkAI8GY1btKbQzxXLENuQsZWTbIo3WwccQ=; b=qaMtvJ/XXgshzKEAJn8Vv
	kd67+FbZYRJ+WzQWGKKxIxdhEJ1gxij1O3QMADlZn2KXA7GP6ZBfcHhmzo82xb0J
	Zkxi21O3cyMDZYq1uG3fUDd+u4ptwG7AtCwOg7qP3nvqoAmtOcsDXqLJr5sa3mz/
	BxnWA+j7+zcXUsd7pyl+kM=
Received: from localhost.localdomain (unknown [123.112.69.106])
	by smtp1 (Coremail) with SMTP id GdxpCgBHKrv3vc9iXQK9OA--.2988S4;
	Thu, 14 Jul 2022 14:56:02 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v5] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Thu, 14 Jul 2022 14:55:49 +0800
Message-Id: <20220714065549.2344266-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: GdxpCgBHKrv3vc9iXQK9OA--.2988S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKrWUtFW5Gw4xXFWfXr17Awb_yoW8JryUpF
	1kGw48Cr95Wrn7Zr48Jw47Zw1kAa1UJayjqry3CF4ayrnxWw4vvrWFkFWF9F1Y9r10ga98
	XFWkua1fAFZ8WF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRDl1QUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMgI+jFWBz85v3gAAsm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_235614_562438_B20D6F7A 
X-CRM114-Status: UNSURE (   9.42  )
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
