Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4953C48285
	for <kexec@archiver.kernel.org>; Fri, 26 Jan 2024 00:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=L4eqUIYKFj0/pVW7u460WyLzRL1/4zXF5hwEptDs004=; b=LoajtoTbh7S6dy
	TmKO85Isx0+QWccSmGrKWUj0AaAb9fLs9lbr4CgicXjANMcONkyUQ8HZ+aLnuBr7kiyG8G7p+9dhR
	owsFqKhLUm6pnssqMZBx0oWqkpAQ5ujALXoHgTJxZFjGdQ/Ggnr/SEpIci/Juc8vBh1IYwlJDLVDq
	Y5pdoNEXneJjYJGLTU1Gk/Bp1uXOSqVc+aCZISWpUd7wyvo7KmyKeLDIhK0PSDnXEHecPcurUpx//
	1z+ueMXFWN7p75/X1wvbOW1QhqUrRMDvohh8UFDtZChJZITiGhvoUyiEvpUr6N3OwnOFDJdKauix3
	fcJJZns3v5Ag16K9tTZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTAL9-00000002eMj-33Qx;
	Fri, 26 Jan 2024 00:45:03 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTAL4-00000002eL3-3klk
	for kexec@lists.infradead.org;
	Fri, 26 Jan 2024 00:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706229893; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+N/pFFnbRnIeU4+MPRCb+blT+dqZFUYtBiOeotMx7lQ=;
	b=tyjmgeCu3feA3BKYobs5JABJyN8dr3JzE58j2u2jpaxR+r3eZPN7wCsjgnCi6ClgiXpcWnWwhZ4uQBSHLu2iSO9Lks8iqCIicUi3oI5+Xnw8uKWiPqtSGtSYUJFVxYp6cByt4iqRY442OFdQGAzw7TQu15wpyt1kIwm99NEFkKc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.Ld43r_1706229891;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.Ld43r_1706229891)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 08:44:52 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] kexec: Remove duplicated include in crash_reserve.c
Date: Fri, 26 Jan 2024 08:44:49 +0800
Message-Id: <20240126004449.118407-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_164459_536447_6B51D841 
X-CRM114-Status: UNSURE (   6.40  )
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

The header files kexec.h is included twice in crash_reserve.c,
so one inclusion can be removed.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index bbb6c3cb00e4..db8bdf47a2c0 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.20.1.7.g153144c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
