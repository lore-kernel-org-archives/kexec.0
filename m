Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B740C44507
	for <kexec@archiver.kernel.org>; Sat, 11 Jul 2026 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M/o/prhRHK/YAh6eE3jaspP3NcXZCBODXl03eT6DoQ8=; b=Dg9002zz1ADnEY
	bz+Pyf2QLcTxWJFOmYxvGzkl+1PBVzzn+HuBETRJWGfQDIlWFYfLTU6d6X1P6DF5KAJvqZGroyVY1
	sGSlH9ONUhNQJzi2nAJ7emCQhyag+yRZErwTTn23Fo888+QuqNvpMwqmwIkAQGO8rMPcI+6q/Dqvc
	pY4gLwdKBWPtKsDHtVM/Ed5Ux9bNNmzid2KCmi3QpWQgAUE5HnvlnkSsux6nMNinGTz1lpnna43mQ
	ePMPDJSzU/2wnf5XRql+eT7CdjRKKgngVE9PqyKPl82sNyuaIvDMo5NljDBqtmDEd/VeSmcdad4Tx
	pS7+waTJao/wG4lm1LOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUr-0000000635G-1tlY;
	Sat, 11 Jul 2026 00:23:09 +0000
Received: from confino.investici.org ([93.190.126.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUn-0000000631I-3zhz
	for kexec@lists.infradead.org;
	Sat, 11 Jul 2026 00:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783729376;
	bh=M/o/prhRHK/YAh6eE3jaspP3NcXZCBODXl03eT6DoQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC8VWkDPzB7ob+S7yGd5EF2uMjdw/GDqx9n21Eu5r7ika4JNPMz7C9MMDINoDbo2r
	 9d+cjTuOe46xHraY4wwI8tcvfEOV/pTyvzULU5OAOWhT0cFTWqDfajRbb2r/5XzO6h
	 r7069jKkuljy95dXlIXrS4SF896wb8PnBIv2olZQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gxqD00nf5z114w;
	Sat, 11 Jul 2026 00:22:56 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gxqCz2p1Rz113X;
	Sat, 11 Jul 2026 00:22:55 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [RFC PATCH 4/4] MAINTAINERS: add an entry for the pre kdump notifier list
Date: Sat, 11 Jul 2026 00:22:53 +0000
Message-ID: <20260711002253.1115-5-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711002253.1115-1-include@grrlz.net>
References: <20260711002253.1115-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_172306_147736_726699A8 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: pmladek@suse.com, include@grrlz.net, baoquan.he@linux.dev, arnd@arndb.de, corbet@lwn.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Scoped to the new file and the header so patches touching the
callback contract get an extra reviewer.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 895a87b571c3..44b6318ed692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20453,6 +20453,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/panasonic-laptop.c
 
+PANIC PRE KDUMP NOTIFIER LIST
+M:	Bradley Morgan <include@grrlz.net>
+S:	Maintained
+F:	include/linux/panic_notifier.h
+F:	kernel/panic_notifiers.c
+
 PARALLAX PING IIO SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
-- 
2.53.0


