Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A7C87FD2
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVZ926D03rUIXKcXLW7q8Ukh6CyJe2/33SMOLpcjozg=; b=A0jJO2dIY0qCBpC/1bpvStzSEV
	tj48SYt4oxA480Ffx+pBjhURhvjtX6inLCWh7ByhznxvTGnXp7/Luaat1exnEUz3ha8JRr/rjGici
	1Vm+H9a4BDpUp44gMUwVZb63jIYKd6Dk+6sEHzX2rRRmhQILXHIHQbdEdQQtaPcTgDrIZK83pOxkR
	Yy3jlfE/gX5I22DYuS9672smsmCSLJFpWKWF+0t1hCqL8pmEwDwajV/A9pGSh7ZxsFnmljaXIP0RP
	tpUJ445S5biBSfVMzRv3d43qSnwnufSLCZodXOygLK/rPRJY+noeb8Kv9wQ04bgt9PanqH2E1fkPu
	MNENuW4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKN-0000000HCtQ-1tKq;
	Thu, 07 Aug 2025 03:30:03 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKL-0000000HCsd-1HUy
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537382; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l+tybU4qSfo7DfvrquwWZITURSa4GVRpM/7Kkk38iLBvTWrxnIg3h07QWCMi7pQiGWCU5jSNO7eO2wOQ+WCInw+GBADco/ZkgIkgPlRKlBa00v2MVCGzoL499g4yxVegILJNVWk4gRQPFnmwDc9Vp6QjxEmfGXOcYD5FoL77i2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537382; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TVZ926D03rUIXKcXLW7q8Ukh6CyJe2/33SMOLpcjozg=; 
	b=SJGWCCxSIC3ajiG0mBRSQE6T4jlvl2H+u7WedBIrmgg6HlrHJU61o5ECkBEu7rmrpcjq0ZOJpW3St7CpIcUtYjCkg8tVXuE4rqQbyQY1UxOuX2A2DxOdNvCYIFGtlv3S2Zd9kQzfO8TE5ecoefl1tdZKPyqoWwdIBNBy6K4stY0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537382;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=TVZ926D03rUIXKcXLW7q8Ukh6CyJe2/33SMOLpcjozg=;
	b=VoFOKGPpB3V+cl5FkiLDLh20Yb8aVHePyO+Pqchmo4F70X/D5Itg4ogKn1txjeCw
	vbiJituos0h54HmChuZU8XZ72IQaI93A2ONg7EjvNP6g0BML6yvq2r9ra2sniCd7Mra
	63ZWuXhllrh24x0XZy5LuuWMi7n4VdLtRkeLSdHs=
Received: by mx.zohomail.com with SMTPS id 1754537378616440.83584226233006;
	Wed, 6 Aug 2025 20:29:38 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 4/6] util_lib/elf_info.c: fix typo: prink -> printk
Date: Thu,  7 Aug 2025 03:25:08 +0000
Message-ID: <20250807032510.4211-5-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
References: <20250807032510.4211-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274addf385a69d829971cdc2920000694352eadaed96e3db4c474cb1f99b826dfb0eb93479d17b28:zu080112275d335dc5346eb86d9c1a95720000538e0a42ae00b9d402d24041999dc2a6bc88bb8392b1c0d9d3:rf0801122c67ee2b7c6ce2096a081e456f0000fdb9bfb01051e1fa084ffe32a1ccd6bdc7aff4c70b42b6e0ade1b3e70538:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_203001_405602_0FE060B9 
X-CRM114-Status: UNSURE (   8.02  )
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

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 util_lib/elf_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 0f03093..b005245 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -890,7 +890,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 				if (len && handler)
 					handler(out_buf, len);
 				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
-				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
+				fprintf(stderr, "The printk log_buf is most likely corrupted.\n");
 				fprintf(stderr, "log_buf = 0x%" PRIx64 ", idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(68);
@@ -904,7 +904,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 				if (len && handler)
 					handler(out_buf, len);
 				fprintf(stderr, "Index outside log_buf detected.\n");
-				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
+				fprintf(stderr, "The printk log_buf is most likely corrupted.\n");
 				fprintf(stderr, "log_buf = 0x%" PRIx64 ", idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(69);
-- 
2.47.2


