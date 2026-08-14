Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D39C5B572
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iuhuehQ6MgrJxsnB5HDd/XKREyvn6MEiIwYky45/I9g=; b=AUSb8KKWKURhwjkr2tjvwKtZl3
	SBDTxfFrpv+k9XMgzy5SVI8CzB+nByZ4sMvE88JIjTDZrVORWSXswX6HBOXwN0kMrB+coxomaoEEs
	jpU9d2E/4tjKdPVkuTpzOSRisbnBLfz+EFqYOF7qLuCjkbmfxkoO83suI0uZ1YaHKdlNBRBnzMGca
	ZcVOULGavYeCIo1W2jZiqD+W/Ssdc/9YhwAqP2+W+yEQYjsxs39OAx7ydteutwPDTcD7LQ9iW0d8a
	t/KDgJ14lhku7OVN6ErtxePatvMcn6QieSAcE8cSPvuwxTsx1P9vCgvN855vAOZb0a4thhA0Zh7LS
	ldaIzSrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuoeA-00000002TTJ-0MTf;
	Fri, 14 Aug 2026 09:56:18 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuodp-00000002TNm-08Ly
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 09:56:17 +0000
X-UUID: 4884d2e697c611f1aa26b74ffac11d73-20260814
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:12f84e7f-cfa6-4117-9574-2b4cf115c43a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:12f84e7f-cfa6-4117-9574-2b4cf115c43a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:2dcb92359b08659083f82a1655c4f44c,BulkI
	D:2608141755332MBDLNDU,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4884d2e697c611f1aa26b74ffac11d73-20260814
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 456462654; Fri, 14 Aug 2026 17:55:30 +0800
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
Subject: [PATCH] liveupdate: use scoped_guard for mutex in session operations
Date: Fri, 14 Aug 2026 17:55:06 +0800
Message-Id: <20260814095506.631274-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_025559_359734_337DBF3F 
X-CRM114-Status: UNSURE (   7.62  )
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

Replace manually paired mutex_lock/unlock with scoped_guard to align
with the coding style of the rest of the codebase and simplify locking
paths.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 kernel/liveupdate/luo_session.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f38b5b18f3f8..06307868a44e 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -290,9 +290,8 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 	if (argp->fd < 0)
 		return argp->fd;
 
-	mutex_lock(&session->mutex);
-	err = luo_retrieve_file(&session->file_set, argp->token, &file);
-	mutex_unlock(&session->mutex);
+	scoped_guard(mutex, &session->mutex)
+		err = luo_retrieve_file(&session->file_set, argp->token, &file);
 	if (err < 0)
 		goto err_put_fd;
 
@@ -478,9 +477,8 @@ int luo_session_create(const char *name, struct file **filep)
 	if (err)
 		goto err_free;
 
-	mutex_lock(&session->mutex);
-	err = luo_session_getfile(session, filep);
-	mutex_unlock(&session->mutex);
+	scoped_guard(mutex, &session->mutex)
+		err = luo_session_getfile(session, filep);
 	if (err)
 		goto err_remove;
 	up_read(&luo_session_serialize_rwsem);
-- 
2.25.1


