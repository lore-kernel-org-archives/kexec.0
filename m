Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB198C4450B
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 06:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yu7nV3M5HtVX4+iUCrUOc/sXWLmymsxiaC28d+VYycw=; b=oU6msUfkAeQ/CRRPTbdQoTEdJP
	+OjP91zwORv3QNIM2piQHT1nwqKdI8DWEEFbphmfxJhZBDSKt/zsuoXqnMv1SBjCAr5S1hifJOPC2
	ksChpib9rGKf4rGIE8WCnXzsvSlqXbyW+hWR0h11+fvDD505WtLMwLZBEZsn/4fd9HXvhbOgqIzsu
	XQ/lB4WNF8R3qx5PZZhmPBIGS2SnSbG24qAQ639iHZSkEryIT3tu54QW45DUrLaTsNE6ffUg4QBED
	9hkMhp0a8fj5840aMe1CjSOlVIPdYWzuoGJB3o9leYCHJaT0XHZAyBA5p9iluqcbAy+03thlWvCFA
	F1vMAcjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjslO-0000000DqtF-10XI;
	Wed, 15 Jul 2026 06:06:34 +0000
Received: from out-180.mta1.migadu.com ([95.215.58.180])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjslL-0000000Dqrr-0AGv
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 06:06:32 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yu7nV3M5HtVX4+iUCrUOc/sXWLmymsxiaC28d+VYycw=;
	b=Zotkyaji1MkQQqwJxIT+ldiPQOYhfWzaVkAzeKzfPxAiyf4zD3cdlAl6ZA/qULOSq4m9CG
	Hj4COQQaHkzajJ4iUQrJitlvgwSk2Bve0ridIC3NR3O9MH3H76nEBHPr1aIeZgOqi5q2B5
	lSE170RZUF2z9PouWqE7iDE11gZ2wDQ=
From: Jackie Liu <liu.yun@linux.dev>
To: pasha.tatashin@soleen.com
Cc: rppt@kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH 1/2] liveupdate: fix GET_NAME ioctl argument validation
Date: Wed, 15 Jul 2026 14:06:12 +0800
Message-ID: <20260715060613.19272-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_230631_297590_C24F9778 
X-CRM114-Status: UNSURE (   9.30  )
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

LIVEUPDATE_SESSION_GET_NAME was developed in the liveupdate/next branch
while the session type validation change was carried in liveupdate-fixes.
When the conflict between the two branches was resolved, the GET_NAME
operation descriptor picked up the structure and last member from
RETRIEVE_FD.

This makes both its known size and minimum size 16 bytes rather than 72.
Consequently, copy_struct_from_user() treats most of a normal GET_NAME
argument as unknown trailing data and rejects it with -E2BIG when any of
those bytes are nonzero. It also accepts a 16-byte argument and returns
success after copying only a truncated session name.

Use the GET_NAME structure and its name field in the descriptor.

Link: https://lore.kernel.org/all/ahWlYXNjGUbkKoHy@sirena.org.uk/
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 kernel/liveupdate/luo_session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index b79b2a488974..f38b5b18f3f8 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -378,7 +378,7 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
 		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
-		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_ALL),
+		 struct liveupdate_session_get_name, name, LUO_IOCTL_ALL),
 };
 
 static bool luo_ioctl_type_valid(struct luo_session *session,
-- 
2.54.0


