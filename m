Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C8C3DA7F
	for <kexec@archiver.kernel.org>; Mon, 12 Aug 2024 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PUMExzzWZBaYbYCXFE1kgjwIe6Z00lQj3qSF80IJ/SY=; b=XoLbPh6i1YEj4U
	oo/cegYR9MA1bvpN4lmsc/RH+cNLFo0PoytB75eKMRL5wm6Y0Duky9lN5Lf8gpfETdQtIYAqm2nBs
	gG1QUq8dtOmn+CR2s08sbYCdork0wEAZuqwQEcjasjiPsKmvMJbuIXcSdHe+NM2WRW7llyDv17n2A
	m904tZLnNSU7DIh3tCYRZXOIo3kQIpHr3p/53Wy2Wuo30hcS6RNmG3qekfbs0QHiMwq+38jS/Fe3k
	eT99doTtZ1FF52RZ2pFEP7geEdVfl2sATEy86Ce/lwGrGWQDtWLrvODMpwUtR7mvwPRxxJvJOddvZ
	ujw2sBpRCt1w+tGMr7mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOJY-0000000Gyjo-3P21;
	Mon, 12 Aug 2024 06:13:56 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOJU-0000000Gyi9-2Sww;
	Mon, 12 Aug 2024 06:13:54 +0000
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wj3xb4K1vzQpcx;
	Mon, 12 Aug 2024 14:09:07 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9213E1402E2;
	Mon, 12 Aug 2024 14:13:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 14:13:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arch@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] crash: Fix riscv64 crash memory reserve dead loop
Date: Mon, 12 Aug 2024 14:20:17 +0800
Message-ID: <20240812062017.2674441-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240811_231352_915292_9C1BDEED 
X-CRM114-Status: GOOD (  12.03  )
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

As Catalin suggested, do not remove the ",high" reservation fallback to
",low" logic which will change arm64's kdump behavior, but fix it by
skipping the above situation similar to commit d2f32f23190b ("crash: fix
x86_32 crash memory reserve dead loop").

After this patch, it print:
	cannot allocate crashkernel (size:0x1f400000)

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
---
v2:
- Fix it in another way suggested by Catalin.
- Add Suggested-by.
---
 kernel/crash_reserve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5387269114f6..aae4a9e998d1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -427,7 +427,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
-			goto retry;
+			if (search_end != CRASH_ADDR_HIGH_MAX)
+				goto retry;
 		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
