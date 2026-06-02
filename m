Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3528CD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VDGW0w8sKFr9y+yQO1wAjpaei9XRMCKNAmjogGC5NxM=; b=EIOg7u+cz41Y2bRP3CZEUtgKSh
	grIoWWph1R8tYsvM0cQJn82bY1+Eg2+IRgkLjLGfp3BXKSvAZuJSfMg/HeDKQ9oqTzqTvz1uUEEhC
	ADW/ku8/JmKBhzD4Uf4Oqlmti9Z62khaYOnPZuBrFavoFBHKF/3TsRh6lzJ016J094WXLuXKw6h0b
	kLyibaYmfM3xElmSo5kzbKODYs2RL/rrL/eeAhwDvUR82bgxZDfiJ4baJRnwsqKeSZwZC+JMFmdUL
	Q/ZRDOkZG7u5eYZ2Uonn0Q017taX+FrOFlnUQWTl6txx2XCKg/WGRpL3MWJP9BUEdAqnGdYcd7tw/
	/lpGP98g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOJB-0000000CzTF-3XVb;
	Tue, 02 Jun 2026 12:33:25 +0000
Received: from mail-lf1-x149.google.com ([2a00:1450:4864:20::149])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOJA-0000000CzSh-0VRp
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 12:33:25 +0000
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-5aa6dbdee74so1184776e87.2
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780403601; x=1781008401; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VDGW0w8sKFr9y+yQO1wAjpaei9XRMCKNAmjogGC5NxM=;
        b=GA2yLPh4eI5J9UK96d4ALcjPAZLuymDYd+jWtj9EaMxamP/haMJEgf41Zh9xGJTzh+
         s5z7FSIa+w65I4gJaBBin4u3T1D9VKZtLINgdsn56Qg6dKqUGQKF8Q2oYdbSihaYh4Uv
         a0+PT/YhUbAXpFRkPlcy56jQOMrb4fksfNRW3BAkq3WOju+2ktEqnMi4IN2cn/Nf4YXd
         vCKWIik7PeZ/pUTZhd8G38yAt6dPelWf3PYdbVsZUHA+Wqrp2IfdLPqlHGeC9cbpRdIT
         N7uSf2p1F2ghTWL68VEx0QwEaapEm1VnVFM3a8en6O26yTAf6p8VQAoPFv8mDp0TydGm
         OOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403601; x=1781008401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDGW0w8sKFr9y+yQO1wAjpaei9XRMCKNAmjogGC5NxM=;
        b=oZxihQ/x0SThasqTLtB2Mtuzso6bALZ+YCsZpRjLK1QH+R+A/ToJZBwco7iGRXvAeX
         DTv4BnufVx2c7p8bYti9XsefBNmRO8N0xmaBHiMINrRShrywy5LZHvH4gqh/E0kBCV/r
         ALPLjB5q+hYqU0xJfe14jPqti9H78CxqB5TTb3xBIMFD7OcuaG6A1gbmlQV+94LFdohQ
         FeFR06KNUnByeBEvNSqqzHGwGp9pVr30/xpvrHncEsI4HBmRf5t2mpDAVmH6y9b8xTZF
         MesgwtQI9iPq+4CxRYkbEykchSw2ncLMl79Ai3goMePMKSAtYa3gcD0CxbP9cbOQQ5Dw
         B8xQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IASpFpLrBZV3UTjAHRZUH9LCbp7WwziImC16lBtmorj3eUAJo/7mFG6gBk/6v/WuwI9fNYw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJcHpnOB8Aa3/RDrW6Dvw2QnXkT9fT7BCS32Uf6jHupxbf/LFo
	hqHAG+DKjdkEO2lxL0GoQaoytcEFidVcrMb7aD5P2qwdEjWBoz/eirt0Sd/IyNo9AnfeWDS8JGt
	Zm+ZYurLUAsIZBnIQr0WWUQ==
X-Received: from lfbf26.prod.google.com ([2002:ac2:509a:0:b0:5aa:6821:c3d1])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6512:39c3:b0:5aa:6ede:62 with SMTP id 2adb3069b0e04-5aa6ede020fmr2156947e87.17.1780403600611;
 Tue, 02 Jun 2026 05:33:20 -0700 (PDT)
Date: Tue,  2 Jun 2026 14:33:11 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602123311.1841746-1-mclapinski@google.com>
Subject: [PATCH v2] kexec_file: skip checksum verification when safe
From: Michal Clapinski <mclapinski@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Cc: Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_053324_177506_C2D9322D 
X-CRM114-Status: GOOD (  20.35  )
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

Checksum verification is needed
1. for crash kernels. In a crash, we can't be sure the kernel is
   intact.
2. if we're worried about relocating the kernel into a region used by
   some DMA that wasn't properly cancelled.

If KHO is enabled then relocations will happen to KHO scratch, which
is free from DMA regions.
If we used CMA to allocate segments then relocations are not going to
happen at all.
Therefore, we can safely disable checksum verification in both of those
cases.

Instead of adding a new variable to purgatory, just skip adding regions
and save the default value of SHA256 hash.

Saves ~250ms on my 4.0 GHz CPU. This is an important saving for the
live-update project.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
v2:
- also skip checksum verification if KHO is enabled
- small fixes from reviews

My original idea was to do 2 changes:
1. Skip checksum if all segments are CMA.
2. If KHO is enabled, allocate the kernel inside kho_scratch using CMA.

This way we could skip both relocations and checksum verification when
KHO is enabled.
But I realized that step 2 might not be possible on warm boots.
I have no idea how to fix that (except weird ideas like 2 kho_scratches
that we swap on every warm boot), so I decided to just skip checksum
verification when KHO is enabled. This unfortunately means relocations
will still happen.
---
 kernel/kexec_file.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e6..db25a14692ab 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/dma-map-ops.h>
+#include <linux/kexec_handover.h>
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -798,6 +799,16 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	return 0;
 }
 
+static bool kexec_only_cma_segments(struct kimage *image)
+{
+	for (int i = 0; i < image->nr_segments; i++) {
+		if (!image->segment_cma[i])
+			return false;
+	}
+
+	return true;
+}
+
 /* Calculate and store the digest of segments */
 static int kexec_calculate_store_digests(struct kimage *image)
 {
@@ -822,6 +833,21 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 	sha256_init(&sctx);
 
+	/*
+	 * If KHO is enabled, the destinations are located in KHO scratch.
+	 * KHO scratch can only contain early boot allocations and movable
+	 * allocations. That means there is no risk of memory corruption by
+	 * uncancelled DMA.
+	 *
+	 * If all segments were loaded into contiguous memory, there will be no
+	 * relocations at all, so also no risk no corruption.
+	 */
+	if (image->type != KEXEC_TYPE_CRASH &&
+	    (kho_is_enabled() || kexec_only_cma_segments(image))) {
+		pr_debug("disabling checksum verification in purgatory\n");
+		goto skip_checksum;
+	}
+
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
@@ -867,6 +893,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		j++;
 	}
 
+skip_checksum:
 	sha256_final(&sctx, digest);
 
 	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-- 
2.54.0.929.g9b7fa37559-goog


