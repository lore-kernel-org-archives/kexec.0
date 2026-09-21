Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D48C982F9
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=exT85uJQjkgif9mGkOjx9OW7SNCVfp7++L6BnEZoSKA=; b=cRXjgeGOKFRQoxBPg3g7V3RfU1
	YNNzUF0G+YGVVaKXMsMlYThkoORs+w/a9JqJ5JiTMjSVsWE4wcnWTjn0ONwzKrG1ctrDYk0JwAGtw
	9FihOov0PBxA9viYV9uV8n5HqUjKlpqlZlfKvp+ges4WyBgAXrPJNu04B8CAJnu77fngU5vi3lXYz
	WMgMsoSSmpWjhUJ3PKJsRcO0gMogn8edOPVKVUTYJyuMOJ/K3i6cRmsGVtZmMs3oUcV02cN5fZzFe
	MynisYDe0gRt0I3fNLmijzhMFGnYPMFInT3sIaDYA0C/dcCovySXVuvpLAnTGeRBJzeE+X5Sz5sV3
	eK5Aft7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad4-00000001ZQ4-1VsI;
	Mon, 21 Sep 2026 09:48:06 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZwZ-00000001RF4-31yg;
	Mon, 21 Sep 2026 09:04:15 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=exT85uJQjkgif9mGkOjx9OW7SNCVfp7++L6BnEZoSKA=;
	b=ftprzc4s7QFctL2nl+sgGFpQqjZKPEpbBNWw8vL33PgDLcDsvqh5dBKWq4JOmpUMYJmDb90q6
	IJuhC3VJ9RTKizQD1/q1MihCFoIHC1v30oVjT/+WRSf4LOomKTAr4sWIxZAPI3AZyPBfeHEChEO
	PMPkCDZKcqwLlcsusoXrH9g=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hpH6w3d2Bzcb3G;
	Mon, 21 Sep 2026 16:52:40 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F951203B8;
	Mon, 21 Sep 2026 17:04:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:03:59 +0800
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
Subject: [PATCH v6 02/14] kexec: Record allocated CMA pages to fix release size mismatch
Date: Mon, 21 Sep 2026 17:04:38 +0800
Message-ID: <20260921090450.807575-3-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20260921_020412_132774_99D3270F 
X-CRM114-Status: GOOD (  16.46  )
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

The CMA pages allocated for a kexec segment are released using the
segment's memsz to calculate the number of pages. However, some
architecture loaders modify the segment's memsz after allocation
(e.g. arm64 subtracts text_offset), causing the release function to
free fewer pages than were originally allocated, leaking the remaining
CMA pages.

Add a per-segment `segment_cma_pages` array to store the number of
pages actually allocated from CMA. Populate it during
kexec_add_buffer() using the aligned memsz, and use it in
kimage_free_cma() to accurately release all allocated pages.

This avoids relying on the potentially modified segment->memsz and
prevents silent CMA memory leaks.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Brian Mak <makb@juniper.net>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Justinien Bouron <jbouron@amazon.com>
Cc: Li Chen <me@linux.beauty>
Cc: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  1 +
 kernel/kexec_core.c   |  7 ++++---
 kernel/kexec_file.c   | 13 +++++++++----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0af8ae4fdd08..6b1df80524bf 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -349,6 +349,7 @@ struct kimage {
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
 	struct page *segment_cma[KEXEC_SEGMENT_MAX];
+	unsigned long segment_cma_pages[KEXEC_SEGMENT_MAX];
 
 	struct list_head control_pages;
 	struct list_head dest_pages;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7f7cb77f0caa..5493591a9e4b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -560,14 +560,15 @@ static void kimage_free_cma(struct kimage *image)
 
 	for (i = 0; i < image->nr_segments; i++) {
 		struct page *cma = image->segment_cma[i];
-		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
+		unsigned long nr_pages = image->segment_cma_pages[i];
 
 		if (!cma)
 			continue;
 
-		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
-		dma_release_from_contiguous(NULL, cma, nr_pages);
+		arch_kexec_pre_free_pages(page_address(cma), (unsigned int)nr_pages);
+		dma_release_from_contiguous(NULL, cma, (int)nr_pages);
 		image->segment_cma[i] = NULL;
+		image->segment_cma_pages[i] = 0;
 	}
 
 }
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d8..67d6df9824e6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -670,7 +670,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 
 static int kexec_alloc_contig(struct kexec_buf *kbuf)
 {
-	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
+	size_t nr_pages = PFN_DOWN(kbuf->memsz);
 	unsigned long mem;
 	struct page *p;
 
@@ -756,14 +756,16 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  */
 int kexec_add_buffer(struct kexec_buf *kbuf)
 {
+	unsigned long nr_segments = kbuf->image->nr_segments;
 	struct kexec_segment *ksegment;
+	size_t nr_cma_pages = 0;
 	int ret;
 
 	/* Currently adding segment this way is allowed only in file mode */
 	if (!kbuf->image->file_mode)
 		return -EINVAL;
 
-	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
+	if (nr_segments >= KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
 	/*
@@ -789,12 +791,15 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 		return ret;
 
 	/* Found a suitable memory range */
-	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
+	ksegment = &kbuf->image->segment[nr_segments];
 	ksegment->kbuf = kbuf->buffer;
 	ksegment->bufsz = kbuf->bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
-	kbuf->image->segment_cma[kbuf->image->nr_segments] = kbuf->cma;
+	kbuf->image->segment_cma[nr_segments] = kbuf->cma;
+	if (kbuf->cma)
+		nr_cma_pages = PFN_DOWN(kbuf->memsz);
+	kbuf->image->segment_cma_pages[nr_segments] = nr_cma_pages;
 	kbuf->image->nr_segments++;
 	return 0;
 }
-- 
2.34.1


