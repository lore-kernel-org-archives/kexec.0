Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E7BCCD1BF
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=puiOctPkkRjOuoUxgwNEPA+P78IsHjj9a2gG6mw0pTw=; b=FMAp3yYbTaY2QHkKbEMHXlzvWP
	Rnkl0UjSJraYyB/gSY8lBg2Fw8qceO7pkGxT/ZQOqzs8dlbdKIn8mnebj7LCLPy2lTheCr3r2xnco
	VQjoARc0zgo/MX1FI3fuh+aj8PQlsPU3/twnQfzdghFd8W2peLIWhKWqxQRvLpPTVI1SQbQF8HxbP
	RiD8ZcYD5ykq37zUKIKXajzTB93AO3L/JFGD13xXbb2wphBisnZxaArjRAQ2TvBSznJzqcm/xihAG
	4Yw5VqQufNuZGmwGOwKYypjXJEwLaggL2lGWVIZgj+42cftAIxQgKKzMGI9RZ8I9mWL+Rx7wm0mfm
	YPyWs4lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCK3X-00000009rEA-39nq;
	Fri, 24 Oct 2025 15:50:19 +0000
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.155.198.111])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCK3U-00000009rDU-3Zxp
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 15:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761321016; x=1792857016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=puiOctPkkRjOuoUxgwNEPA+P78IsHjj9a2gG6mw0pTw=;
  b=EXT432oHhcHv9i4XoEERBQREQ5qm48AXoMmyhq07mAYTsYwbRWHxxAE+
   +feOdxr1NIULeSZlXzSuZbKceAp/vJV8tw0llGd8yfjJCs025gGAxlV/A
   Ab8fnUyvq2XIjFrOnzQv0d90mS/6BwYACNzHorr+5xAnxcxqPSNlxeLS2
   y6WX9aU9LHu2tL9+sYA4pynjj5IvYAq5zzhBfRYVX8OjGMXP/uan8IXC6
   4WnAUe+fYMvIlSMx7fXDykSAFGvXzFNd0ACXzDbXcTZGHnRH0yeLR69q0
   fgo+vwD9ChKt07jGCHR5erEgklUtdyhztCffHDTDOardEGQHEzYZ0acYk
   A==;
X-CSE-ConnectionGUID: 1J5QlMDQQ0mjlHn4AQ0yqA==
X-CSE-MsgGUID: nug+SKKfRI+1BzB8GQ/a9g==
X-IronPort-AV: E=Sophos;i="6.19,252,1754956800"; 
   d="scan'208";a="5538943"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:50:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:30918]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 630c549a-7215-466d-a400-77b1726e03d1; Fri, 24 Oct 2025 15:50:16 +0000 (UTC)
X-Farcaster-Flow-ID: 630c549a-7215-466d-a400-77b1726e03d1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 15:50:15 +0000
Received: from 80a9970eed1e.amazon.com (10.106.100.47) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 15:50:15 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "Marcos
 Paulo de Souza" <mpdesouza@suse.com>, Steven Chen
	<chenste@linux.microsoft.com>, Yan Zhao <yan.y.zhao@intel.com>, "Alexander
 Graf" <graf@amazon.com>, Justinien Bouron <jbouron@amazon.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH v3] kexec_core: Remove superfluous page offset handling in segment loading
Date: Fri, 24 Oct 2025 08:50:09 -0700
Message-ID: <20251024155009.39502-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.47]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_085016_940413_EEA4C66B 
X-CRM114-Status: GOOD (  15.58  )
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

During kexec_segment loading, when copying the content of the segment
(i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
pages, kimage_load_{cma,normal,crash}_segment handle the case where the
physical address of the segment is not page aligned, e.g. in
kimage_load_normal_segment:
```
	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
	// ...
	ptr = kmap_local_page(page);
	// ...
	ptr += maddr & ~PAGE_MASK;
	mchunk = min_t(size_t, mbytes,
		PAGE_SIZE - (maddr & ~PAGE_MASK));
	// ^^^^ Non page-aligned segments handled here ^^^
	// ...
	if (image->file_mode)
		memcpy(ptr, kbuf, uchunk);
	else
		result = copy_from_user(ptr, buf, uchunk);
```
(similar logic is present in kimage_load_{cma,crash}_segment).

This is actually not needed because, prior to their loading, all
kexec_segments first go through a vetting step in
`sanity_check_segment_list`, which rejects any segment that is not
page-aligned:
```
	for (i = 0; i < nr_segments; i++) {
		unsigned long mstart, mend;
		mstart = image->segment[i].mem;
		mend   = mstart + image->segment[i].memsz;
		// ...
		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
			return -EADDRNOTAVAIL;
		// ...
	}
```
In case `sanity_check_segment_list` finds a non-page aligned the whole
kexec load is aborted and no segment is loaded.

This means that `kimage_load_{cma,normal,crash}_segment` never actually
have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
is always true no matter if the segment is coming from a file (i.e.
`kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
syscall) or created by the kernel through `kexec_add_buffer`. In the
latter case, `kexec_add_buffer` actually enforces the page alignment:
```
	/* Ensure minimum alignment needed for segments. */
	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
```

Signed-off-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
Changes since v1:
	- Reworked commit message as requested by Baoquan He
	  <bhe@redhat.com>
	- Removed accidental whitespace change
	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/

Changes since v2:
	- Removed unused variable in kimage_load_cma_segment() which was
	  causing a warning and failing build with `make W=1`. Thanks
	  Andy Shevchenko for finding this issue
	- v2 Link: https://lore.kernel.org/lkml/20250929160220.47616-1-jbouron@amazon.com/
---
 kernel/kexec_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..5ed7a2383d5d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	struct kexec_segment *segment = &image->segment[idx];
 	struct page *cma = image->segment_cma[idx];
 	char *ptr = page_address(cma);
-	unsigned long maddr;
 	size_t ubytes, mbytes;
 	int result = 0;
 	unsigned char __user *buf = NULL;
@@ -754,15 +753,12 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 		buf = segment->buf;
 	ubytes = segment->bufsz;
 	mbytes = segment->memsz;
-	maddr = segment->mem;
 
 	/* Then copy from source buffer to the CMA one */
 	while (mbytes) {
 		size_t uchunk, mchunk;
 
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -784,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 		}
 
 		ptr    += mchunk;
-		maddr  += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
@@ -839,9 +834,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -904,9 +897,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap_local_page(page);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 		if (mchunk > uchunk) {
 			/* Zero the trailing part of the page */
-- 
2.43.0


