Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE38C3DA4A
	for <kexec@archiver.kernel.org>; Fri,  2 Aug 2024 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CEP658pALyhpRoSL/QTz5Oy2qz2pTQzgNqk0oTZJMo4=; b=lLvaHCIZAYFWBb
	A9LJpfcyx6b/u/p2rBzzBa9TqDvjxe4v7tBRdLOeKkXQvAK0GycmnvlNtbohOKChGRScq04PeH9b0
	NZYIfXs3B9YNLPdZATi6IEN9Yp2PLA7QXQ+u9ik69rIAgqoFlJpAmmenX9ejCz203qsNWGDOZBNnW
	liQp4TKzTdalxsaEhCXuOTYvMeDcrvWteRLCLbtJF0HfywKiwJIbcHOAxFari3Fa1L/k6acYfvwLC
	5ABgHf4rnrfP1uoEV42cCcbJylZE6334Z1NJHoavZ2Pf5hb52+VXRJngkscL46x6IdWexmQzPr/bp
	Ifo9Boop0OH4oIyKfKWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZo4H-00000008AVb-2Kls;
	Fri, 02 Aug 2024 08:55:21 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZo4D-00000008AUy-3gyB;
	Fri, 02 Aug 2024 08:55:20 +0000
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wb00X2n0wz1j6NP;
	Fri,  2 Aug 2024 16:50:36 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F8A31400DC;
	Fri,  2 Aug 2024 16:55:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 16:55:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<chenjiahao16@huawei.com>, <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Date: Fri, 2 Aug 2024 17:01:05 +0800
Message-ID: <20240802090105.3871929-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_015518_130328_271451AE 
X-CRM114-Status: GOOD (  11.98  )
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

On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
will cause system stall as below:

	 Zone ranges:
	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
	   Normal   empty
	 Movable zone start for each node
	 Early memory node ranges
	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
	(stall here)

commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
bug") fix this on 32-bit architecture. However, the problem is not
completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
architecture, for example, when system memory is equal to
CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:

	-> reserve_crashkernel_generic() and high is true
	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
to simplify crashkernel reservation code"), x86 do not try to reserve crash
memory at low if it fails to alloc above high 4G. However before refator in
commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
crashkernel reservation"), arm64 try to reserve crash memory at low if it
fails above high 4G. For 64-bit systems, this attempt is less beneficial
than the opposite, remove it to fix this bug and align with native x86
implementation.

After this patch, it print:
	cannot allocate crashkernel (size:0x1f400000)

Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_reserve.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5387269114f6..69e4b8b7b969 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -420,15 +420,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
 				goto retry;
 		}
 
-		/*
-		 * For crashkernel=size[KMG],high, if the first attempt was
-		 * for high memory, fall back to low memory.
-		 */
-		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
-			search_end = CRASH_ADDR_LOW_MAX;
-			search_base = 0;
-			goto retry;
-		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
