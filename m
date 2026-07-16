Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC90C44507
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ss7/kTGN3OUIncgAtHrRqAmrW5PswI+hh6Nfe+UCfHo=; b=HJSSjVYa5A55m622hnmaDwyE7b
	Dq+Dzs4hdwX23yo1Mo40VYlqdrdnsnEUL2h6r22nTb6478DQcxAm9FwaPqKVAZMnr3BfzX3NHy+f8
	vvLkP1BUs2Mmosmw2HkzujBWvCoPAwYCibCG3ThjhKGc5szrLJxIfoj8RC7nsHKUmIoKTG3oAafd8
	puB8ReR2et7L7F0qIXSmHJLNQ3GxNvKDjtcl95GU8eJnKJq8DaJX3z1wAN36icp5DF415tMdZ2Ltb
	9JOPpW5GQcMFuO4Oh9V3TxGQbYy5s3jyAF40LdVXocY/P+VgkA/vCtZljDn3NJp+dMju0DJpvQgqg
	wdnPZFXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkArv-0000000GC0Z-3vEA;
	Thu, 16 Jul 2026 01:26:31 +0000
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkArr-0000000GBzZ-3BM3
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 01:26:30 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784165181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ss7/kTGN3OUIncgAtHrRqAmrW5PswI+hh6Nfe+UCfHo=;
	b=iM4rUxqszxpLGFjWuNCvDqZ8qdZx6g1UnkOpIq1vi8dkwJtkX/Tt0DQRBYa3veg5nYfAN6
	VtLXWaXqfl9DCuKY1fPiM9uFiH69WqJspzGsYbH9THu0isPSCBgFvtW4sKi+drn1nsSnwJ
	/u2XFBs7D2xyY9/m9/WpQHyb+Dkj1Hg=
From: Jackie Liu <liu.yun@linux.dev>
To: pratyush@kernel.org
Cc: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	kpm@linux-foundation.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] liveupdate: fix GET_NAME ioctl argument validation
Date: Thu, 16 Jul 2026 09:26:06 +0800
Message-ID: <20260716012607.22020-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_182628_940224_73B758C2 
X-CRM114-Status: UNSURE (   9.20  )
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
A zero-initialized request still succeeds because luo_session_get_name()
writes the full name before luo_ucmd_respond() copies the full GET_NAME
response to userspace. However, copy_struct_from_user() treats the
output-only name field as unknown trailing data and rejects the request
with -E2BIG if any byte in that field is nonzero.

Use the GET_NAME structure and its name field in the descriptor.

Link: https://lore.kernel.org/all/ahWlYXNjGUbkKoHy@sirena.org.uk/
Assisted-by: Codex:gpt-5.6-sol
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
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


