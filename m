Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F03AC87FCF
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0O8tqFCM87uUalguP5P0Q6QVkQwRk3BXTWIhbPL9Ag=; b=pKAvOjzh1hD5XYBZ6BJVHqVNvT
	++IiK2XXZeysvOllmIaUYsOnVlDXqg7M7sVpc/Qx5IP7Yr50dysVwpmZw+4nf1uqNGsGfOx7an7Zy
	LZ+v0GNCJxVSE20oFeHJwqXRmT1/aO7hb+Gs3nwa9uWogcK77B3PT5gNlDc+9T1vIkfLDhyi/hlq3
	RC8FPMykIYTsak8jcu7hMOan+yI/s6BXDmWjRMrsBSaCQI8vqDEQhrFJs06L312mHG0QwyuftfImR
	rRBIbfhOBWXSC7BRgGNNr1tyHMYaoqZ4AHqvpQDqs2VkJRtE8fU4MZel1SqlPFGUmE6k9PQZdUsNf
	XWKjPHSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKV-0000000HCvX-3NVs;
	Thu, 07 Aug 2025 03:30:11 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKS-0000000HCuk-3tD8
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537383; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N5wNkiqJfARQMEvfHs1VUI+ZP/I6QRmvLhbFJNruKDYNbb2IukiPcDehZdX9Uo4c7ySaGnyyiT93XfT0LvkC2b7IB74S91dbe3FykAJQHWYyJxtMWh26DCgeoaVcvaWaUQvo24HXMHH52mRMASR64fLGzYCe5H0iM/U3AFBpbak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537383; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b0O8tqFCM87uUalguP5P0Q6QVkQwRk3BXTWIhbPL9Ag=; 
	b=IOWBomuRnt3m3bajpl4yJ/m81fm2TRm9e8J12eI9TuBj606KGP39AGB2aJy3vtTTHIML/cF62228Taj+inCcKp4zO3OGTD+ZhM0l9zLr+kvAgmPWM0Jomv3FDu553uWfmF+GEzIOOw0h2RxI4uMK8OCuESYT/GP5X+eZTKh6uZw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537383;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=b0O8tqFCM87uUalguP5P0Q6QVkQwRk3BXTWIhbPL9Ag=;
	b=VV78MogGK/4/YcykqQZvHifUS7+UpI+1mtUSPq6EeBfjeuhKg9lUFOfHsCjolnuu
	Y+bln68okP+Fludaf/p9rK3CKN0BxvhHO12gkA7aZxh2Zud57qhwJVZ0TDHKFK+D300
	LO539L8Ig8ysU/IVtt+fo+PatZLCVJLznw7MKno0=
Received: by mx.zohomail.com with SMTPS id 1754537380591737.5885343702745;
	Wed, 6 Aug 2025 20:29:40 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 5/6] kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
Date: Thu,  7 Aug 2025 03:25:09 +0000
Message-ID: <20250807032510.4211-6-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
References: <20250807032510.4211-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112275f252f1319508c1260e7d2670000499adbb1c3c13fea28e2d8190e8ad1b8d6bd87b5ea4e32c44d:zu0801122741170c1ee8d58ca02a3c3aa500003da0a9142ae97a77a72e346c25f60126c49e4a48daf66d7e1f:rf0801122ca0403c41c9cf904b7576f2490000f418522e23f571eb4e0ffdf958052b88246bbbcbc865c0b881c712c4f72c:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_203009_024501_1B09C8C9 
X-CRM114-Status: UNSURE (   6.77  )
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


