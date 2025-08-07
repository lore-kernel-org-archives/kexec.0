Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4664C87FD2
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nk3cpVijXmK7vnqIjeKuCz7JLaw6zOGqjbHYJufp26c=; b=jeIQu2cQMTTdIViYJvfNBI7Vwe
	5EeU0uRT38IvdpoLxRHFDy/n0b7f8YFdkuLlVbZ3PAdmV8HjIarftVzwVZHRg2p6wpzz8EgzebVlU
	HIBP07q++eUlJaRFcmurs7ArfULotCtUd20/S8pnLQmi+hgoRVIY4DEW2ymaOdjUTu2Dgq5hEB8n1
	esnC3DinizLhrmM62fhR3IfJvlP4cLQS8uisZbAo8LDczW8XFpyOaUt36Y7579osSjV1aqV4mG1c3
	27mQeXFyWbyb2xNjWZ4QMwDseYVg6Mf2yvQqHtZIWO7Jn5hNRtb4CNNqsQn347MC0KBoYZftqD9v9
	UKn5cfPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrK8-0000000HCoy-2431;
	Thu, 07 Aug 2025 03:29:48 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrK6-0000000HCoV-2drL
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537377; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nMCrCvERGkiYLX9SCI2ZWlQR/LmDE6zIJueMB1d8/Ds2nKfICIKL1GSvZW0w0Sd9qhvlta3WK471McVOdrqYw8GahEcsoKGrl90CSLsW8MzB1yoSqraElqxdy0gYM/sEyh8/Tj1F045lYQ3+/Pa8VECmEgdz3cMkEvNL9A23DYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537377; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nk3cpVijXmK7vnqIjeKuCz7JLaw6zOGqjbHYJufp26c=; 
	b=k6tYWHIbbLysoRSWvRsH74qSO2OxCWDFrUQfZRVG9bR3Cgh7U5VpQY5OdEB4uGrGCPkJmMtKSNWOckVbvYiHzW345Vi/PIUwcMSVjexqSacKQzXAStGJFf2OwWR4N9wZssLZzttwHmSN7fNc/jGd/bFTCRtkdc/kr3YKYJYKVO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537377;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=nk3cpVijXmK7vnqIjeKuCz7JLaw6zOGqjbHYJufp26c=;
	b=b+j5WQKXosYoiqEk/g8E3+pIA9nhoQFT+f4xnU3hNVyLxezsTEN8bcvtIZcfsGc+
	uTRb1Jt9QRtN53U6sno5FxFdDi0cRTBn3DCPc1YKL5FsN1aNFo/9f7wOw6AgrkOuC6R
	zK1Y/6wgB6ePajGTVtJPQcswIdM04YSsXhrPOUkk=
Received: by mx.zohomail.com with SMTPS id 1754537375062277.9879242147989;
	Wed, 6 Aug 2025 20:29:35 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 2/6] kexec/kexec-elf-exec.c: Replace %lux with %lx, this is what the author meant
Date: Thu,  7 Aug 2025 03:25:06 +0000
Message-ID: <20250807032510.4211-3-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
References: <20250807032510.4211-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cfa2c5b67dd0ad3aab55dd1500005702b6322b388a86c1b3f0220ebe03a959b9914409b3f6de22:zu08011227bb218c4fb41b22982fecf0f20000d97ad8cf1047a8e7e60bc3453270d57f682b6ee317d1d66dfc:rf0801122cdef7481df062c072934a6681000000968888760bb17e41d08970032a4589ca63cb0b71b85162dd3e8d3f570d:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_202946_703102_AD9D9C61 
X-CRM114-Status: UNSURE (   8.62  )
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


