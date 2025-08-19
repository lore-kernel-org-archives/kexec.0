Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF410CA0EFE
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYw3l3+xtY7VKK79J9GWFoKvTedrp5CIJkBsfYudeXM=; b=C2EbSa6RdpeA3H/D7VMBIicju8
	x3h0GzcOpXML71p/Gale26/iV8cbIvnob1t7/hIgEVkUvSlE+6DIloQGqlg99YhZ37JlCwhIdBQeG
	2AbQznXsoKvkWHm1Pat8+ZRUUjjXg4m4aqz+5xmu/zlyZnf4R8MDjxo9Ic6QqF668rSjPjtK41MsG
	dtjJsMNO8pyjLsajuY3Vc8A4DZxcSjwSOxTebHXp6YtqaDejI+MZMLaUCJ7IewnQ9sCsNXX/i6eMs
	wB57dDGH0OqcXZ7mGfPK+Jakuxzy+Mcp+S9JtO9iU5mhNToAfOeuSKzrpTidDJfbORirbiWlG7JOK
	YLEYsYTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK9-0000000BoAS-0Fx3;
	Tue, 19 Aug 2025 23:01:01 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTvR-0000000Bdtg-3bte
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639045; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aDSWYmjZKTRRVAISzg1gqku8SU5PYqBsiQKM+CK1Yh7HQOYyY+Hhx2sg/iDxqk2wlRu/wNtG6iTdQme2CTk4jC/hr8ae/LUJ1Ryzd00cCp9kSx2RbsIgx7Eccj9ksB1Wvf92iCvLZLNCMh0sNFsbK/W4+VaSQaF6hDVz7uMDXeI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639045; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BYw3l3+xtY7VKK79J9GWFoKvTedrp5CIJkBsfYudeXM=; 
	b=gmaPFgpxPuTrBZn7luv/HczWAkfxWqyqxWhWqrgtf276ZZsvkzU23moJDuVhE5etShKrPnXXal1KNs5CLuRGe8+5NsA+v1F79KFomilgbibPb4QQ/UzIqiTEbMT2JUzt5A2XFQJ87Wt1bhSXk/53ePlnpwjiaztlWKJp9Dx3ICo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639045;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=BYw3l3+xtY7VKK79J9GWFoKvTedrp5CIJkBsfYudeXM=;
	b=F1F3418o+i6JuyqEppZTCi1Rvr2LdBP219vA++3ZQ9DY7toGGHwN7g94l1IwKvmJ
	XConhWDNHifeMJWMfuw7rQZwZtO1bVhGWR9/VgCq5uviUIpvmwVOu+nYTqbDW97eAuy
	JPSqjU3cruYIJBgl4xU9pDew6EuRJOd0OXbUajNk=
Received: by mx.zohomail.com with SMTPS id 1755639041682886.0921048488639;
	Tue, 19 Aug 2025 14:30:41 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v4 6/6] kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace
Date: Tue, 19 Aug 2025 21:30:14 +0000
Message-ID: <20250819213014.908757-7-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122729bd456a04425f4ba984e65d00005a855311eafb31f01523d87b1a7137c104cfa2bdf8510fd29c:zu08011227719674cf2b2b6711c20acd0700000fbcbaf2369af027644d7fdc1fe23e9a935b947826d5b0f1f6:rf0801122ca5bc0e63481be4f408616efd00007bbd3dedc784e4e60d76f22a7d2ca18e8d0bbe64238145f73dbb1c521826:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143125_932314_FA272BB8 
X-CRM114-Status: UNSURE (   8.21  )
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

Remove extra whitespace.

Fixes: aecc554e7ba8 ("Correct string specifiers")
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 73cb611..050dd72 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -1,6 +1,6 @@
 /*
  * ARM64 crashdump.
- *     partly derived from                                    arm implementation
+ *     partly derived from arm implementation
  *
  * Copyright (c) 2014-2017 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
-- 
2.47.2


