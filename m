Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362A1C35FF3
	for <kexec@archiver.kernel.org>; Mon, 17 Mar 2025 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:Date:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xX+pQ4MM5YWpt2PNlqJSXkQwgqWXL0o3w/BDvIXu4Q0=; b=GCEr8wKehc9oAfzZutakgqYV3y
	c1sXZ/otATXrp4PfhUwme1ivj7wirC12cTrOIl7RRLJeWFmu5l53Y6J6MIGP313MapcXieGmhHA3B
	NohZVgUv3Ok3bXt1GX5WPhmYCFK8dHsNeRfGMUSQJlh7InggLocEGkcHLSGwpyYn/AhljG1PYbUpK
	QSfD2vaiJBqsOQrDJcJSEPCO0htKWhcb8mGClEPn59pqfULe3fSfdprEhlv5eH3llT+HHDQ720YeC
	gg+8jo+ywNYXFIX1SFj5L4vgNbAKSBrFpZWBMoy9Ju4xLGvpHmZYcbSxAFbAdujM+VHMm/ulWB5pS
	YoGAvznw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuB8h-00000002r0w-3XD7;
	Mon, 17 Mar 2025 14:08:23 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuAou-00000002ncF-0EyM
	for kexec@lists.infradead.org;
	Mon, 17 Mar 2025 13:47:57 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:44470)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tuAoc-001XWc-FI; Mon, 17 Mar 2025 07:47:38 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59574 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tuAoa-003fO2-WF; Mon, 17 Mar 2025 07:47:38 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org> ,
 Kexec Mailing List <kexec@lists.infradead.org>,
 Kees Cook <keescook@chromium.org> 
Date: Mon, 17 Mar 2025 08:47:30 -0500
Message-ID: <87r02v7or1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tuAoa-003fO2-WF;;;mid=<87r02v7or1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX197FQxHXBXos5TSabCI0KcBicWE4+FEdFM=
Subject: [PATCH] MAINTAINERS: Remove myself
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_064756_086572_31AB422A 
X-CRM114-Status: GOOD (  11.19  )
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


Unfortunately I no longer have time to meaningfully take part in the
linux kernel development.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..7469254b13ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8644,7 +8644,6 @@ F:	rust/kernel/net/phy/reg.rs
 
 EXEC & BINFMT API, ELF
 M:	Kees Cook <kees@kernel.org>
-R:	Eric Biederman <ebiederm@xmission.com>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
@@ -12824,9 +12823,7 @@ F:	fs/kernfs/
 F:	include/linux/kernfs.h
 
 KEXEC
-M:	Eric Biederman <ebiederm@xmission.com>
 L:	kexec@lists.infradead.org
-S:	Maintained
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
-- 
2.41.0


