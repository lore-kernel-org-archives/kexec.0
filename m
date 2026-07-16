Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E9EC44501
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 01:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yzHyAL7pNceL2yaXNIkqBqDFMTl7ASDtb7hMv9AVCYQ=; b=hXfUVo3p4IdYPr6ysB9MJXKLRI
	Xl/0nvzeiXPWB83PQlaBLZVPCAmrO3dgHzI8L+6sSbij2NzWbA+oPsCBEeQAHE9SWoiRmHziNS4qs
	N+BGTiwJ+6nXZjK5an5j5X26Y33qH5REv/tOX378qjk8nXXK5csadO6MnCxcw7WnZs9EPDpAXfeye
	gFK0tu1LDWaBtbhmYymiGQsJFHLGgGe7JAoec/6aw73uHqxpQIKhnXW0Lg4IMAf0bnQWFUkpshEZu
	ba3eGeYS5sohQQbgYS4T0ckctx5w/wcPRuwW3ZD+QMn/ebZ1D8ZzUPd2RROlGME+HHuf/XELqqYGG
	YewefmSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkArx-0000000GC0o-01VK;
	Thu, 16 Jul 2026 01:26:33 +0000
Received: from out-172.mta0.migadu.com ([2001:41d0:1004:224b::ac])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkAru-0000000GBzb-2UZL
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 01:26:31 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784165185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzHyAL7pNceL2yaXNIkqBqDFMTl7ASDtb7hMv9AVCYQ=;
	b=bpDhLyHK1bdALzPdXyBKZzCwXL1qxjw3hodGbug4JRD8sCcWH76NsjpcowVR6fohPeYQCf
	/zFCfmx82TavJKKm7BAvtUhbKlVrtgxAkaom2sehGLbgUtnpOnjf4Kocnl9+Twe79tDxdW
	VZ1OqGvyERbPYHjOOM9IdJj9WrP/Rek=
From: Jackie Liu <liu.yun@linux.dev>
To: pratyush@kernel.org
Cc: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	kpm@linux-foundation.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] liveupdate: reject nonzero reserved value for SESSION_FINISH
Date: Thu, 16 Jul 2026 09:26:07 +0800
Message-ID: <20260716012607.22020-2-liu.yun@linux.dev>
In-Reply-To: <20260716012607.22020-1-liu.yun@linux.dev>
References: <20260716012607.22020-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_182630_811709_6285F88D 
X-CRM114-Status: UNSURE (   9.32  )
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

From: Jackie Liu <liuyun01@kylinos.cn>

The UAPI documents liveupdate_session_finish::reserved as requiring zero,
but luo_session_finish() currently ignores it and finishes the session.
Accepting nonzero values prevents the field from being safely repurposed
by a future extension.

Reject nonzero reserved values before changing session state, matching
LIVEUPDATE_SESSION_GET_NAME.

Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
Assisted-by: Codex:gpt-5.6-sol
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 kernel/liveupdate/luo_session.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f38b5b18f3f8..15342c0783b5 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -316,7 +316,12 @@ static int luo_session_finish(struct luo_session *session,
 			      struct luo_ucmd *ucmd)
 {
 	struct liveupdate_session_finish *argp = ucmd->cmd;
-	int err = luo_session_finish_one(session);
+	int err;
+
+	if (argp->reserved)
+		return -EINVAL;
+
+	err = luo_session_finish_one(session);
 
 	if (err)
 		return err;
-- 
2.54.0


