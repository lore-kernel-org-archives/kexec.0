Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D6FCCF9F8
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8rAQbHFDbivgcpxLCDF/vP/CPRZRLVftucEUjeFRHHI=; b=X6hjgDld70o6St/jG+o4MTvDsb
	KK5IL7QROPMtjomefpK/T+bL33fTPxFyX4zkdSFwp5TbAo7u+Rel1EL6U3c5AdRt/V4tcH6UCuT5F
	ZRfO/7LTYvz5cxEWoJiO+UkSZjH0mB2Xh9agV1W5hpjoud6MDe1UufT4ocaYHYS/65cKVlHRLOQUF
	v3ZndkGJXov0RR4sGC1jQOUTFIb6aS4gc7rqa0bsRuoS24eb7T0J522qsOYt1rTmU4mQPp70yIk/l
	PlPu7miXQhX2ShubyqaaWaxPBmJjduy1rk61YtDyRK54qZOSgZrF9jOJOPfIKMVeEsv+htngE/0EL
	l6N3000Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGadE-0000000DSpK-07Br;
	Wed, 05 Nov 2025 10:20:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGadB-0000000DSon-19Hk
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 10:20:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AA271401C5;
	Wed,  5 Nov 2025 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A592C4CEF8;
	Wed,  5 Nov 2025 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338044;
	bh=6FveslA51ZKW3pLjQVKvZG5cxo/vtJS7IwDZAhcHSHU=;
	h=From:To:Cc:Subject:Date:From;
	b=WE37hOhQUGONWW1HuZkGx/QwivLViWcVBLBYY7/qI62GihtTnJ9iPrGkLCmPvhzzh
	 26BHCN7CVQSdC7Yoh5rvDVmfRgel3Ue4Kcmnq6ouHGs3jqTLiwSy6lx05mC/VczSH8
	 xS5KKvCDr3xEu501VMCArrdxnIExC5RMIjJaX6A5dTz2tIpTBrTr3vCxi/Klqcn7g6
	 PlK6acReLoZ9lL69NZfkqaPajZjqyKKkMi0cyrqkUxa7vbZrRwZZmMRQfdNkxC4Y8d
	 9gEvPs3K28qPrsaIfWmSofFO669wrl33Ul+L0+nXvdEHJWFCBTOMlgScd72ALGmGVi
	 n9cBKMI/WK3EQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself as a reviewer for KHO
Date: Wed,  5 Nov 2025 11:20:19 +0100
Message-ID: <20251105102022.18798-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_022045_354200_A0918B7C 
X-CRM114-Status: UNSURE (   8.06  )
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

I have been reviewing most patches for KHO already, and it is easier to
spot them if I am directly in Cc.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ee7cb5fe838f..3c85bb0e381fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13789,6 +13789,7 @@ KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+R:	Pratyush Yadav <pratyush@kernel.org>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained

base-commit: d25eefc46daf21bd1ebbc699f0ffd7fe11d92296
-- 
2.47.3


