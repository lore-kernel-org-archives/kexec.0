Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABBFCA0EF8
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/8UmlqHYmf3GKVNaBPtEU2nySt440cJM+ohdZ4CCBI=; b=yI/RFnQA+996sg7+qRAragwA2z
	w0IoNgkwNV1N80dVJaZRgOz5Q53nQgWydEooFZnC7+8YWq/GCFWltBEwHLIOrsaoX1z8cx4TY4YAL
	WpH3grArGXWWk6m2hyioGuGnF0jw3Dteu3EBM9Nby6BJJ0n8kWJby7pggkatGNqn5MAH4Z2ZSMxFJ
	AxK5sv73/OClWM9gjTYoPn6oemj2Un59BYtFyYZsM+FAl7Hw3cPvLqnm3kOCoGP5mgdlbOtgDkFR8
	Q4ddLzFlVvQgPd2iaFEBr3/NtZFv/xUHtkcVQqBF6UoobziKinkSW5jGda6FU+W9pA5FtZ/wOzqBQ
	cIuWW2uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqv-0000000A0Dc-131n;
	Tue, 19 Aug 2025 09:42:01 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIIH-00000009tSN-1Gk8
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594352; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YgRqQuasbVPyMT22D2RrW2zFp2BUvo1uh2D9JkxgbxHtWi9rdXKKtOBe0cQjq4UbuOOTU+QKYG/vFrXywck2yeotCg2L0HPiX7AkhDcvFkS4SXfHjsIiRLWBOLywDqX6bo7f2oJfCy1FR5lZT3/hkrmeB1W7cGFBRDTrTwcV21M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594352; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u/8UmlqHYmf3GKVNaBPtEU2nySt440cJM+ohdZ4CCBI=; 
	b=j9NAZMrPwdyhIr6rYRSvc7GcW5I8X4FMIFAsiKS+0CeP56ERsEDtnf70e332e1MSJiEnQk5AG3HqIRYH83B0gxX628L+ZPMv3HNBpPYb9I9lQQtPqUxV+XfBGHwLpdvKE4hpNkK1SqSAHKF79d067COdA/seXpmsMYkfIdJoTSo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594352;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=u/8UmlqHYmf3GKVNaBPtEU2nySt440cJM+ohdZ4CCBI=;
	b=Ab/l9zC0ZElxxrQqBzy8n0ykmwq9fmRRwBkctZEh750AcFe95mnSGGVmpzG4cEuh
	Cf0tfPbsj1swouNYXba06exNpdNGntLLUOhiWniThRM0ZeEyJp4deAabSMVszNjsCoz
	lk37894Ss1nI+unqnbZIjH/UagpevHOt1bI4tiFI=
Received: by mx.zohomail.com with SMTPS id 1755594349840705.7401142311834;
	Tue, 19 Aug 2025 02:05:49 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 2/6] kexec/kexec-elf-exec.c: Replace %lux with %lx
Date: Tue, 19 Aug 2025 09:05:01 +0000
Message-ID: <20250819090505.647690-3-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274f65382d43f4b3054d1cdc7d0000bf0ca12182d95dde2940a1ab71e2cef6b0677ad6e554c011c9:zu08011227d4f70f5124e02295ce25478a0000853c8f7c9622018b81d322fe767d2eb1634a32ee6a69873d18:rf0801122c7936bfdac9f9ae4f95f39f5f00003b0fe9ae7417ea0a0f8b83cb19cb13a26222f6c6f9c6559f7cccf674150d:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020613_367942_70AEA55F 
X-CRM114-Status: UNSURE (   9.55  )
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

I think this is what author meant, because current code
prints decimal number, followed by literal "x".
I doubt this is useful

Fixes: d6bc88c0696 ("elf: Support ELF loading with relocation")
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/kexec-elf-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec-elf-exec.c b/kexec/kexec-elf-exec.c
index b337642..644af8a 100644
--- a/kexec/kexec-elf-exec.c
+++ b/kexec/kexec-elf-exec.c
@@ -167,7 +167,7 @@ int elf_exec_load_relocatable(struct mem_ehdr *ehdr, struct kexec_info *info,
 	int result;
 
 	if (reloc_min > reloc_max) {
-		fprintf(stderr, "Bad relocation range, start=%lux > end=%lux.\n", reloc_min, reloc_max);
+		fprintf(stderr, "Bad relocation range, start=%lx > end=%lx.\n", reloc_min, reloc_max);
 		result = -1;
 		goto out;
 	}
-- 
2.47.2


