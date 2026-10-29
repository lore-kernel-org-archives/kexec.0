Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A6606A331
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lqs9CQne;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FpX9XV92
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YeQsqnpkwn6ypXN7vyNImbLG7QIbHLNRV1Ffg9tI2a4=; b=lqs9CQne0J7jts
	gcmZxtDaIXYRIW8J9kpdoh8b9GlocbighBIiqAoFy8NYbWl8kcrCQRcSrCt8yvSE+cuW+1lyIWtt5
	cw1ozbxMhhruELs7N3HAop/xDrmEgg2S0p5dnLDVEmEDH7T6sTjGgQxlgREyrW6Bv+bBxG8yrj5CE
	86T9mJPOjHRXWnK9JrRUkuS5f18vm1elJOTn3utDHBq3nK4A1D7FTgtRtFdgsN427ppW7Khrh/285
	5jZboxE+ZUJOZCzrxu5rs2oI9Fy2XQiv00lWu0U9A7izEhxf4xnRddiiooevIeVGV4lGM0JOhAT4q
	iyrWYRaSi0LkxXV8g2FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxq-00000009ye0-1Vwi;
	Thu, 29 Oct 2026 17:30:58 +0000
Received: from out-237.mta1.migadu.com ([95.215.58.237] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxo-00000009ybT-0Ay5
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:30:57 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=5xQkj3N9yiVJ8AVum9FtJNkr8nMttgbgXIeAZWsu7R4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793295053; v=1; x=1793899853;
 b=FpX9XV92A0v/B1Tp65pVnzHFflZPsb/Paqgp5DTXqZzfwEOcbIYDvyjn/jkvkoHcKBLGzh0/
 6unVyNBofcX839jRDqKW1UmW2dv6/m5EhOwc+cVK5Nc6TT90RVisiUXypBi6CNimLs9DaW7jg8/
 74i75g7i084UaIvQJWOHH12o=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id e9111306d7fcf669;
	Thu, 29 Oct 2026 17:30:53 +0000
X-Mizu-Trace-ID: e9111306d7fcf669
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
Subject: [PATCH v6 5/8] LoongArch: Allow memblock arrays to resize
Date: Fri, 30 Oct 2026 02:29:52 +0900
Message-ID: <20261029172956.20791-6-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029172956.20791-1-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_103056_233163_AC1DAEB7 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Guo <guodongtai@kylinos.cn>

LoongArch never calls memblock_allow_resize(), so the reserved region
array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
(INIT_MEMBLOCK_REGIONS + NR_CPUS).

After kexec, kho_memory_init() reserves every range preserved by KHO.
Each range that is not adjacent to another one needs its own entry, so
with enough scattered preserved pages the array overflows and the
incoming kernel panics:

  Kernel panic - not syncing: memblock: cannot resize reserved array
  Call Trace:
   memblock_double_array+0x2d4/0x2f8
   memblock_isolate_range+0x54/0x1a8
   memblock_setclr_flag+0x44/0xe0
   kho_preserved_memory_reserve+0x78/0xb8
   ...
   kho_memory_init+0xbc/0x394
   mm_core_init+0x124/0x154
   start_kernel+0x568/0x6dc

The liveupdate luo_stress_files test with 500 files triggers it on a
kernel without CONFIG_SMP, where NR_CPUS is 1. With CONFIG_SMP the
array is larger and the test passes, but more preserved memory still
overflows it.

When the reserved array is full, memblock allocates a bigger array
from free memory. This is only safe once all memory in use has been
reserved, so enable resizing in arch_mem_init() after the firmware,
kernel and initrd reservations are made.

The memory preserved by KHO is reserved later, in kho_memory_init().
A new array cannot land on it either, because kho_populate() already
limits memblock allocations to the KHO bootmem areas, which hold no
preserved data.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 6fa4a22a58fd..dff2e0c67ea0 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -402,6 +402,9 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
+	/* KHO may restore more reserved regions than the initial array holds. */
+	memblock_allow_resize();
+
 	memblock_set_bottom_up(true);
 
 	swiotlb_init(true, SWIOTLB_VERBOSE);
-- 
2.53.0


