Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7264CECAAD3
	for <kexec@archiver.kernel.org>; Wed, 14 Sep 2022 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ibsrdxpf5K2eO17fUoQ3zRE664CTbD8nmZdQ80Erhvs=; b=A2fZlRvqoGI3HY
	SAICVSwYxT1Kt+1AJyPAPP5I3KXqiHKVO0wwZxugaMcxbgFUmRIC9qXb6QQp8Zbx7ST4e2MbV/zYL
	apfwxMXRzipb3Uh/ZdqHH7p2b3Lmwv9ckxyC8af0DU5uST0tqB9ffnV633pZDBOqy/DYsbUqXfowW
	YJgq3LSk4dHrH+maMTOEPj9O+zv7ZUWp1t3MX+MezAw4ZOI6gnNlXDGZl02iVygcMZxDT/WJvBwHI
	Pet3R/kn78vBU14M29lXtjKs4003VY8AGZ1UBJG94MQDzo9tb/VdEo/adD28ZFXoi24IyjwzkdB1t
	Xgc8juExpxCvlF44tMdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPPb-00Er7t-PK; Wed, 14 Sep 2022 10:14:31 +0000
Received: from rcdn-iport-7.cisco.com ([173.37.86.78])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPPT-00Eqyg-E5
	for kexec@lists.infradead.org; Wed, 14 Sep 2022 10:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1895; q=dns/txt; s=iport;
  t=1663150463; x=1664360063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FtThiJd3PCD8N0btmHd91Mo6Hiu/EA4+a22lY3Na0rM=;
  b=ktUDIeSqYb+LJyC/euQ4+xNPF6iGWQ8bU6KDSIJ6JgyOx9BkqgsZf/df
   dzbT1gfRFqrXPsp3nGk/PTJI4CuQEcRUP0GbJh4oJYT2zc0UWxf9e1egi
   v4XpRmnqnSNTWdHK1rGrj5UIpRXJLEYaJ5lgZqbHs7IrErIlTe84WITPx
   w=;
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1057804954"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 14 Sep 2022 10:14:18 +0000
Received: from sjc-ads-5632.cisco.com (sjc-ads-5632.cisco.com [10.28.88.146])
	by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 28EAEIB9009250
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Sep 2022 10:14:18 GMT
Received: by sjc-ads-5632.cisco.com (Postfix, from userid 1774123)
	id 1470CCC12AF; Wed, 14 Sep 2022 03:14:18 -0700 (PDT)
From: Chetan Kankotiya <ckankoti@cisco.com>
To: kexec@lists.infradead.org
Cc: xe-linux-external@cisco.com, Chetan Kankotiya <ckankoti@cisco.com>
Subject: [PATCH] makedumpfile: mips64: Replace hardcoded values with macros
Date: Wed, 14 Sep 2022 03:13:35 -0700
Message-Id: <20220914101335.2247079-1-ckankoti@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
MIME-Version: 1.0
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.28.88.146, sjc-ads-5632.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_031423_604809_1EC3A1DA 
X-CRM114-Status: GOOD (  12.37  )
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

Replace hardcoded values of PAGE_OFFSET, XKPHS start and end address,
and _MAX_PHYSMEM_BITS with macros that may differ based on kernel-defined
values for different MIPS SoCs. We can override these macros to align
with kernel values at compile time.

Signed-off-by: Chetan Kankotiya <ckankoti@cisco.com>
---
 arch/mips64.c  |  4 ++--
 makedumpfile.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/mips64.c b/arch/mips64.c
index d541c3e..ab45b6e 100644
--- a/arch/mips64.c
+++ b/arch/mips64.c
@@ -52,7 +52,7 @@ get_machdep_info_mips64(void)
 int
 get_versiondep_info_mips64(void)
 {
-	info->page_offset  = 0x9800000000000000ULL;
+	info->page_offset  = _PAGE_OFFSET;
 
 	DEBUG_MSG("page_offset : %lx\n", info->page_offset);
 
@@ -79,7 +79,7 @@ vaddr_to_paddr_mips64(unsigned long vaddr)
 	/*
 	 * XKPHYS
 	 */
-	if (vaddr >= 0x9000000000000000ULL && vaddr < 0xc000000000000000ULL)
+	if (vaddr >= _XKPHYS_START_ADDR && vaddr < _XKPHYS_END_ADDR)
 		return vaddr & ((1ULL << MAX_PHYSMEM_BITS()) - 1);
 
 	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 2084ed5..49b9242 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -965,8 +965,25 @@ typedef unsigned long pgd_t;
 
 #ifdef __mips64__ /* mips64 */
 #define KVBASE			PAGE_OFFSET
+
+#ifndef _XKPHYS_START_ADDR
+#define _XKPHYS_START_ADDR	0x9000000000000000ULL /* _LOONGSON_XKPHYS_START_ADDR */
+#endif
+
+#ifndef _XKPHYS_END_ADDR
+#define _XKPHYS_END_ADDR	0xc000000000000000ULL /* _LOONGSON_XKPHYS_END_ADDR */
+#endif
+
+#ifndef _PAGE_OFFSET
+#define _PAGE_OFFSET		0x9800000000000000ULL
+#endif
+
 #define _SECTION_SIZE_BITS	(28)
+
+#ifndef _MAX_PHYSMEM_BITS
 #define _MAX_PHYSMEM_BITS	(48)
+#endif
+
 #define _PAGE_PRESENT		(1 << 0)
 #define _PAGE_HUGE		(1 << 4)
 
-- 
2.26.2.Cisco


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
