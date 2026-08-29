Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1790FC61DCB
	for <kexec@archiver.kernel.org>; Sat, 29 Aug 2026 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wz7+7SfAwm+Ay+aK6j1SVfNDgURClPZSCl87RGa2iu4=; b=WriMP7QPv/jvjbd0JTa7oUaQIt
	g24CWCi0kCCvJjmyAswwd4ZY638I/z0dFX0MHv225PAAHSy2zdQUKr3HzqWEUW5fqWfVUdd+4tW7K
	av9oi4IA2KGax2KG5dhhm2uIQESPw1JTUgnKUQ2AnGraz3Apm719URtLh6uGkOSmbmTUe7iTLljFs
	BhVe9UKjz7Wvxwu4J0Til03jNSwswpIZxMY21l8Xi7KzjIcJfb/3vrQUK3DeYGKQahfqDGX+rqY3e
	JA6nXr57TNeVK6Gwao9Tbd3d0DeH/TjXiK1EwJFrst2R/PkR+evMSOX5WtfuO1Z3EhUeE0EVtXkzG
	aQdESCmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Feu-00000006tbj-1Tq1;
	Sat, 29 Aug 2026 09:47:32 +0000
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Fer-00000006tbH-3Iy0
	for kexec@lists.infradead.org;
	Sat, 29 Aug 2026 09:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:Cc:To:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wz7+7SfAwm+Ay+aK6j1SVfNDgURClPZSCl87RGa2iu4=; t=1787996849; x=1789206449; 
	b=97XdPYOzeC9Yn0C8Vv+wDc70IM0IGZnYXxVU2f0bPaOWJFOpQIMLwIgFcC9SLZ/GvX9LqiB43jh
	pevvZLjsvTWh8lyDlGjydaTccu8qd8WyGl8s0g68BX8yFYTotZWrtSEhh9Ypvt4vl0O1VuVMKOA7u
	dtpsDy+6CxehhQkPQZgqxX8F3Qf7xwoEOzzgxh83x2fvsnQbrXfacYR5NEpPWXWLBdWROz7OUXyDa
	ZbsVCuKfnassO3FAyK03luE3CsJ5cbIlw7Au9GH1P0T7ynvlVj+8MHMz7Amd8lvrwV77fL/MPpUac
	alHKddvmIDzu4PHRrtHGFfIAbMvMXDP2j5+g==;
From: Andreas Kemnade <andreas@kemnade.info>
To: kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	j.neuschaefer@gmx.net,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH kexec-tools] arm-zImage: prepare for more malloc requirements of zstd
Date: Sat, 29 Aug 2026 11:46:07 +0200
Message-ID: <20260829094607.689485-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260829_024729_829790_867915A8 
X-CRM114-Status: UNSURE (   8.99  )
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

As there are plans for zstd in zImage for ARM, which requires more malloc
size fo, decompression, increase the space.

References:
https://lore.kernel.org/lkml/ZFDMRst2O+RJUYuu@shell.armlinux.org.uk/#t
https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 kexec/arch/arm/kexec-zImage-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 8b474dd..97db7f3 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -663,9 +663,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 
 	/*
 	 * The zImage length does not include its stack (4k) or its
-	 * malloc space (64k).  Include this.
+	 * malloc space (128k).  Include this.
 	 */
-	len += 0x11000;
+	len += 0x21000;
 
 	dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
 
-- 
2.47.3


