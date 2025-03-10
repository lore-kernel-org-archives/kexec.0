Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEBFC282DE
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCfHmi7JSqwfRn9hK0doUgOfig37g7tF5ZyIee0j3QQ=; b=lHBeNHvPCAJVQfSrOdy5M3Pn2D
	Nvz2nLC7nabz0xaNhSA67dqtpaSUS6/HrbVePk004hqrtmxa5Pg1WDwjgct/WT9a/oGiVY7I2x5gd
	6MPfC78bipA7BiNBqjcIF+Qr0+aKdr3PJ/FNwqXW4dEiSNdk3aLTOEmtkDz5TLEv6sprNgPK2vbuR
	DaLjPRfH8VYTzEVKItADCEsQ8gdc/gKZ1ZoYGnDLkxEPEXk6fHMaMOvvFo+pGPyn2voYKTyLhU/Vv
	YUuhGdNiHuqENl1HWAk6HTG1COr1qfh8xpB95nbYoOeT4GI+6eHH10AieHUxVTu0eVfh72K7HF4/l
	4wMQb8Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trc41-00000002ZQr-30ba;
	Mon, 10 Mar 2025 12:16:57 +0000
Received: from forwardcorp1a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:df01])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trbre-00000002WEb-3B93
	for kexec@lists.infradead.org;
	Mon, 10 Mar 2025 12:04:13 +0000
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5958960DCE;
	Mon, 10 Mar 2025 15:04:08 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-61iTaEl4;
	Mon, 10 Mar 2025 15:04:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608247;
	bh=dCfHmi7JSqwfRn9hK0doUgOfig37g7tF5ZyIee0j3QQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Zt+/vVXDKpSCu8KDQZJ8u8uEpxL5R4fTTyn3U+HF42BdMdqDXozWrf/zuiX14bZkH
	 oTU0E2qHEUTnKlbABGK7W3Ny4IiGns9mKIZhLDvhYoLMNrAZ/l3Mgu8cIFmpSlrxFX
	 CW2cOcIjkxXIsVbLsjrUPNEkV+dqhsmZyuQeWDOQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 3/7] kexec: exclude control pages from the destination addresses
Date: Mon, 10 Mar 2025 13:03:14 +0100
Message-ID: <20250310120318.2124-4-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_050410_965206_CEDC6133 
X-CRM114-Status: GOOD (  16.30  )
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

Kexec relies on control pages allocated after all destination ranges
have been chosen. To be able to preserve memory across kexec we need
to be able to pick destination ranges after the control pages
allocated. Add check for control pages to locate_mem_hole() callbacks
so it excludes control pages, hence we can allocate them in any order.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 kernel/kexec_core.c     | 18 ++++++++++++++++++
 kernel/kexec_file.c     | 18 ++++--------------
 kernel/kexec_internal.h |  3 +++
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0bdc1686154..647ab5705c37 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -264,6 +264,24 @@ int kimage_is_destination_range(struct kimage *image,
 	return 0;
 }
 
+int kimage_is_control_page(struct kimage *image,
+			unsigned long start,
+			unsigned long end)
+{
+
+	struct page *page;
+
+	list_for_each_entry(page, &image->control_pages, lru) {
+		unsigned long pstart, pend;
+		pstart = page_to_boot_pfn(page) << PAGE_SHIFT;
+		pend = pstart + PAGE_SIZE * (1 << page_private(page)) - 1;
+		if ((end >= pstart) && (start <= pend))
+			return 1;
+	}
+
+	return 0;
+}
+
 static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	struct page *pages;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index a024ff379133..8ecd34071bfa 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -464,7 +464,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start, temp_end) ||
+			kimage_is_control_page(image, temp_start, temp_end)) {
 			temp_start = temp_start - PAGE_SIZE;
 			continue;
 		}
@@ -498,7 +499,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 		 * Make sure this does not conflict with any of existing
 		 * segments
 		 */
-		if (kimage_is_destination_range(image, temp_start, temp_end)) {
+		if (kimage_is_destination_range(image, temp_start, temp_end) ||
+			kimage_is_control_page(image, temp_start, temp_end)) {
 			temp_start = temp_start + PAGE_SIZE;
 			continue;
 		}
@@ -671,18 +673,6 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	/*
-	 * Make sure we are not trying to add buffer after allocating
-	 * control pages. All segments need to be placed first before
-	 * any control pages are allocated. As control page allocation
-	 * logic goes through list of segments to make sure there are
-	 * no destination overlaps.
-	 */
-	if (!list_empty(&kbuf->image->control_pages)) {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	/* Ensure minimum alignment needed for segments. */
 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index d35d9792402d..12e655a70e25 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -14,6 +14,9 @@ int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
 void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
+int kimage_is_control_page(struct kimage *image,
+			unsigned long start,
+			unsigned long end);
 
 /*
  * Whatever is used to serialize accesses to the kexec_crash_image needs to be
-- 
2.45.3


