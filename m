Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405E606A326
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QZSb7/tc;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=arhbvq5i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=HLxZXNfPTv47IAoItk9WdBgYZhfyCgUD1in+scYfeQw=; b=QZSb7/tclAHXnEG2YUoYoKcmEN
	KISM+z7m2AfGym7e4AhNpSuY1L8eYAHb5/+blf5QrIDgs5awLIVDITtYFht6aIXCxesjOjipgh9Bg
	5HfQdjrjnQp+mno+zJp+VCEBz+lZJK3u/d5BhcQIjLF4Lpwxkc6Cb5VrelkbOr4xaPZRqBMYTrvGE
	5FBS4/adjuuAV7t2zbw42usZifgxsluH9UyH33Rk/3Ma2mUREjdCfgh2ouDuambwipDZPzaIgzeb9
	aeY1Csaz2QHMBOLJ8YR4sTKay2LnEdgrPgBr6yXuvWfpJgI26DgCVPXl2FqAa6+G5KXwOtLeNj2En
	g+hVP7Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQHSC-0000000HN41-2ALZ;
	Mon, 09 Nov 2026 04:58:00 +0000
Received: from out-58.mta1.migadu.com ([95.215.58.58] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQHS9-0000000HN1y-43CM
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 04:57:59 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=AVMHI6NGvrOTgLavdIBomZBMmUsoL9IwqYMKcULv7RQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794200274; v=1; x=1794805074;
 b=arhbvq5iryzp3wWhcyFthvCCDnJQkU2g2TrAVwdzMS77rvy7uozkomtob29TF/7YseEzgwnu
 yRMUxweHWdJ10tYE7RTlxB50H3jNKHjmzTDzZmk8DgPMDxSdqSgxolgF8DqLh5fMAtEQOqjtRsN
 AdLWydruavuQX19FxmpsYccM=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 379fa3da46e5efbb;
	Mon, 09 Nov 2026 04:57:54 +0000
X-Mizu-Trace-ID: 379fa3da46e5efbb
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 12:55:47 +0800
From: Dave Young <ruirui.yang@linux.dev>
To: akpm@linux-foundation.org, baoquan.he@linux.dev
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove myself as a kdump reviewer
Message-ID: <avFSU0f0aE-amdls@darkstar>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_205758_211683_2AA78A05 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I do not have enough time to review kernel patches though I still
accasinally scanning the patches. Drop myself from the reviwer list.

Signed-off-by: Dave Young <ruirui.yang@linux.dev>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9fe9c2a39b..7e18fe93d4f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14145,7 +14145,6 @@ M:	Baoquan He <baoquan.he@linux.dev>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Pratyush Yadav <pratyush@kernel.org>
-R:	Dave Young <ruirui.yang@linux.dev>
 L:	kexec@lists.infradead.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
-- 
2.51.1


