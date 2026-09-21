Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53277C982FC
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gpQ4A2b+D+By6QZW9O9qxQ5TRwnsaRRG5wXvsN8j1G0=; b=FoyvXxyDC1cAPcgjFWpvphK3U5
	qA0cVXM9BSU0krdnwm9iq65VqJoTSXrCqdgGw/OKrEDxUb2pRMHJWhX0ILunxO8SAJQujYQhVEfiv
	jCAIGJogUtzCDFPPgfIY2mbebDJ6qLduBwq2gT+FwA8B7MIMVlktVd60Sc7zu7B4QX0XlVZgRJkeG
	qVSCJ3nk5+Hc6yalWn/x1SIydYfYbDtSUYYmS40WKT5ITVOh+c4O+PqQGX1k1u6MvA3VhCsQCfjc+
	fGdqzdjAZoqX7ThcjTAL8bv0Kgw4BS57A7W+B1ORuUT1zqQnY1AB321vLYjtgrX3M+u/u4wH1LrGH
	dD+L12PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad1-00000001ZNJ-2l1T;
	Mon, 21 Sep 2026 09:48:05 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZwZ-00000001RF6-2joG;
	Mon, 21 Sep 2026 09:04:13 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gpQ4A2b+D+By6QZW9O9qxQ5TRwnsaRRG5wXvsN8j1G0=;
	b=5yDR7210dJfFq/El83BSXaQy/Jd4qrijPdu6t1uJW27ICVE72mId1HUucilMR6cVQd3YNcu7c
	xJ5//H/5qFgYAEzzu6wOukrEi962MoeeOLcvKCME4ofqLX6PhTa+0b5cozuDLTi8F4toCSxeO1s
	JMdlwRJnBmcNHALe2SgT2/w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hpH665BLqzRhQs;
	Mon, 21 Sep 2026 16:51:58 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4738540561;
	Mon, 21 Sep 2026 17:03:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:03:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 01/14] kexec: Fix CMA segment address translation with non-zero text_offset
Date: Mon, 21 Sep 2026 17:04:37 +0800
Message-ID: <20260921090450.807575-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020411_994877_426F68D0 
X-CRM114-Status: GOOD (  14.58  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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

kimage_load_cma_segment() and kimage_map_segment() both translate
a CMA segment using page_address(cma), which returns the CMA base
address. This ignores segment->mem.

On arm64, image_load() adds text_offset to segment->mem before the
segment is loaded:

	kernel_segment->mem += text_offset;
	kernel_segment->memsz -= text_offset;
	image->start = kernel_segment->mem;

so segment->mem no longer matches the CMA base.  The kernel payload is
therefore copied to the wrong offset, while image->start points past
it, and kexec jumps into the middle of the kernel.

kimage_map_segment() has the same problem for any CMA segment whose
mem has been moved.

Add kimage_cma_vaddr() to translate a boot physical address inside a
CMA segment to its virtual address, and use it in both places.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Justinien Bouron <jbouron@amazon.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/kexec_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..7f7cb77f0caa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -738,11 +738,23 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+/*
+ * Translate a boot physical address inside a CMA segment to a kernel
+ * virtual address.  Architecture loaders may move segment->mem away from
+ * the CMA base (arm64 adds text_offset), so the offset must be preserved.
+ */
+static void *kimage_cma_vaddr(struct page *cma, unsigned long mem)
+{
+	unsigned long cma_base = page_to_boot_pfn(cma) << PAGE_SHIFT;
+
+	return page_address(cma) + (mem - cma_base);
+}
+
 static int kimage_load_cma_segment(struct kimage *image, int idx)
 {
 	struct kexec_segment *segment = &image->segment[idx];
 	struct page *cma = image->segment_cma[idx];
-	char *ptr = page_address(cma);
+	char *ptr = kimage_cma_vaddr(cma, segment->mem);
 	size_t ubytes, mbytes;
 	int result = 0;
 	unsigned char __user *buf = NULL;
@@ -965,7 +977,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
 
 	cma = image->segment_cma[idx];
 	if (cma)
-		return page_address(cma);
+		return kimage_cma_vaddr(cma, image->segment[idx].mem);
 
 	addr = image->segment[idx].mem;
 	size = image->segment[idx].memsz;
-- 
2.34.1


