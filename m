Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395E0C44506
	for <kexec@archiver.kernel.org>; Sat, 11 Jul 2026 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h1/C0u19jpgNp4s3/jhCeEGJz6fASb5yOysvDbFw75o=; b=vgggCHUWk6f7Gf
	LHQ1bzEJ20Nn/aOF4XQpll5BtgGgn0TLbkfvvTQApuI/xDnq/ILPgfl7YCxXrRKYrFHgIfVtEpwTa
	Ybl8QJmIUb0U3lVWlWW/yWzW2EeXN2rbsLS0bS5gbS6/h/eyY/tVc6JO6Vw7XscShzEpgQpu7XK89
	IyaJkEZyohh0vwvbg+Uc9LQD74VPD/bw2Yoe0zfTmJpgTLMaNwjOdRO02y1B4m7RWNRG2Cm/wKlT0
	rjZ5XNJnccYW7Vo8ezkKX7I4J/TCwDwBg1vp3wCpfFNoFQL/fRYKNcDZ96Ug/2FwLKLSVAlgOq15k
	gSgklAQl1VzZcn0K5auA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUq-0000000634L-101i;
	Sat, 11 Jul 2026 00:23:08 +0000
Received: from confino.investici.org ([93.190.126.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUn-0000000631A-40Kc
	for kexec@lists.infradead.org;
	Sat, 11 Jul 2026 00:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783729374;
	bh=h1/C0u19jpgNp4s3/jhCeEGJz6fASb5yOysvDbFw75o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKhL+uzVB0ZymgAknhMqADPyJVyjkAsbVfqIXUDyXoRxLl1hnmNnmsfxZFtpSCN7H
	 0rhMvCXaGikvuAsRGVl2/ZvW6F72BmnXaRkxUo1OzSlEZ6MkIVVdWgHYjPuAm8LEP/
	 iRZObIIgMg1FESckxliJNlqSwVDHTsnGxkxmxYRs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gxqCy4K0Hz114W;
	Sat, 11 Jul 2026 00:22:54 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gxqCx6v7Pz113X;
	Sat, 11 Jul 2026 00:22:53 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [RFC PATCH 2/4] panic: run the pre kdump list before crash kexec
Date: Sat, 11 Jul 2026 00:22:51 +0000
Message-ID: <20260711002253.1115-3-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711002253.1115-1-include@grrlz.net>
References: <20260711002253.1115-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_172306_140893_2E788C05 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: pmladek@suse.com, include@grrlz.net, baoquan.he@linux.dev, arnd@arndb.de, corbet@lwn.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Call the new list unconditionally in vpanic, right before the
early crash kexec. The legacy list, crash_kexec_post_notifiers
and the cpu shutdown sequence are untouched. Also note in the
kernel parameters entry that the option has no effect on the
pre kdump list.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 kernel/panic.c                                  | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..a77ecf3bd564 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1042,6 +1042,9 @@ Kernel parameters
 			or extra data dumped by panic_print. Note that some
 			configurations enable this option unconditionally,
 			like Hyper-V, PowerPC (fadump) and AMD SEV-SNP.
+			This option does not affect the pre kdump notifier
+			list (see include/linux/panic_notifier.h), which
+			always runs before the jump to the kdump kernel.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
diff --git a/kernel/panic.c b/kernel/panic.c
index 94ce7a94f118..f9ad0250da67 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -664,6 +664,13 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	kgdb_panic(buf);
 
+	/*
+	 * Tell the hypervisor or firmware about the panic. This runs on
+	 * every panic, before a potential crash kexec, so the upcall is
+	 * not lost when a crash kernel is loaded.
+	 */
+	panic_pre_kdump_notify(buf);
+
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
-- 
2.53.0


