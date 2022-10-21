Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CAC433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5YcnvjD2eEg8dMe3OWZklbwxsHc9c/X3w1UmPm116+Y=; b=BXfSE1A/33vpBv
	Hyba0gYfS6YGn5v/gpgiLoP7zPwDpKcs5kYuKTA3lTz41TP8POpdAqlhypGevw3njY6VamYWQFXAD
	3OsmtPzLh3OreaRzxzEjn+ugZLOVT17Oo9GT3Rxws+4B4Ce/qPZlKt6SgG0gpHyAHVbxvgr3QcTCp
	4ZE+YuGxMxqmOGz8y5/ia9yjGo5HmunQvU0O6+N7jUfYAFn/mxL5ccEou1yjjAPZL0niF0GsvTMXt
	RDQISQmexfg73kjTewjw1s+BXaQ11ETFemXmb1FQcKjl10itHa57X+HXrydbfdCX0MUEQW77ag4b8
	BZRPCtNPx0d7jOCDGa9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olpDg-0074pR-75; Fri, 21 Oct 2022 10:25:40 +0000
Received: from mail.archlinux.org ([95.216.189.61])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olpDc-0074oJ-S3
	for kexec@lists.infradead.org; Fri, 21 Oct 2022 10:25:39 +0000
Received: from tiamat.. (unknown [141.0.156.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.archlinux.org (Postfix) with ESMTPSA id 2679E15C37D4;
	Fri, 21 Oct 2022 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1666347928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KGfxLlRv8jmQoZKwvrgIiNLjBTgcErlo7OaNm1MszYs=;
	b=SA6qCYpFDLknFJtYIXa+d3m75dJxU/mDJI5nImPMt9Mnp+r5HuR4txalsrChNbL2d/ZVk6
	klQJwIe8L06kIbnCYcLzdvtVd5LrJKQNBKlqYGyDCMY+jC7wgxncdg9uc2m4yrs/G0jjT5
	49wK6TzL//1ZYpw/PbdB6hMGNvJ5iWXnJ+vkASJfNZ6CEM5pDhyoHLR0cukacoRqCnRjK+
	3Bf6Gk3I0mRYkKYVIiajAnA0NniYWt8xng5S1nAjI5hxZqkGfKU/LstBKlo6VEcP6NpAPB
	Ex1ifhQwlmCThlqmsRTqzr+vfTQX1rMu1bC0ekrGdfVikqh9wJTXkYigGfFpsc8zoNgxe6
	NImaW8WvlRKXRDOqvlWn2iaYo8/5hsFoenoPbfdXNOSqP2dAhORB4DNsRhlI4wP85jAWXq
	3EncUxtdhtJ+50BX6gJbhdrFEiPKojAotXDGi+sUX1bOBmzG+po99Qz2T9EAoVqwnfTErQ
	HRA4EW/9NaiLVe6VT8iC8nqGn45X9TL93ti2AxfrBqOxROk1zb/M0YlYquq6WCM+ICHATM
	7/30DHF3IWPsNBJ+BzsXSiZq5SbckDxKYSVBn7sLx81uL6yXP2/pJVlocOYJxSnO+nrkSY
	c+ZNDtbWAmvCqEIfP6JhWxTMXxeXpcp0Lq7tStL68jzVDVA0D1mCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1666347928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KGfxLlRv8jmQoZKwvrgIiNLjBTgcErlo7OaNm1MszYs=;
	b=A5HTAqHPFifuDM1ZoNTeODHbXr03DN6PSQxS/Gil6DLNIoTKKzR27sfp6kE/bbrw36zDAB
	g3GRVddyq926L9Dw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=artafinde smtp.mailfrom=artafinde@archlinux.org
From: Leonidas Spyropoulos <artafinde@archlinux.org>
To: kexec@lists.infradead.org
Cc: Leonidas Spyropoulos <artafinde@archlinux.org>
Subject: [PATCH] Makefile: Remove version from /usr/share/makedumpfile
Date: Fri, 21 Oct 2022 11:24:59 +0100
Message-Id: <20221021102459.28070-1-artafinde@archlinux.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_032537_688862_304195A1 
X-CRM114-Status: UNSURE (   8.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Version specific paths doesn't make sense at
/usr/share/makedumpfile. This assumes you will have only one version
installed which on a normal system it makes sense and devs can always
specify different DESTDIR per versions.

Fixes: #10

Signed-off-by: Leonidas Spyropoulos <artafinde@archlinux.org>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 548e5b7..f6ecbe2 100644
--- a/Makefile
+++ b/Makefile
@@ -130,6 +130,6 @@ install:
 	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
 	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
 	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
-	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
-	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile-${VERSION}/makedumpfile.conf.sample
-	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ $(VPATH)eppic_scripts/*
+	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
+	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile/makedumpfile.conf.sample
+	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scripts/ $(VPATH)eppic_scripts/*
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
