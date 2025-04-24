Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA6AC369AB
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9Zq8FeFeBWBKtdRlyzoWVgodMMuyOILPYOiLADlmbn4=; b=jCs/9yIRaxpUsA8FWkrXR5dAVo
	12hP4v+qH33FDQVoFzmqPsH9EF0OWWmQ4HBa8QSN7HVU4FCR/kwVw5jCSZUQuY4/nOWYSNfZrxj42
	Bx2FO72/MkdMbc24iWDXpK1LRq9b2JN8XPJ0o/gScGQesfn7z1F1ZtvWQZqI3wB7JUEJ4XRr3bo34
	6g3ixPf712XRyJZkDM3zbLGybA8cvRLTN6wVMMX0HSwuLroJeyErf9+2nRfVwpxCgOV+4BM8CEVJa
	1aDiXlPjR8djlJm7WWMAs0FbPmzy3UC1WwqzZkzr4zphv9GoPbHlVJxCMM05Kzz0KFuocaoYRa3ZI
	gZpkEK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7tPm-0000000DbM1-3Cxv;
	Thu, 24 Apr 2025 10:02:42 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7sx9-0000000DVvz-1Tb1
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 09:33:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A60E0A4BCB2;
	Thu, 24 Apr 2025 09:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9258EC4CEE3;
	Thu, 24 Apr 2025 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745487186;
	bh=556K0EU4/QwmbQP9W77wsip/egh64QVcPFAANCXUnAg=;
	h=From:To:Cc:Subject:Date:From;
	b=atsnuI3XSBH/2KFZ4LUT9PZLMlLlFPFXcfB1x6Mjo5zl3sKH9Pn6PwEThU5/aPYY+
	 izj+ItP8V26CFynq+XrD2jFmC2Fa4XBeYlekja4M1TJdpba/+3NrMM9ArTGHEKfIeu
	 p8fLotOrNS9543P40hTcS6hjn6r6l2Vbq7GFA6QXlXhb/anwvYYWjZ7HcMgQHa7gPK
	 3sAtEqbvrtPv8TY+cb/ZvItcGcr8aH14PNiHydjcXr1HIIvnHsWJ2HzlNnUYOWFNxa
	 aiSwosIiO4Ew7UdQJ9p1jrYYZMEGeoaGOQmCAdNMknfY97dAFEEU00qhPT1KqAOS7p
	 gMfT5T4C6H5+g==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] kexec: include asm/early_ioremap.h
Date: Thu, 24 Apr 2025 11:32:56 +0200
Message-Id: <20250424093302.3894961-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_023307_461952_D754F853 
X-CRM114-Status: UNSURE (   9.09  )
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

From: Arnd Bergmann <arnd@arndb.de>

The early_memremap() function is decleared in a header that is only indirectly
included here:

kernel/kexec_handover.c:1116:8: error: call to undeclared function 'early_memremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1116 |         fdt = early_memremap(fdt_phys, fdt_len);
      |               ^

Fixes: ceef8de6a481 ("kexec: add KHO parsing support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: change 'Fixes' tag to the correct patch.
---
 kernel/kexec_handover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 4bbc6f5ef723..3e8a0118e182 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,9 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+
+#include <asm/early_ioremap.h>
+
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
-- 
2.39.5


