Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD865CA0EF5
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lodBcaZdKfGUcD7Keqjk+hlKNvxv4gIjBjQXxvLa5Qg=; b=WXZqwF6A4EaiYzQDjqc8WdJxk5
	LthvgEmInrQlrwN1Hodair0k6kHrR8CgQSR+REsIGJbe1K+uJQgPzjSn2YfIrOSJYZ5oz2bTMBmFe
	B91OX/eBUhh5nq8myc5RtZT79kK0OHAslF6TGcNFiOXY8PlBm+VWdeJ+CcaONYZjIEEI3/NJF373V
	qs+36xsbrnp9xLmBBgBM995K4mqD/42V0eT7DXIQRpCVwZC1iPWwOEl32hZFO60GMRvZvvB0pFzSc
	wvUGwx9jhF/7Om4mcWQ4jRAt6R21q/GSGOs1UzH9S7rhFngdt206Zif2XjOMkdAhaOPHIV6MuA/lg
	QzxXO73Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqx-0000000A0G8-0tAl;
	Tue, 19 Aug 2025 09:42:03 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIIg-00000009tUx-3cLb
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594359; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OqDE+I7Q2ewYuMfHjwcj6AJtpegPPWxVcEi0xCDCHGqdsMX8dknq9EE3d1cLPoVfT+p5HaWqtcaYejo5Pgna9CjCtUAuiv1pimBkYqXME0G45F+KFcWPij7hiG0RDwB/EZY9dGZEmGJPlKhjg4mSjUJc1ONyiScg+04SYYpzGWM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594359; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lodBcaZdKfGUcD7Keqjk+hlKNvxv4gIjBjQXxvLa5Qg=; 
	b=j/QI1/s5CrWaGokLWuTV8x4vZxa6rV+2zIf9MQD+nGxw6YMswX1kF4A2wAgw02cqlyOPCcIIRmjTUWkZZGuNdH90JIJOTT629SNxCWTE26YHuIZuRXzTDAyOGcswKov9Q/fU25iyCBRTV+73q50+efhlnuUvlckFqyIBvGFShic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594359;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=lodBcaZdKfGUcD7Keqjk+hlKNvxv4gIjBjQXxvLa5Qg=;
	b=PGXYLelI0xkxv/Bjaisw3c87V16MGbuMBmkZrjOMw+VY/QtXXb4NH8iMQMTNACs+
	kIfuQi0DxEkyyRySEN1gJoXX6yyElt2jpDsqt+ns2I2MbXkdJa/NNUpvp25xfAE4qYB
	n0g1o1bszFoPyfgDc20S3VMR6v3oQGx07hB6q9rY=
Received: by mx.zohomail.com with SMTPS id 1755594355046980.4313567432145;
	Tue, 19 Aug 2025 02:05:55 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 5/6] kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
Date: Tue, 19 Aug 2025 09:05:04 +0000
Message-ID: <20250819090505.647690-6-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122792f5a15764eb67648e15cd160000edeed421cf4df69da6fbb697a1497185eacc794e656ceb1ea5:zu0801122738af079433b645e017b5145700005fc738833b8bcfea31c72d3f20e9758b415b69367e95e83c9b:rf0801122cdcb9ab2ca6397ab17796fd4f0000eede8ef8aee42c9d0e06d588e5dbbdcf0a45b6d576bf1c5913fd6869c808:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020638_983475_9215BD4F 
X-CRM114-Status: UNSURE (   7.18  )
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

Remove duplicate <stdio.h>

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/i386/kexec-x86-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 9ba8b3f..4a67ec8 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -29,7 +29,6 @@
 #include <string.h>
 #include <limits.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <inttypes.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-- 
2.47.2


