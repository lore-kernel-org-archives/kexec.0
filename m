Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF0F10854A7
	for <kexec@archiver.kernel.org>; Sat, 14 Mar 2026 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4k6CpHj3cAuenf8CUhu4WfhqIJLP10A3qud/G1UciUw=; b=phZE3hYULQK2118TiKwy25q2LP
	DIq7PqiChLTeA5A66FqfyjZjk/9ZZPJzAGvgsZlxjA5TVoLy+SV3qW1ieaYUf4wx3tVdpLcjCSHfx
	nJjD5Sfyrq4zpii7oCQ0mQ6AH1Am9AZegctw/lHHpocbuSLDXD354EPliyvuCXwTCSHxh+ccuCltZ
	FZXROnb7GBo3OJSapb6H5+PPH+R3Kuk/qpA5aE/Tgel76pRA6N5TZnMjC4cX3MbDY3WJB/JR/4o/v
	n2ibOWgklQ52QTK0pcdSRQCsYQRQ4BtkE4bnMPh2LVQad8dNt+5OKbEpchXBQFVyu3ueoC6d1VdkP
	0GnahEiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1VoY-000000029Wt-0HV1;
	Sat, 14 Mar 2026 20:42:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1VoS-000000029Wi-1w5O
	for kexec@lists.infradead.org;
	Sat, 14 Mar 2026 20:42:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 89A2260121;
	Sat, 14 Mar 2026 20:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB074C116C6;
	Sat, 14 Mar 2026 20:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773520939;
	bh=3MyRZyHFOwGHloTPezn9JMoFcYJ0FFqkU9SBJORQdYg=;
	h=From:To:Cc:Subject:Date:From;
	b=XlRKjYZ1KGGyHC4B+mLNLD6cwYqWY+togujJ/2nsEemHMDp0HXWa24tW8RhVnOYXB
	 IFnP0OnOaitj1tdccTNaJ3GdhNjV5+A5GujNfrAk0rbzQs7qYRFpX8jXsgLsNIbD10
	 /32hW8NELhjG9SxQNhyISoHHouAhvIS8dNXwktHtaHwdloJfZmkAO3L+7HjchJzD4U
	 A/73BSIeBECg3PxkuLDUmIcyN4drNmbeMkFz0dtmvw0mZn/9fvFglhbcSNO5V5Sfco
	 qL/cK3jMis4F8x15WyIUEEe+w8xqkMPmYGPXh8fywB9/MkoBEjRULm14yTKtkDRm4K
	 5STeLDUYpxsNg==
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] kernel/kexec: Remove inclusion of crypto/hash.h
Date: Sat, 14 Mar 2026 13:41:44 -0700
Message-ID: <20260314204144.44884-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

kexec_core.c does not do any cryptographic hashing, so the header
crypto/hash.h is not needed at all.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 kernel/kexec_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2fea396d29b97..a43d2da0fe3e7 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -45,11 +45,10 @@
 #include <linux/sysfs.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
-#include <crypto/hash.h>
 #include "kexec_internal.h"
 
 atomic_t __kexec_lock = ATOMIC_INIT(0);
 
 /* Flag to indicate we are going to kexec a new kernel */

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.53.0


