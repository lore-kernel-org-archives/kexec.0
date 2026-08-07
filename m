Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D5DC5AC7C
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0G/evJ0w4+LOuHx74aiIPm6NjdOXtVc8iogYZE86Do=; b=E1+JnHM0f4IM3Yf2yiO7BmaBXg
	m6nJx7udafPZTvbQTNT98FxODtfEeZGZje7MkmIEdKeP3W5kC6QYkG1kPr7YsOSUurEg4SfyMVqT7
	G2GM5R4Ga9BQOeu5IodO0fxAqqofnbXWgmkFGGV/bV3Ri0WzHlxnPT9w0FtzN0Pc4T8QbhIpS64cK
	AX3lhsF9V8FfVD8KjVQ2e5dy5fCFQCdqsWqtfyt0C7FvPIXy+BZM7ZsHWi6xhJgPgzXYbI3wjOA4k
	9s/llulx9Jppian7B/E2XSdyUOenaWnA5AV+tCkRJPEUf8HEfOthgsqkPul1P0OYVJPle81AlBmKL
	/yL3zf/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFNH-00000007IzZ-0ZOd;
	Fri, 07 Aug 2026 07:52:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFNF-00000007Iys-1SAv
	for kexec@bombadil.infradead.org;
	Fri, 07 Aug 2026 07:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=G0G/evJ0w4+LOuHx74aiIPm6NjdOXtVc8iogYZE86Do=; b=RPWauXdPAdLpbms8WTadVXr2c1
	ePbkzYDd9VdJVO+fbxQFcFvus8G6xqQRMdZUTb4JDxjG+IODyi8hxLlpUGpJaO6y7QDQyPpgk0cEE
	+JMZxLPIklfQhREMNx2uYEyON4IT9CkPICRzxAxhKCHf8curI48XOJGL2RKwcait1gWitek/JNtj0
	lTDUyjNYaEkw9owdRgHQ2tQNCYV1EojTDXp8CXqCb+G0p7w0HQyizXaO6cBgTKOD1DzZZTcTah0aQ
	8Mq8liVNwWlWFmy2cJxfKliRiCKBqURirJ66ComEM58gsnGanZLeqgC6n+G7oO11kdlpS1fiOGbqD
	iqmUcs/w==;
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsFNA-0000000C9tm-0E9s
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 07:52:12 +0000
X-UUID: d0243634923411f1aa26b74ffac11d73-20260807
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9248a66f-0245-4dce-a9c1-9cc137809a2c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:9248a66f-0245-4dce-a9c1-9cc137809a2c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:796fb985dc2c6de23780a711ccd274f9,BulkI
	D:2608071551394GP681FK,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0243634923411f1aa26b74ffac11d73-20260807
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.104.44.99)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1127736449; Fri, 07 Aug 2026 15:51:35 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org,
	graf@amazon.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn
Subject: [PATCH v1 1/2] kho: remove useless phys increment in inner loop
Date: Fri,  7 Aug 2026 15:51:27 +0800
Message-Id: <20260807075128.542806-2-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807075128.542806-1-duanchenghao@kylinos.cn>
References: <20260807075128.542806-1-duanchenghao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_085208_603899_0EDD86C4 
X-CRM114-Status: UNSURE (   6.72  )
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

The statement phys += contig_pages * PAGE_SIZE at the end of the inner
for-loop in kho_restore_vmalloc() is redundant code. The variable 'phys'
is local to each loop iteration (re-assigned from chunk->phys[i] on every
iteration) and is never referenced after this increment, so the statement
has no functional impact. Remove it to avoid confusion during code review.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 kernel/liveupdate/kexec_handover.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e41e..ba03ff5baa9e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1191,8 +1191,6 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 
 			for (int j = 0; j < contig_pages; j++)
 				pages[idx++] = page + j;
-
-			phys += contig_pages * PAGE_SIZE;
 		}
 
 		page = kho_restore_pages(virt_to_phys(chunk), 1);
-- 
2.25.1


