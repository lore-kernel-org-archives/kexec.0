Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642B5CD6E4A
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MpDsKqtekJF/ott3Wm9QFal8yf1kb3vz/4aJWlmRjiw=; b=WAX6dbFWTr5lpXfcQjKnaiZJIy
	npday/KZhTAkoFlB3sypgsvxSowtIUuqGd9gdSTA+vyoCnivahIW0zr2ByLyhZ4o9OJdkUMj0gydU
	upzRVOaJhlR3oTeO9B0c34ml+2TDA0kuzKsCn0UZXzmmRSny1VHkcK/c9B6HbfDsM6J5Mr/POFQd0
	02RqedWWBkBVj5Uf+R+zmRev7rUF2rPt7foPeMXuatYu8Ipvdlizh9P6N4b/CRCmu+tIPoBo9/ExJ
	u2Ya4SaM+blJqj9RQLoyl3/o/4T8Ht3iHo1Z6Vn07namfHEBKQJ5bbKuaR3Lc3GeWrIBUL+8lsZqx
	PdUBqDrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV4H8-0000000GUTZ-1Sjc;
	Thu, 04 Jun 2026 09:22:06 +0000
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV4H4-0000000GUQw-3p3G
	for kexec@lists.infradead.org;
	Thu, 04 Jun 2026 09:22:05 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780564913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MpDsKqtekJF/ott3Wm9QFal8yf1kb3vz/4aJWlmRjiw=;
	b=fY9klKKlP4cXfhABmPRlqYQP+b6Iu9wu75MwA7pQElSgeZMor7qdyydSudzS3Kjz5MZkDy
	iPnHz85+14rrN+cZvmJi2kNolTohKYjYGyKWSM+sCV6IOktlJOTj6H+bZOVbNIGyJgE+JC
	0+7Mi11pATjgp3/WiglhFnDG+hcyIQw=
From: George Guo <dongtai.guo@linux.dev>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH v2] liveupdate: luo_session: include linux/mm.h for virt/phys translation
Date: Thu,  4 Jun 2026 17:19:13 +0800
Message-Id: <20260604091913.306603-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_022203_643354_5A44A4ED 
X-CRM114-Status: UNSURE (   6.92  )
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

luo_session.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
CONFIG_KFENCE=y, these macros (in arch/loongarch/include/asm/io.h) expand
to offset_in_page() and page_address(), both declared in <linux/mm.h>.

Since luo_session.c only includes <linux/io.h>, the translation unit fails
to build with CONFIG_KFENCE=y:

  asm/io.h: error: implicit declaration of function 'offset_in_page'
  asm/io.h: error: implicit declaration of function 'page_address'

Add the missing include to fix these build errors.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
v2: Move the include from arch/loongarch/include/asm/io.h to the consumer
    luo_session.c, instead of pulling the heavy <linux/mm.h> into the
    low-level asm/io.h header (per review feedback). The 0-day report
    confirmed the v1 approach introduces a circular include
    (slab.h -> kasan.h -> asm/kasan.h -> asm/io.h -> mm.h, where mm.h
    needs kfree() before slab.h declares it).
Link: https://lore.kernel.org/r/20260521063310.52926-1-dongtai.guo@linux.dev/ # v1

 kernel/liveupdate/luo_session.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 7a42385dabe2..4ce7128a4ae9 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -62,6 +62,7 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
-- 
2.25.1


