Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4591C44508
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 06:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TKzIL1IKcSprH3li6rPCtV4ZV6sHt4gRPtDKPLdnOAE=; b=U8E7Wds+KbW2LBGqeYp3WywH1c
	jHsVkvBE+4CkOlkp9VZsQVtJZJQT2AEX7Vs1b3h3PCeiuQrgKsSAMdGuPEwESI6I088uXwvfLUgTt
	9gwb3qvunJIK1RPXS1oIIHMu2rJ6j+V/kVvC/ioEIQ3omPYKuE2wWkMLJtdc+yMqVVmjSV76g9mH7
	vf2k6+hY6S6jSmitIbVj0bCSMmVdA0B7+7eMGsC6lqnEJHES0xW9gWNVa+AHAwkbNdWTrosX+/7HV
	M+COHYgtTZtWXyZwMx3b25rwvO5u4mY7J1fmcoYffR3Wyrj3ouDRSUUUc6fkuqcNUt5HKhFSxsFj9
	lbynZ2Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjslO-0000000DqtM-1OqS;
	Wed, 15 Jul 2026 06:06:34 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjslL-0000000Dqrt-17DG
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 06:06:33 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKzIL1IKcSprH3li6rPCtV4ZV6sHt4gRPtDKPLdnOAE=;
	b=cIdpbV8mY7z2+UZYNs/Xp0DhYBq5oqMqpkrrv3j6I0CcgNkPkTpuxoN4HSnNvUkFXuvMkN
	oDajg2jVdfl88c+QsMdjf+RpbNfuAKOJW/8KJgxLqeGk/hyp++5i98pAHkDEn6fNVeBc9A
	metD/opCOM1uLbtCjzYh++Pr6x/muk4=
From: Jackie Liu <liu.yun@linux.dev>
To: pasha.tatashin@soleen.com
Cc: rppt@kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH 2/2] liveupdate: reject nonzero reserved value for SESSION_FINISH
Date: Wed, 15 Jul 2026 14:06:13 +0800
Message-ID: <20260715060613.19272-2-liu.yun@linux.dev>
In-Reply-To: <20260715060613.19272-1-liu.yun@linux.dev>
References: <20260715060613.19272-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_230631_452676_36531D18 
X-CRM114-Status: UNSURE (   9.44  )
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


