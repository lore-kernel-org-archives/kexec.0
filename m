Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EACC87FD2
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZnFJyAu0fMBU1FFsmmjSlqVDqDj3Upz6vVFBawanQE=; b=h4I1QPjfMtkxljrrCBEtt3zGIp
	vQfoWvLMMx8z91ekPHWTchKLE/vrPOLueRumk3Bcflkowi+eGK5P3xmQOQTn5criLTbjHpYL+j7K8
	XSlky/ElSgOY89Ot2oAZwp1BvwKBJ8U3QA4I5JEjMjDf852uBHnz9KwJVRlizy7PY08oVx2+xgDje
	hiwkWwSdbN6aWmNhaCjsaPmgfJvhFIDf62PTKM2v8SZ/3IlA7tJi8jAN90CNqmSjpE8k5xe2+p7P1
	T4+32uU5Hvso66aV8dSB1Q2NJ8FllBYnIWH/sHTW7U1fVd3sHy21fgyZyUP/kvyDdps2qyvaAWxmi
	ihrHtPVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKG-0000000HCqs-3XMp;
	Thu, 07 Aug 2025 03:29:56 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrKE-0000000HCq7-0TLI
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N/LIkN0RhROsgEBkYV2H1EwjVZBijFS19VMeud/zWId+dXDmNNnehu1y3VoZbWEimrRf9kMA6e3AEQ1jWuNWnGk5ATpIe0SVetae8ozktcq2hKXD33CHCFTD61I/KiOezKLkCApXqjYcG0aWCGFdrVdmd6+9T1obyL+zlcNFEag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537380; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LZnFJyAu0fMBU1FFsmmjSlqVDqDj3Upz6vVFBawanQE=; 
	b=KXmWzgMt/Qy4cnXTSHF3cOQFNswAs3C1YBi5OifWVI7nBZWeouTTlXbHrPNUvoAkCPcnlB8qL1FBM2OND1WSLbc4IGxZQeNloy3iX3jT0N4vn6Jxl6q6bpcE2oPw9X1asfgl4djD0tqYsVyc4QQnNZirzLgzP/i7w67gA7daWkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537380;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LZnFJyAu0fMBU1FFsmmjSlqVDqDj3Upz6vVFBawanQE=;
	b=coslJ5pzf2eJuRCI1tSbZxT8X2XJh7NAnLDPTykZ+GcHtF7oWigi7L2zb5cmLPbz
	nmnglQ/8FDOb8ytiZrilPU1ZEg9bbwHPPqR58AoYqs3oqSpPjuFBSff1KHIiGndBW/o
	+usidKyy2/m2s0RS6kohd82Nk8t68JSNi7KC3OqE=
Received: by mx.zohomail.com with SMTPS id 175453737691268.38224954269629;
	Wed, 6 Aug 2025 20:29:36 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 3/6] kexec/arch/i386/x86-linux-setup.c: replace %d with %u, because e820[i].type is unsigned
Date: Thu,  7 Aug 2025 03:25:07 +0000
Message-ID: <20250807032510.4211-4-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
References: <20250807032510.4211-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122710c0ed7dc6ad50251476d32c0000821f6cc2d41601fb074617f3d8b9e77d3c136e3c1b78cf8bd7:zu080112275113e459d49281e46bca2359000001fe8727a7e560edc1c4770cea01534a8e33ebc54b9e303745:rf0801122cb0ac45abb52183656c218292000033110a81467c0df8ec9a0d33ba20a4adcaadf6f7db803900e176c272e1da:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_202954_180833_8C53B65A 
X-CRM114-Status: UNSURE (   8.03  )
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
 kexec/arch/i386/x86-linux-setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index c716e1b..94d9dd2 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -761,7 +761,7 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%d)\n",
+		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%u)\n",
 				e820[i].addr,
 				e820[i].addr + e820[i].size - 1,
 				e820[i].type);
-- 
2.47.2


