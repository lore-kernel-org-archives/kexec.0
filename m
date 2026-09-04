Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77FAC624DE
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CceRez2/ldfpLjVhVSMoZAznwntxXxH+q+GNhQlA/r0=; b=krhq/O6LHHctawYxeDficZf3KC
	j9VAcRJcLen1gq/749xJbBlhWIHkSfGZKPnkbR9mHVw6xKJGlpYYbjxdKnYQeuLBqfh1ns1u04rNK
	FVRdRP8waZMUJAWLGEcm53b/akLMRXu4gOIBI/hA7mj44BZszDKOlG4wPDnuHd9WURAHKe49BRdEg
	70hmIvPE3hMyb5V8UYSfkWjZALXg7syAiMsKgWR1mERPCU5e5vo9qJvLJiJfbMxiqFLKXvlRiuBOa
	hxLtHPbeGqWUc8MPo/WxYTiqqouNoTDbzl8tz901ssRD6OOsQUyK4Y9wyO5UvLDW5c6Vw/uC7Z1rC
	/yZxivBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsY-00000001clh-1DwA;
	Fri, 04 Sep 2026 10:10:38 +0000
Received: from out-86.mta0.migadu.com ([2001:41d0:1004:224b::56] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsV-00000001cjc-1xo4
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 10:10:36 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=9aOZu5joPDLJyi4gz7dO0f9aMIY13LvVV/UJCIG+uIA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788516633; v=1; x=1789121433;
 b=OMDA5LLrG8KDrfPVcchlsXbhmMDk865MrwFysRUs9ECTzubH+1uug4zwb1SxLQgRgJp9sDPU
 pfj7iDyCFWimdOIUFY3t2hkpZQ+W6CkKvuoIsdKvaRe8pZJdifYCaEboSCRwYEXnZxlVV+TDQUq
 IZXhR/Swxia4qtJDty0ZJ7oE=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 94f18b2629cbbf22;
	Fri, 04 Sep 2026 10:10:33 +0000
X-Mizu-Trace-ID: 94f18b2629cbbf22
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 3/5] liveupdate: kho_block: include linux/mm.h for virt/phys translation
Date: Fri,  4 Sep 2026 18:08:50 +0800
Message-ID: <20260904100852.26006-4-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904100852.26006-1-dongtai.guo@linux.dev>
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_031035_652501_D6D0EEB3 
X-CRM114-Status: UNSURE (   9.44  )
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

From: George Guo <guodongtai@kylinos.cn>

kho_block.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
CONFIG_KFENCE=y, these macros (in arch/loongarch/include/asm/io.h) expand
to offset_in_page() and page_address(), both declared in <linux/mm.h>.

Since kho_block.c does not include <linux/mm.h>, the translation unit
fails to build with CONFIG_KFENCE=y:

  asm/io.h: error: implicit declaration of function 'offset_in_page'
  asm/io.h: error: implicit declaration of function 'page_address'

Add the missing include to fix these build errors.

This is the same root cause as the luo_session.c build fix previously
acked by Mike Rapoport [1]; the virt_to_phys()/phys_to_virt() calls have
since been refactored from luo_session.c into kho_block.c, so the fix
moves with it.

[1] https://lore.kernel.org/r/ai5nYlbERQBXRHSp@kernel.org/

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/liveupdate/kho_block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..0d56891b2f4c 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -25,6 +25,7 @@
 #include <linux/kho/abi/block.h>
 #include <linux/kho_block.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 /*
  * Safeguard limit for the number of serialization blocks. This is used to
-- 
2.53.0


