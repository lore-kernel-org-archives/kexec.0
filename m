Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE399CA0EFC
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xyTYpaKquP284qhGx5UCPv8/zvzZvruPN3WOyeGzwZc=; b=O3NMHrNrdoePvtd3fECEuw3fMh
	xVYFBQVZ7uWhZvkHNuc8Mxajl26rwN+XSdtdtqQkTTP7R/nHQU+NMy7E16zOusY5hkxx32wfvxNZp
	JoqlSaJYJ0swQSxERtHElR6y5cAwCgyHNYLf56JaVGhGM9wv45fEHEl9vLiy3OMRY1Xt/unhLdelc
	yTtT1aQ+vLWeWzX09t4RQCdJFWpmany+3z61dajrWt31a6r6/XvYAkwru4H+ja1hGFYzmyULYRecf
	Ee5n6WOsNJctp9WmyYuGeokQMzN++K5TJPAPL6fsr1tN2Slh9tHUN5367rGlFIza0AuoHcRqAq45C
	lxE+tVOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK7-0000000Bo8Q-3Y3X;
	Tue, 19 Aug 2025 23:00:59 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTvC-0000000BdqQ-12JP
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639038; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YKTBGMB5CVhhuSPls6SKH9S+XJzjTpZO0I1OGFwDZ1VYI1XxYX1SY9LJ16mTMRlVUM7pdjqIj0YD2TUePigLPdVua25ShZt9WK3loofCFkfsz1dz+DriOq3GdAdl9TtAq/GsegYfc15Jbkz+3+jbhA2AThf4iNSEDzaCZ3wjoWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639038; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xyTYpaKquP284qhGx5UCPv8/zvzZvruPN3WOyeGzwZc=; 
	b=XMGd06e6mu+sGB5md4qzQBX9jQSHR3ibrlDT/W/hzuAg89jffejjhn92Qj+MLO89X9hP0p47FPG6Hp1iXaX5/snadobV8VyOOm3Glu0VrDuvHe/q879u13fBtQ1w0MW5JPduE0sAE6D9VqmnVLkIonVPSfYbSdruAiQiDe7CoGo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639038;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xyTYpaKquP284qhGx5UCPv8/zvzZvruPN3WOyeGzwZc=;
	b=ADgk/nMN9F/G3gqGMftBLGKiNMq5amldklIztltRd2WItM60QqjhIMSZrlqg1zMs
	oSJaNnRKft1IxmJvUe+bdYua7VgeV6j1a2xAdbebSwYom+edG+eZXE4hBwRNONH74zl
	//91dF26nTO6z1QVXwKaoHKqXCuu2/z+qrbx5nZI=
Received: by mx.zohomail.com with SMTPS id 1755639036762805.0396705512669;
	Tue, 19 Aug 2025 14:30:36 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v4 4/6] util_lib/elf_info.c: fix typo: prink -> printk
Date: Tue, 19 Aug 2025 21:30:12 +0000
Message-ID: <20250819213014.908757-5-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112276305ff1ea4e8d6190e90208700008ccfbbb6ed843771ee010c90a659044d97c338978ec848ae65:zu0801122791516ec4c87f60298fa343f50000274b0f44365859383f77e49b17d9d8c7c9316896f870f16ffa:rf0801122c634b73c5008ede07e33933e600005c68b42e98e3d00ebe228461bbb896589f6bd6b8001c5c326b9efe6353ef:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143110_354817_89E41604 
X-CRM114-Status: UNSURE (   8.33  )
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

Fix typo: prink -> printk.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
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


