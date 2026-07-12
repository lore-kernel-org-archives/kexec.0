Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5D8C43458
	for <kexec@archiver.kernel.org>; Sun, 12 Jul 2026 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:To:From:
	Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a9BX6ALtX3lYfB/vK8r9jAuSCI92fFtbf1hzfbLcSHg=; b=tCnxOAZbvkX4p3cnqg7W9WSCV1
	3635/qaz/2pcDgB1F0+eXK8ikTDYmKsKBnqGRIJNx9+ivrGjfLV4jgQPF34n8oLLvUKySjQ4kX43h
	0zPE0TpEOlJMsGYLxejWmEVGy/B1VrlmHjZPlBlpXeBqo96Dxz/oiLDPs4aB6dyHXMwjIxFwHbYbC
	XpHzQyw47zoqg24YNxxu3otkr5V0jEj2xWsFeHnzwExpaBg2K0atJ2EiemTytJDQy/3wAd1vgDQPy
	vn29CsCuLzJz3ZlhMCG8UVnBWdTafEk1b+pbmzG4CRclRlGRmIRNj88aOtpiz0x+FDmx36Zr0Cy64
	gZaexcpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiouY-00000007F2V-2sx7;
	Sun, 12 Jul 2026 07:47:38 +0000
Received: from [45.40.48.122] (helo=[10.200.0.5])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiouV-00000007F27-44jp
	for kexec@lists.infradead.org;
	Sun, 12 Jul 2026 07:47:37 +0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] README: Add the necessary method about elfutils
From: Jinyang He <hejinyang@loongson.cn>
To: kexec@lists.infradead.org
Date: Sun, 12 Jul 2026 07:42:01 +0000
Message-Id: <178384212177.92718.12217640270750269785@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_004736_295944_A9DE531D 
X-CRM114-Status: UNSURE (   6.28  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From 64d2aee2c4654fa422633a683c1c3f2a8d3bf3a9 Mon Sep 17 00:00:00 2001
From: Jinyang He <hejinyang@loongson.cn>
Date: Tue, 18 Aug 2020 18:10:23 +0800
Subject: [PATCH] README: Add the necessary method about elfutils

In dwarf_info.c: 20, #include <elfutils/libdwfl.h>

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index f83717f..f69fe43 100644
--- a/README
+++ b/README
@@ -18,6 +18,7 @@
      #
      # mkdir /usr/local/include/elfutils/
      # cp ./libdw/libdw.h   /usr/local/include/elfutils/libdw.h
+     # cp ./libdwfl/libdwfl.h /usr/local/include/elfutils/libdwfl.h
      # cp ./libdw/dwarf.h   /usr/local/include/dwarf.h
      # cp ./libelf/libelf.h /usr/local/include/libelf.h
      # cp ./libelf/gelf.h   /usr/local/include/gelf.h
-- 
2.39.5


