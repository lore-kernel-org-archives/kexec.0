Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE981D4336E
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pwDObE/G1BfwhHTTvkJQ7iWyEhDvPUTAI1iZE0TzAIE=; b=XAO8EE/ESbhtNkkMfOSAQclJNC
	cIs2idyjYC8sq/TxQGw275bgHCpinsrTRZySL2mDyG1QNi962uC7qnDQhUnL0trkFJVmUBiN45MWb
	A7xSInA1FLgey6wBPivKlHQpUjPTVrNnQDp8dNjjcMuo/lpSWWrSINkGcG9EvHALBPXLPxLJIPOW3
	bsVlf2+ANZ7B1OPHYWTY2Fq9zcE7JmcNsY/xbkolxUlSpNzlXB1p4Xr01o/4uBVEbLWg3p08V8ygp
	ouAregcZkYpcwdR3m2hhYwKXguwUbOhW2USfgMRfopjPsXGusHLcaadmkoEjUQMel+kV8rizt8Pxu
	VA/mV7XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTxKQ-00000000C0S-3wHL;
	Fri, 12 Dec 2025 07:12:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTxKM-00000000C01-1dMf
	for kexec@lists.infradead.org;
	Fri, 12 Dec 2025 07:12:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A8E8841831;
	Fri, 12 Dec 2025 07:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8F3C116B1;
	Fri, 12 Dec 2025 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765523553;
	bh=VQI1ixqU/VwWGZqg+DPna6u3ZBdsY/8hJmGuLZalUYo=;
	h=From:To:Cc:Subject:Date:From;
	b=QEsCh096RYH8wJEmj0TujySEBnuf7HIc5jz+UgDDxsrGEw8KpO+TG3Vag0Ut7w6LE
	 kKVjmAj7+/NmobEoyGgdJ02V901kWnBqhhlzZ8nrMeRuPBrgw8yP68z0BEfFug1yEx
	 QQHgUBdcc2miJlkJpdABsc1r38CLsAF5EEAQbKGhC2ClUBZqtCWI2LO8RT73aPtFXa
	 rrjzh0jaZBqbZ+rumwxYGJcEBuWIxM6JJespX1tqYOIwTADHitoa34XB1k1iI3xUcz
	 t1NSIOP9XgLHFzmda+EIN9jNWrhd5+cs3q2GLI8tYEqJ18sw2AVLvjj0PAwgn84YUb
	 ++xRvVTb5N5MQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add ABI headers to KHO and LIVE UPDATE
Date: Fri, 12 Dec 2025 16:12:02 +0900
Message-ID: <20251212071204.398788-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_231234_449681_526B6D24 
X-CRM114-Status: UNSURE (   9.54  )
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

include/linux/kho is supposed to hold KHO headers. Add it to KHO's
MAINTAINERS entry so the right people can get patches to it.

include/linux/kho/abi contains the live update ABI headers for LUO core
and memfd. It will also hold ABI headers for other upcoming file types
as well. Add it to live update entry so live update maintainers can get
changes for it (currently they happen to be the same people).

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Eventually we should have separate maintainers for each LUO file type
    and ABIs. But for now keep it simple and put everything under the same
    entry.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 656e29624d4f..99b3c84d6be5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13799,6 +13799,7 @@ S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
+F:	include/linux/kho/
 F:	kernel/liveupdate/kexec_handover*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
@@ -14475,6 +14476,7 @@ S:	Maintained
 F:	Documentation/core-api/liveupdate.rst
 F:	Documentation/mm/memfd_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/kho/abi/
 F:	include/linux/liveupdate.h
 F:	include/linux/liveupdate/
 F:	include/uapi/linux/liveupdate.h

base-commit: 601cc399a01049efa76be8f496541315dc9cf914
-- 
2.43.0


