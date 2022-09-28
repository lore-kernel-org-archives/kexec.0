Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD320C54EE9
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 02:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EeHUqcEPoaL+MzUwoAcFiLQC20awdka9Wx2WCyblZuw=; b=tZseHeQ9hDcVL1
	cZbDJOc9Jvj9fglcdjA++CBThxPxywML6UaTXYHZunGZFiFORlZbe0WL2f0YtKYyIQSlLqWaSXX+o
	jYC8uM4w4dpwe8NXMgsd3meCoy3zVcEW7hrBuifI3khBrVNpSF1odn6ETxEtB4nwZcUoGp6c9GjdK
	UlykvnW+UTs/87D9FX2WpegM1wkDVWDb5pI31RlX1TfP9QBwn9WrlxKwXueMhy8Nxk4W44rWC+Bkn
	mDxagdeO0JhxdPfIhxmMr6vuTLMEGtVIQsHbPevS5uLPAjCN1Bm70exH3t9fs7kxqjdlxk85vweOe
	3qndrxxRbtHSDSLxmp0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoT-00DaIE-Jc; Wed, 28 Sep 2022 02:28:41 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoP-00DaDI-Vc
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 02:28:40 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJKsTNjXAwjAA--.65269S6;
	Wed, 28 Sep 2022 10:28:30 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 4/5] LoongArch: Add purgatory framework code
Date: Wed, 28 Sep 2022 10:28:25 +0800
Message-Id: <1664332106-4845-5-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxBOJKsTNjXAwjAA--.65269S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW5Gw47Kr15AF4UGr47CFg_yoW5AF4kpa
	s7ZFs5tr48J34xKr1kJ3y5Xw4DXF1kGryaganIvFW0kFnrXrnrXr1xuryDZF18X3yUCry8
	WFWrW3W2qa18Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWx
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0T7K3UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_192838_442595_3F368677 
X-CRM114-Status: GOOD (  10.97  )
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

Add purgatory framework code, no specific implementation, just consistent
with other architectures.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 purgatory/Makefile                             |  1 +
 purgatory/arch/loongarch/Makefile              | 10 ++++++++++
 purgatory/arch/loongarch/console-loongarch.c   |  7 +++++++
 purgatory/arch/loongarch/purgatory-loongarch.c |  7 +++++++
 purgatory/arch/loongarch/purgatory-loongarch.h |  6 ++++++
 5 files changed, 31 insertions(+)
 create mode 100644 purgatory/arch/loongarch/Makefile
 create mode 100644 purgatory/arch/loongarch/console-loongarch.c
 create mode 100644 purgatory/arch/loongarch/purgatory-loongarch.c
 create mode 100644 purgatory/arch/loongarch/purgatory-loongarch.h

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 15adb12..4d2d071 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -28,6 +28,7 @@ include $(srcdir)/purgatory/arch/ppc64/Makefile
 include $(srcdir)/purgatory/arch/s390/Makefile
 include $(srcdir)/purgatory/arch/sh/Makefile
 include $(srcdir)/purgatory/arch/x86_64/Makefile
+include $(srcdir)/purgatory/arch/loongarch/Makefile
 
 PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
 
diff --git a/purgatory/arch/loongarch/Makefile b/purgatory/arch/loongarch/Makefile
new file mode 100644
index 0000000..b0c47b2
--- /dev/null
+++ b/purgatory/arch/loongarch/Makefile
@@ -0,0 +1,10 @@
+#
+# Purgatory loongarch
+#
+
+loongarch_PURGATORY_SRCS+= purgatory/arch/loongarch/purgatory-loongarch.c
+loongarch_PURGATORY_SRCS+= purgatory/arch/loongarch/console-loongarch.c
+
+dist += purgatory/arch/loongarch/Makefile $(loongarch_PURGATORY_SRCS)		\
+	purgatory/arch/loongarch/purgatory-loongarch.h
+
diff --git a/purgatory/arch/loongarch/console-loongarch.c b/purgatory/arch/loongarch/console-loongarch.c
new file mode 100644
index 0000000..af34ecf
--- /dev/null
+++ b/purgatory/arch/loongarch/console-loongarch.c
@@ -0,0 +1,7 @@
+#include <purgatory.h>
+#include "unused.h"
+
+void putchar(int UNUSED(ch))
+{
+	/* Nothing for now */
+}
diff --git a/purgatory/arch/loongarch/purgatory-loongarch.c b/purgatory/arch/loongarch/purgatory-loongarch.c
new file mode 100644
index 0000000..abe9297
--- /dev/null
+++ b/purgatory/arch/loongarch/purgatory-loongarch.c
@@ -0,0 +1,7 @@
+#include <purgatory.h>
+#include "purgatory-loongarch.h"
+
+void setup_arch(void)
+{
+	/* Nothing for now */
+}
diff --git a/purgatory/arch/loongarch/purgatory-loongarch.h b/purgatory/arch/loongarch/purgatory-loongarch.h
new file mode 100644
index 0000000..cd1ab97
--- /dev/null
+++ b/purgatory/arch/loongarch/purgatory-loongarch.h
@@ -0,0 +1,6 @@
+#ifndef PURGATORY_LOONGARCH_H
+#define PURGATORY_LOONGARCH_H
+
+/* nothing yet */
+
+#endif /* PURGATORY_LOONGARCH_H */
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
