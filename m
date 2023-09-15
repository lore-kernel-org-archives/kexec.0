Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B79EE021D
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 05:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4i4oqy9oGsgstBvzw91K9UBx0Q0vLNS9y1Ve1HxCdPw=; b=rhMhv7isQkpPnp
	iXARur34Wj8TzzFxXck0Qtz2rOPR3DYujdpXCaGxJNdrn66KzCdUdlG4i0Ob+Q8ajIHQlo9NTq0w0
	B4Ee1fRNhgMWMMua+xhebnNLlwGX4Vfcb3cR5vMyKbFu5LTgHD5eTadtBOA/LbHx6esYhGrcz0hFH
	eC85rfOpIp8Xgy+xlFXMIIzFCSnGB5IqpctCCa/cN27GansYEjJxWYXHY9cKixg2VpSiqpC0d/kxb
	2dQXwwq+XLwFP2TimC/GyEXvLuochqXKjmB0b0RTyM1ZPhjcavsAcraH/h4YYOADRZn2nazJyySTP
	Zon6Z5aSN6hDd3R1Oh/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh1r0-009r53-0T;
	Fri, 15 Sep 2023 05:58:58 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qh1qw-009r3Y-2l
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 05:58:57 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vs5xRfp_1694757525;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vs5xRfp_1694757525)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 13:58:46 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: bhe@redhat.com
Cc: vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] crash_core: Remove duplicated include in crash_core.c
Date: Fri, 15 Sep 2023 13:58:44 +0800
Message-Id: <20230915055844.37935-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_225855_080920_F85074E8 
X-CRM114-Status: UNSURE (   5.75  )
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

./kernel/crash_core.c: linux/kexec.h is included more than once.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/crash_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 1a77d466eaed..90fc1b636ba0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
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
