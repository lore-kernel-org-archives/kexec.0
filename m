Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD04AC47DA7
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YXqf0Osp09b3emekWQazj5jSftmpO42I6m7vfbbsKSw=; b=kpYEHbwAW/C1Sw
	bXPz3+KCSrXX1b8D6GLwOAqCkhLFTy2afKFzQtMKYdQlBdOHbbpBzZHC5LARqhiEr4/rzbwNQl077
	zOw94j0OXOq362AtuPz8ca1jNwiqfifaTuCWzVEZwGClHFE5oxRPgcxfzBZgis1IBeNma3WoW7i57
	Eqgc0NkVyA4U919nN6sx3UQ0JZk8kENHeHTCaGxCEPZu9tQaAYHmhEQab8dDKSi48bzTbou2dWuJ1
	g0FQ6zeUqCgKuNwVouHI4XAc8DGjaQr0hiOCkSWeVJTdK5z89xPUVpU0ODgTmZxi/rgllzUc/sRTH
	yhuToXYLGKoBPti9nRPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPn1M-00CkSU-0u;
	Tue, 16 Jan 2024 17:14:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPn1I-00CkQK-3B
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 17:14:38 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 768C3221E8
	for <kexec@lists.infradead.org>; Tue, 16 Jan 2024 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705425271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OQlERV0n6MCqD1TRIKT2LVzDISdXhMwBfJK8/2zUH9U=;
	b=VzuC22I1MMW8I4O4I9uMpo37udJRkWhsEqKv++/sp1O9Q2WZxL3ReNizftclYFIexWWh23
	WEaGAACYqbhdrX7Xso0yXl2LzGKG1ZgDSo5dMb4HquSvIh3AuEsjzAshFpNegJdHGNLGKB
	YcbwdJcVnsQA9Slu8vanXQse/jYe5Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705425271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OQlERV0n6MCqD1TRIKT2LVzDISdXhMwBfJK8/2zUH9U=;
	b=p3dTlmH+U6qxZQ0+Rct5J8AP0+FRsTnUY+Iw1q/rMBVlMPzVvaEPO2Zjw2tvIlBpaXKy57
	aeRagfzfc2JZqXAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705425271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OQlERV0n6MCqD1TRIKT2LVzDISdXhMwBfJK8/2zUH9U=;
	b=VzuC22I1MMW8I4O4I9uMpo37udJRkWhsEqKv++/sp1O9Q2WZxL3ReNizftclYFIexWWh23
	WEaGAACYqbhdrX7Xso0yXl2LzGKG1ZgDSo5dMb4HquSvIh3AuEsjzAshFpNegJdHGNLGKB
	YcbwdJcVnsQA9Slu8vanXQse/jYe5Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705425271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OQlERV0n6MCqD1TRIKT2LVzDISdXhMwBfJK8/2zUH9U=;
	b=p3dTlmH+U6qxZQ0+Rct5J8AP0+FRsTnUY+Iw1q/rMBVlMPzVvaEPO2Zjw2tvIlBpaXKy57
	aeRagfzfc2JZqXAw==
Date: Tue, 16 Jan 2024 18:14:31 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: kexec@lists.infradead.org
Subject: [PATCH] kexec: don't use kexec_file_load on XEN
Message-ID: <Zaa5dwoUi4WnrCMA@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_091437_193277_5AA6A4C4 
X-CRM114-Status: GOOD (  12.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Since commit 29fe5067ed07 ("kexec: make -a the default")
kexec tries the kexec_file_load syscall first and only falls back to kexec_load on
selected error codes.

This effectively breaks kexec on XEN, unless -c is pecified to force the kexec_load
syscall.

The XEN-specific functions (xen_kexec_load / xen_kexec_unload) are only called
from my_load / k_unload, i.e. the kexec_load code path.

With -p (panic kernel) kexec_file_load on XEN fails with -EADDRNOTAVAIL (crash
kernel reservation is ignored by the kernel on XEN), which is not in the list
of return codes that cause the fallback to kexec_file.

Without -p kexec_file_load actualy leads to a kernel oops on v6.4.0
(needs to be dubugged separately).

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Fixes: 29fe5067ed07 ("kexec: make -a the default")
---
 kexec/kexec.8 | 1 +
 kexec/kexec.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index b969cea..9e995fe 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -162,6 +162,7 @@ Specify that the new kernel is of this
 .TP
 .BI \-s\ (\-\-kexec-file-syscall)
 Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
+Ignored on XEN.
 .TP
 .BI \-c\ (\-\-kexec-syscall)
 Specify that the old KEXEC_LOAD syscall should be used exclusively.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 08edfca..9d0ec46 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1685,6 +1685,10 @@ int main(int argc, char *argv[])
 			}
 		}
 	}
+	if (xen_present()) {
+		do_kexec_file_syscall = 0;
+		do_kexec_fallback = 0;
+	}
 	if (do_kexec_file_syscall) {
 		if (do_load_jump_back_helper && !do_kexec_fallback)
 			die("--load-jump-back-helper not supported with kexec_file_load\n");
-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
