Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA87C369CB
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r7xZ5cQQ1rH/ZXKdOvSi54ge/ktatY4CsJ5Ttc4zYko=; b=u10RbOFEg2z331HUewZnxfVnPH
	yAd4c92jyBXGEYYIgkEfeXBtvrK/Q1mCBMoP0kmdF69AwwcIvHn8f6tdK6YjR6LmxX2fJhcAs9K9a
	sXhCmHzdZ8/MAyVM4n0KZmP4LCM1bMqFUxEE57uLVveOWhTrcYaJC0asYQfuYsfRxixaf9p8aWQqb
	LUbva/lm3QxBVlYYbUvSyWjF6VPmqSUo10gxi+44i38J5MsZC+QNtnSpNLGNC5COJlQZHWYz3SbVT
	69IpC0Xp5YODnbzP+CW7SmyJ0EozhAGeBIvNz8LEeKT0UFrgav6/laUq7PUq6I4wYUxCtK/a4rock
	roXlewDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e8g-0000000BNnT-19vV;
	Wed, 23 Apr 2025 17:44:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7cyX-0000000B8Bv-0PTw
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 16:29:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 427FC43B12;
	Wed, 23 Apr 2025 16:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036B5C4CEE2;
	Wed, 23 Apr 2025 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745425768;
	bh=6SjkVadR1Xoah30CU+7wRwLOERvrXoUDiWriqrgG2zY=;
	h=From:To:Cc:Subject:Date:From;
	b=jPGj9QNDr5ybFkYoW7fMOhBtD+p+FoNHs8tpAiUU5G6GZ3cMJkC9pbhC7qgxgO5tg
	 +KIo3zlrtQvpY6LUPSy2fC/GpIMerXa+br2FG2bdnWXOH4t9s+A/mKpUFEqJ7xwAZX
	 oYLZzDvcNo5HV0gvJODBO60mqNs/OnFZfQnBxnd7QzSoJmwemKnhxgQ+DPFSXu8sPG
	 neicloKN61h7SApchx7Am4uBso5obtL+92rVb++/psG+8iFlfHfCRCjDxhd+lcNQHW
	 /z4bC2Z9DRZz9oRNxvZBH440N++o8M04pPrGlSyaLr2GHhLtGRLAgynN7xPCX/9wJx
	 Qyar3LvpaE0ow==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: include asm/early_ioremap.h
Date: Wed, 23 Apr 2025 18:29:18 +0200
Message-Id: <20250423162924.2213664-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_092929_170127_3C3219D1 
X-CRM114-Status: UNSURE (   8.83  )
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

From: Arnd Bergmann <arnd@arndb.de>

The early_memremap() function is decleared in a header that is only indirectly
included here:

kernel/kexec_handover.c:1116:8: error: call to undeclared function 'early_memremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1116 |         fdt = early_memremap(fdt_phys, fdt_len);
      |               ^

Fixes: 4bfe738ce89a ("kexec: add KHO support to kexec file loads")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kexec_handover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 4bbc6f5ef723..3e8a0118e182 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,9 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+
+#include <asm/early_ioremap.h>
+
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
-- 
2.39.5


