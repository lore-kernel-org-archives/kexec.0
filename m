Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33555CA0EEB
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUu2UyZO7smbuUkwSuBOVe9R/GFhlIp8p2MWUBw0Ggk=; b=IsE1vrvNPXaKxI23bXo0oERo85
	ypsDXNCLPyrgkoL6eyOJMy9vywZrlPRUxsvaaxq9xu+2KuCzg9jOWUStMz5dW3UYu8Oijtg7x5nNm
	Q3CNy7DdiYFkh9J8c3aGu/eXPv4EjwG8Sk+J1kgJ/ImIirdt8cPKQenDaaeouaD3XkVQMt0a0d272
	Tvat9aFXEToS9fzGARrDRemhxqcjWdFmvBvrGKTl1suTAQopJAog7GOwlRfRPl9vnV6dDWmJsZ+L4
	OxDiIwlYVzbjpRdQtzVyqXcteDaGJk/xBKCglyA27AFRDv/4BQZnO15Z+0Ab6nWnDYy6Its5ibX/4
	jHyWWLwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK7-0000000Bo7i-0JBD;
	Tue, 19 Aug 2025 23:00:59 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTuu-0000000Bdod-1sMs
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639034; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nep60vAKYLyu108TIzda6odEbtr8V1mYPwFOWXUEkE1I8yrgU2d7PFQJKuRwCOL65zmaitgVExd4c0p0lIH+1dVrfYEnOC27pBISWsLYKYqaEifXTDGkCx+nWL5Qg5FCA8g5mZGAmNWffq/Isbmgr+7nnXDM+M9X4v5qyEduWg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639034; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RUu2UyZO7smbuUkwSuBOVe9R/GFhlIp8p2MWUBw0Ggk=; 
	b=CAMxYZ8QL3iMvWEPjDOlUDbh/PFanHFEveUOwPGJOzfcDXDIVjGnBBAkaBjV9pcmJ4/rlWoV7rzKbKPnvnYkUGf7faEO+TmaZbMZJwscYo5VCK8EnTBsBFmZGgYTB5lgPGq3CnxNqfgXzvrvUFoR+bvuR8FVNOXynZGUX+QR0tw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639034;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=RUu2UyZO7smbuUkwSuBOVe9R/GFhlIp8p2MWUBw0Ggk=;
	b=WjValCQw1pt+JPiJoxOCXUUnw0X2d844vjsW36sn7JK44ac5ZpEKyPByP7Zsdnl1
	4FbAj4N+bkcSGfmclF1LDdgrZpyBEnQwf5/8KOpl0y8Tb8L67IDDpzpDr6RZ8eQEXFS
	/hxRnPJ89Jd1CadQLSNnVvNzbLgVRQ3NS3mYsvjg=
Received: by mx.zohomail.com with SMTPS id 1755639032571201.76242736701897;
	Tue, 19 Aug 2025 14:30:32 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v4 2/6] kexec/kexec-elf-exec.c: Replace %lux with %lx
Date: Tue, 19 Aug 2025 21:30:10 +0000
Message-ID: <20250819213014.908757-3-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274dd0e981b9e777053889babd000073c0986d093220f528ea8ee2a7432eb7a195c548839ad7e227:zu08011227327620d3f07039b0e76ce7c20000e8035ada2002e7a856ff40686c07d963f56d793fc3998fcbfe:rf0801122c5c0752f6a72f868bccfccd10000075c2b508dd13f48c7fb06a38d8bc3e424b2d94df7bc831eae347fd1d312c:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143052_552974_4BE9C3EA 
X-CRM114-Status: UNSURE (   8.88  )
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

Replace %lux, which prints a decimal number followed by literal 'x',
with %lx, which prints the hexadecimal one. The latter is more useful
for the (address) ranges.

Fixes: d6bc88c0696 ("elf: Support ELF loading with relocation")
Reviewed-by: Andy Shevchenko <andy@kernel.org>
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


