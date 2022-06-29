Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97730C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3EDQAWtKGlY51iF0qSsqJlzAqYY6rWBFMxZ0I5uSj+s=; b=VS5GPWNoYUUQsg
	Qi689ZLH/v2Phaf8ONVJp4+26QEEW+s4OttUoJN5wIyIgVJkaC/fnMMzJHoJr0d6CAum9me/jCDYE
	/rfygaIWgJl/cNeZu3QeE/eRyyAWsvW9AfI35dkzEBMcFw//TINlTflyzMkZM5jODZn7nOKMB9NP8
	gLpRoJXqzHFeg857fT/vSZYYzkwbU8pzR5sbg5cFwYyHlbKqAo/MyPVof/p5CN9XIUhUZ8SHvykye
	BLv5Lss9JxNvBEYVFSjEXz0cilR8vIzndfc5dBmW68gBHuTM6eLhI0fY5C9pw5sZ0cRBEgFq06Z+8
	BUc9l9KhK3OF+51SOJvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ay7-00D5JN-3o; Wed, 29 Jun 2022 16:55:11 +0000
Received: from mail-m972.mail.163.com ([123.126.97.2])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6avs-00D4N8-TI
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 16:52:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sIJYq
	5d+vRuThuyqpYx/yGoalBNWWFzuL2MWoKkFzuk=; b=YKJW9lVEl+e8aqht/cwCx
	xJQbBBLQ4sj7Ya6xlB1USLu/0VaKAP6XuHws+pxYDSnap+7XSvH7EKCDFBQyw+a8
	fLaDQ2QHktF9zbDEYyLv9KFEXpuHeHQpLZMv48kdulW5HAaPe+ACT+eAXH28soXW
	TD09sp2SnlHos6T4ltLa68=
Received: from localhost.localdomain (unknown [123.112.69.106])
	by smtp2 (Coremail) with SMTP id GtxpCgAHhSJCg7xi3UbaMQ--.64981S4;
	Thu, 30 Jun 2022 00:52:30 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Thu, 30 Jun 2022 00:52:16 +0800
Message-Id: <20220629165216.2161430-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: GtxpCgAHhSJCg7xi3UbaMQ--.64981S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFyDCr1xAr1rCryUJrb_yoWfWwc_Aa
	18tF4xXw4rJan3Gr4UKFy5tw429rn09rs8Zr1xCF9rGa4rtwsxWr929rZ3Ar97JrsY93y5
	uw4SkFy7u34rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE7PEPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOQ4vjF-POPBaDAAAsa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_095256_649284_11681180 
X-CRM114-Status: UNSURE (   7.84  )
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
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..7e028cd1e59d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,6 +1568,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
