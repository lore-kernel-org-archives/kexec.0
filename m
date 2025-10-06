Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68554CAC5B8
	for <kexec@archiver.kernel.org>; Mon,  6 Oct 2025 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+HGVWrxAkg8mWbnk47FbeDyfZnbZtnHncdoKf7Bqyo8=; b=Myk43fqZI17dzSlFtegOiPMk7i
	x2QaDxMtWv+nUZTbppXvOLSQH5OlmgFzOoR7esR7gNAQDNlm9l82TEx+JzGmPjCpXPIL61azYKwMY
	Lyai26pq1wddBOEE7eG3wD+aM/3YOPPd0mfl2qbyTU5jGVCpiUkyAbpauz97Ss5lzL2DpDbgWMH7G
	p7lcuM3Z3elskJEnDwHr9ikF9xFfz+xRtIPCnPx9/AbTIkvR7hvXt/ddm56ChA4KC3FPiS/x87Otw
	6hXN/CAbLM5WJQ0l4EZUkihgpq+7+uXsOKX6DjJNZmoiTlRp8U2ef7HWy2cb6GFfngohYSJE//ruh
	4QuKnx8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5sLb-00000000nxt-2aek;
	Mon, 06 Oct 2025 21:02:19 +0000
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.162.73.231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5sLY-00000000nxW-48IN
	for kexec@lists.infradead.org;
	Mon, 06 Oct 2025 21:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759784536; x=1791320536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HGVWrxAkg8mWbnk47FbeDyfZnbZtnHncdoKf7Bqyo8=;
  b=lMaQOowPZij7wxQGPbTGVq9tI1BAVslrXO6jfIE8+r2hdTtrVthkGETo
   FSVakiOqVymEbg59JaTLBsqOTHkmYbdm9IPutqUL/os9eVNls9YjuiHk5
   0f/cUwuoKBg+bBRko5y9kWrKoPm8pVldM64k+evQkt1e0A4h4c7LvFJ9p
   O5Uxn69KsdUFtYgI8iV9voyLRnhtLQpl5S93Gjpy0qyGgpVFGMtZbdrqv
   SLAOiXTo8Ju1DjzIRhhPa/I2F/iLIweDEaWBL0AASuYPpkgGMVHFVy5k9
   qDq9OOxHpBNYxb9AlocUxrVVOmfm/Tro0w5aoheYW7F9P/ffDVhZDw+qd
   g==;
X-CSE-ConnectionGUID: aGfvPIMmT0C9oeSHdw+dWA==
X-CSE-MsgGUID: QwLFr7KzRROBNwjrgm9I+A==
X-IronPort-AV: E=Sophos;i="6.18,320,1751241600"; 
   d="scan'208";a="4213438"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 21:02:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:54205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525] with esmtp (Farcaster)
 id 6d952f63-38db-4a53-b686-451eb39197c1; Mon, 6 Oct 2025 21:02:12 +0000 (UTC)
X-Farcaster-Flow-ID: 6d952f63-38db-4a53-b686-451eb39197c1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 21:02:12 +0000
Received: from 80a9970eed1e.amazon.com (10.106.101.23) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 21:02:11 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "John
 Ogness" <john.ogness@linutronix.de>, Marcos Paulo de Souza
	<mpdesouza@suse.com>, Alexander Graf <graf@amazon.com>, Yan Zhao
	<yan.y.zhao@intel.com>, Joel Granados <joel.granados@kernel.org>, Steven Chen
	<chenste@linux.microsoft.com>, Justinien Bouron <jbouron@amazon.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH v2 RESEND] kexec_core: Remove superfluous page offset handling in segment loading
Date: Mon, 6 Oct 2025 14:02:05 -0700
Message-ID: <20251006210205.72059-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.23]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_140217_068995_074EA50D 
X-CRM114-Status: GOOD (  14.36  )
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
---
 kernel/kexec_core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..3b279d9e0d01 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -761,9 +761,7 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	while (mbytes) {
 		size_t uchunk, mchunk;
 
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -840,9 +838,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -905,9 +901,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
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


