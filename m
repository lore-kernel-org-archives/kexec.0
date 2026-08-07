Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5459FC5AC7C
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FQmjc4mZn8DxVr4olKejZyOdPMT6DHDKgcn+RDpz+no=; b=Zb82JheeAdXIdNXqYUSRQap9IN
	7tmlKDCDeM8HCxUdelWe++jiYExhoUGhXETNOBggcFp1Bd49Tis8rSgv9jTn8ZBWnO/4rokD5KqE8
	uj2SQkxForYssdUUvB3NkudKwtNvuyIupTwEooN6IrzqE3Ed36IzFRxhq4ds9YaeIFDNwKRaXVtG/
	ZkTgUPK3vQV7nb0MGapUl2518Zf3RynzBWp6wNpD6VVT+jKFfmYzDHgoWT4+saZph7anHtfoAAY+v
	vsTAAo8rLp6BsxFgNwCUTmOLkFPPedhL+vW2h57yHcJYNVk8e3f9vTThw6ZPyAuUC/C8ldtHVaZl2
	bB4lTyZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFN3-00000007ItR-2ZBu;
	Fri, 07 Aug 2026 07:52:01 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFMs-00000007IrR-2SCj
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 07:51:57 +0000
X-UUID: ce382268923411f1aa26b74ffac11d73-20260807
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d1a9f10e-3d3f-40c9-b503-d6182cb40323,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:d1a9f10e-3d3f-40c9-b503-d6182cb40323,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:a20aa3c33e80b4ac4e448a4e0596ec27,BulkI
	D:260807155136P7XMI6FN,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ce382268923411f1aa26b74ffac11d73-20260807
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.104.44.99)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1176066525; Fri, 07 Aug 2026 15:51:32 +0800
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
Subject: [PATCH v1 0/2] Optimize the code in kexec_handover.c
Date: Fri,  7 Aug 2026 15:51:26 +0800
Message-Id: <20260807075128.542806-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_005151_676703_AE5C82DE 
X-CRM114-Status: UNSURE (   3.23  )
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

Patch 1: No functional changes, remove redundant code.
Patch 2: Rework error unwind logic for kho_restore_vmalloc().

Chenghao Duan (2):
  kho: remove useless phys increment in inner loop
  kho: unwind restored pages on kho_restore_vmalloc error

 kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.25.1


