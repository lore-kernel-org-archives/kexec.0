Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F543CDE006
	for <kexec@archiver.kernel.org>; Thu, 25 Jun 2026 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QWnSTOsJzyf0dbaV0aPM4Q+SeImZDpbu570V/Cu9nN0=; b=3/ahd8VsD137g2RxJPLrDQ1wT0
	LlkT82h+zdYZ+vdiXelDTaEL51gzagirNifm7STp8tPKRkEmfynHCi4A2YWy2xGFpI4Ve1IjWDnVm
	V5ZWbZ4iDUo3kBT+4HhV7jFJVMpdoZuGjUxoFfLLqtMdp4PdQZqzySFPlWZ6w1SMnq3JH8k4oVgDG
	keg42eDg0dQA4lugZQBxhtj/o3D2GvAk3GKAsRUhHdx4KLtbSRdqwMcg2A4mMZTr5+hrmKSWGEJ2b
	JrhhsGm8RpLOAPE7t2TfmBi/95HyZAXAKJa88MNOxi6Wct5RHCFPnywgFixK+OGxw+Ds7emqRdPUe
	+RpSSRJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wccyX-00000008gIe-0ABU;
	Thu, 25 Jun 2026 05:50:09 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wccyS-00000008gH1-1iFb
	for kexec@lists.infradead.org;
	Thu, 25 Jun 2026 05:50:07 +0000
X-UUID: ae7cf162705911f1aa26b74ffac11d73-20260625
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4a1fc58d-7937-40a2-899c-edc312cdc844,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:4a1fc58d-7937-40a2-899c-edc312cdc844,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:f653971d38e0eb93971b013d818d392f,BulkI
	D:260625134951C85J5I9S,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ae7cf162705911f1aa26b74ffac11d73-20260625
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1580749568; Thu, 25 Jun 2026 13:49:50 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	pratyush@kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Cc: jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn
Subject: [PATCH v1 0/2] luo support for preserving eventfd
Date: Thu, 25 Jun 2026 13:49:44 +0800
Message-Id: <20260625054946.73445-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_225004_763509_E7D1BCAB 
X-CRM114-Status: UNSURE (   7.70  )
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

It is my great honor to participate in the development of LiveUpdate.
The current patch implements logic to preserve and retrieve eventfd
states, which I developed by referencing memfd_luo while learning the
LiveUpdate framework.

eventfd serves as a critical notification mechanism between Guest and
Host. During host kernel upgrades, we can preserve the corresponding
eventfd states and restore them after the kernel update completes.

Patch 0001 implements eventfd_luo, while Patch 0002 contains selftest code.
Test procedures:
    1. ./luo_test_eventfd --stage 1
    2. kexec reboot
    3. ./luo_test_eventfd --stage 2

Chenghao Duan (2):
  eventfd: luo: luo support for preserving eventfd
  selftests: liveupdate: Add selftest for eventfd LUO

 fs/Makefile                                   |   1 +
 fs/eventfd.c                                  |  40 ++
 fs/eventfd_luo.c                              | 250 ++++++++++++
 include/linux/eventfd.h                       |   2 +
 include/linux/kho/abi/eventfd.h               |  39 ++
 kernel/liveupdate/Kconfig                     |  16 +
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 tools/testing/selftests/liveupdate/config     |   2 +
 .../selftests/liveupdate/luo_test_eventfd.c   | 376 ++++++++++++++++++
 9 files changed, 727 insertions(+)
 create mode 100644 fs/eventfd_luo.c
 create mode 100644 include/linux/kho/abi/eventfd.h
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_eventfd.c

-- 
2.25.1


