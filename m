Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62461C87FD2
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfLTFSCW86Wgx2nidkQBS01I46sgF7sVqpxanHH1xxI=; b=yGejNackSqoRqI93rW4W0n8SZX
	mY3pZadSNZtDfLkh72dIF49NbPasK9w3DjFmwFh09rpjszVkJA7VBi07D+u+2nUprj94dhyV0erv4
	+cZ8SzEVo9f5ah8MNLX1cwHl5Oc04dUI8RpJxxhnvhxa3QU+MH7ISur0wS2u4x0F5dMVucmLP/eTM
	tRRs8/jg6sSgoAsChPvhmlOdxrgO0yPq/j3oUXIu1AXM7dCiVu39GlEZjhHqU/4PwQLpsvVrKJ/Zb
	DoPdbvGoIf6CkrpXZzF8dnK60H14BwJLxu+iSLT1D2HSmXnsMJApoGdyjILNfg2DCn+ax35Dg3gUi
	JEorMiTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKc-0000000HCxe-0dKG;
	Thu, 07 Aug 2025 03:30:18 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKa-0000000HCwl-1qgw
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537385; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MO6/KIrkrakodQEIoOc6P8dpjiGqkXBOz6pTf3uZbESCEgisvoXfoOjKC0pKoKw6ZJtKpAi0jPeAD8dfJXWHtnBN426B8E5zF9z+Rx9fKidIBi8aeBwKkK0FHYKo1fwEds6O29JLCpt0ZYDXmIlVC3sxR2udqeDGneBHDYNIL74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537385; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sfLTFSCW86Wgx2nidkQBS01I46sgF7sVqpxanHH1xxI=; 
	b=JK5bwXYyC9tMprYRnowGyaCH0y2IGK7jHdQmMf+vzVeHIra4If3EXZRVJYB2iwlGULzmMYKGnKMxYqtps1U7jcY+P/NInDHWMLUQzS+pzHF0rT1nIeFgXFOJCWr7WaOOxIx9hMhPw19+S1Cz+2ZIzD+s/B21HUFTEAdl1HxqkB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537385;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=sfLTFSCW86Wgx2nidkQBS01I46sgF7sVqpxanHH1xxI=;
	b=WDI+WeJQG1h4uLBBLJ4oEM6ystFYmxoCNONhEHwHHWojqbdSDPaNembqLJBvCZO4
	QXuHOTqAg7amRdWonfoUQdDC9sqUXywux6Ck8zJYsgpmIo31CyLQ2jPTSJUlHyn6WQO
	b5t+cmBQ9sKyt2A6mYYxqcaOcaE45D+jy6Bw+JCk=
Received: by mx.zohomail.com with SMTPS id 1754537382409510.66082848786345;
	Wed, 6 Aug 2025 20:29:42 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 6/6] kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace, ocasionally introduced in aecc554e7ba8
Date: Thu,  7 Aug 2025 03:25:10 +0000
Message-ID: <20250807032510.4211-7-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
References: <20250807032510.4211-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227dce2fe5ec86923b4645575050000002aeeb9a0817661bee38fdd94308f50e339f69d6f6dace4d4:zu080112275a07f8364c037497dab823f20000dfb013c62ffe7b0c7b58b2d429b3e1e0aa54d324a352bba6fd:rf0801122cb563435a17d4eaec04f426c70000784b44c44d7f4d217b35fde99a646bb28a81da0e83f94c7e36b1e7e8ee81:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_203016_544830_27E0A87C 
X-CRM114-Status: UNSURE (   7.71  )
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


