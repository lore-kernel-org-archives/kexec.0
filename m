Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF6CA0EFD
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jFxkwS7N4L/8M3zBZwS9Dvfo3gXnK1kZEGJOn0mIpFw=; b=lFYNaAapkBjW7e8v9vwNk/attk
	nmfRFLPfHV/aLvPDTR6jNl1jpFNFukA8jiFUYTt1dj+2AAg0QYqLW3C55uqcnbJj+vg2KlhZ+MVdY
	XZ56qZ5FmBxU0l8MXO0BO1udKqf4uFfPT8QTsWtbLNHS/JqEoUw0JziIkRkHv8OfRBBWQz3TXvFDN
	kk721QT/DCc4t5ZYKM9ZIE3hOJlpdSmlb6FXo0gFIqg2e4C7S4DkcDn2M//D9DH+EQciYDoCS7dDi
	JIQqEkcUs8uL5jzs73WyQrA0EZeXU5L/dQQjHxM9RNH5L0vtJxof0mL2v2ZNRPfjABRTokKvC96wy
	zvTgW/iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqx-0000000A0H2-3RK7;
	Tue, 19 Aug 2025 09:42:03 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIIn-00000009tWN-3qb5
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594360; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RvPzlJfgbNSuuioaEIHKFk+RzagCKiY3Pb0dG0WsJ0sT8hLcnxqD/5hJ8Vgm+dqzZGjqomgeL1S8M0hG3mqvsIhJdE98MA8Il6ME1H6HA9p1FKJMKtuYiSPistgzkJbbD0glqDstp81wMxaYYSrCE5S72LhATmHvQLRzLSx8ki4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594360; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jFxkwS7N4L/8M3zBZwS9Dvfo3gXnK1kZEGJOn0mIpFw=; 
	b=EisP6hUYgjL7N9xSJazx+tGKmpNhHGoCuCbVY7SD1XOyQ788NyAVE6/g4zqWmCM2oPkY6YqvMW1e5eENGsOFSlJ++cN041iUtPyJRQ/9qCypOUsgf2GxqGS/a39XbvuNutvv3GrZLGNI706JkKPyjqN9200nPFFxyZGQJBGvSAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594360;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=jFxkwS7N4L/8M3zBZwS9Dvfo3gXnK1kZEGJOn0mIpFw=;
	b=NGWkeF2FEElFKqHn5LzYobA03UBSLgv0E5qSxmemRdEyohGgG99lfJ9zQ7o4byoC
	zTcGSiC9Tyyc+EDQmDdL7xEqmLocFJqrAVWCqgLzpAjWooOMxgv2bloVOvojqZHluX3
	WI8C4avbtxsat1neVITol1X4cecKtEFxEtnIdH6k=
Received: by mx.zohomail.com with SMTPS id 1755594356978325.6420762256621;
	Tue, 19 Aug 2025 02:05:56 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 6/6] kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace
Date: Tue, 19 Aug 2025 09:05:05 +0000
Message-ID: <20250819090505.647690-7-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227317cf309a018c45ecd3b70bb00008b554a3cc81770c7f895d1917c583c97449239e08ca33ae132:zu080112279137a6396e2e236241d509b40000b49eba528da180092bdc882bcd813d2dd3eab377295dbf3d46:rf0801122c616c7b88b171129502d8bf7b0000f6f4cfb58a6917408c204e39ef9f8189fcea1d8a49ea8571181a128a2c79:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020646_019894_7EE8A4A3 
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

Remove extra whitespace
Fixes: aecc554e7ba8 ("Correct string specifiers")

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


