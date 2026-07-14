Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977E6C43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 07:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q7SEVSys5QAUmgGUdqE7IKuJhdTvp30A0KvQy0Ga2Lk=; b=ghw5K28jq3udqdkwgd6DgRLZ1w
	NOUxpCl360BcWOaKzJVMVeqAZvYH2/IAnjmy2fkP90UqSuJ5W+YVVEvFQsbuKLOKjqjcQKomm8xpd
	I1GAFblb159lXYp/qD5LouSoWo+4siWw/IanzeE3WcVrX7dL5JS9OaC0PsrTHUmoXVWARR+pyowjN
	zazzpOHgjLPjTexp4lCh5518T/NNHncGe5Rggv5YVYPGAr9k+KU+6/0G4En52jxCQfMw+ZarIMcNf
	BO3smTRFfW+1kzkXXjhoYixAoBoxe8sAMJ2GcFD13VBuOpvJXAcikussuLERXRiWPTUrIAZR4Gt/E
	3c4HqFVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjXnB-0000000BDS3-2s4U;
	Tue, 14 Jul 2026 07:43:01 +0000
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjXn8-0000000BDQk-3RUG
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 07:43:00 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784014974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q7SEVSys5QAUmgGUdqE7IKuJhdTvp30A0KvQy0Ga2Lk=;
	b=pOyU43kF9gNfWh0mrkgnQ1Cp0dKUkdtwkqD4POScJRTOsWexaoA+tk/YYEVsFycSi68Cnx
	GS7/zM+9ImIps41AIPbyFLh4lJNP2LSJ9hK77YnGLAwfEIK01yKU7uxwMoaaldqIvIi3oc
	75JtpUV9wlYNXQ+f/dtNyC/m7+FDabo=
From: Hongfu Li <hongfu.li@linux.dev>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] liveupdate: Remove redundant INIT_LIST_HEAD in luo_session_alloc
Date: Tue, 14 Jul 2026 15:40:56 +0800
Message-ID: <20260714074056.95335-1-hongfu.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_004259_169075_C62F96DE 
X-CRM114-Status: UNSURE (   6.54  )
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

From: Hongfu Li <lihongfu@kylinos.cn>

luo_session_alloc() calls INIT_LIST_HEAD(&session->file_set.files_list)
followed immediately by luo_file_set_init(), which also performs
INIT_LIST_HEAD() on the same list head. Remove the duplicate call.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 kernel/liveupdate/luo_session.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index b79b2a488974..90ae3810e6cf 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -154,7 +154,6 @@ static struct luo_session *luo_session_alloc(const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	strscpy(session->name, name, sizeof(session->name));
-	INIT_LIST_HEAD(&session->file_set.files_list);
 	luo_file_set_init(&session->file_set);
 	INIT_LIST_HEAD(&session->list);
 	mutex_init(&session->mutex);
-- 
2.54.0


