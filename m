Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7191FCD6E7B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QT3CI10YOMV9hUEPRhdgcJ9QvcUudLRgOrpPReLPq4=; b=jBT6BnEqD2J3eq2SvyDUI5Gbc0
	xUIKjukwPZZQIUNLFCN4IxFeFlt5+LK5rpTQKpx25BvEN57kM6kOxuewc9ICBQz0Bc/sDs9wP6L/w
	F/Hzak2lfjwzy8gtj0ly+yDoE9uM5N18OXaPG5fkm0EePSCti9VWsXH+sqU3NGPvk40f8lT+Bf18V
	I2ZzT/nN58L54epRLfC3itrfdyNXxkplVviWDHZVdJJ1/kirF30fWNDy/OCjYRj4iooU0srSAXqP5
	prjHm8CS+panrlFeb1GVnvcX1yNIOMPCAcjiBfXivlltVSZGIzWUxsIhqIAwlfyyYqscsIQfDuVES
	lJp8MtzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOW-000000013SO-20et;
	Fri, 05 Jun 2026 18:35:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOV-000000013Rf-3M7H
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 36560601E9;
	Fri,  5 Jun 2026 18:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB91E1F0089F;
	Fri,  5 Jun 2026 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684546;
	bh=/QT3CI10YOMV9hUEPRhdgcJ9QvcUudLRgOrpPReLPq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLUDm4rUgoMvsHQTE1pGmbmzwZJfnKYM4r0Fl12Iiu55XvxbEQyIPEmbsBBCSIKAG
	 SpQO6BJkJDSC6dVEv5wNBaRX43ykIXIxv4QMJKlIuqJNysvE4HD/rz32IZSeOg7lIE
	 Wkm2HwaqEWxn/T/okFVc4wz4MkgvIqqg+nCvx8y4eOMT32nFZX/HnECOpnrXZzsOV4
	 gov6d2M2CfqI69tunKAwHVdRNCZJgzC66LztW+WFKFk9v3juqRCrCnBiP4aEdpHrwF
	 rs27b8UYvAwU0ogmnnlz27raGiyjlJ1taOQx6kNCb4BbXeEoNyQPTc78Tsma1gBM1i
	 7fs6PMOVnY/2g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/18] memblock: use kho_scratch_overlap() to decide migratetype
Date: Fri,  5 Jun 2026 20:34:47 +0200
Message-ID: <20260605183501.3884950-15-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Support for discovering memory blocks with no preserved memory will be
added in coming patches. These areas will also be marked as
MEMBLOCK_KHO_SCRATCH to allow allocations from them.

But only the scratch areas passed to KHO should be marked as
MIGRATE_CMA, all others should be left as normal. So instead of checking
the flags on the region, ask KHO to loop through its scratch array.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/memblock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5afcd99aa8c1..546d7ef798b8 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <asm/dma.h>
+#include <linux/kexec_handover.h>
 
 extern unsigned long max_low_pfn;
 extern unsigned long min_low_pfn;
@@ -618,7 +619,7 @@ bool memblock_is_kho_scratch_memory(phys_addr_t addr);
 static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
 						       enum migratetype mt)
 {
-	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
+	if (kho_scratch_overlap(PFN_PHYS(pfn), pageblock_nr_pages << PAGE_SHIFT))
 		return MIGRATE_CMA;
 	return mt;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog


