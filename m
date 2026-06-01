Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20237CD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x73312yTLBbhfljYcI9Ib0e0L1yAbNQCfiacXPd/r+Y=; b=F9qPWCtSUkboR+qWitGPto7Xn7
	KBd7e2XUf+V727t49hk+BLKp1OF1FRKqGaCtnJcwpOonsB+8hjKpO9wyW2j6WSDmuYRr2oWJ5wM0R
	dk8UopJX+5VB6Z+z7q/BOBXeTkocErgoNmLKLRxKSbK0Zx2J28K9rkKEZUrSVXEHnCvBI+1mnPDC7
	rdI298lAWMnhjd2drb2EOPcFhOoQHnHw1aHSZ0otnPNNEbpWoCh8Hd6IxROVZzj1sN8om3yhn6QCS
	UYl9iBxOkbdYKAJLSHfftvYK7X4la5fzKpb0JqfY9KfkqdnP8eeMyo97Rr/mReZWDKqAbZyAYkluT
	x6C1O6dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU83F-0000000BhZs-1uxQ;
	Mon, 01 Jun 2026 19:11:53 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU83A-0000000BhZX-1ewa
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 19:11:49 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68c34fda5bdso692908a12.1
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780341105; x=1780945905; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x73312yTLBbhfljYcI9Ib0e0L1yAbNQCfiacXPd/r+Y=;
        b=ENgwehJdpgH3AXhlfkJSYeCNnVGawZ/4ak7mPYp4QbNOl1TUpunayaPKOPnV5DT/Es
         /fAFcisYXzBdfkr3taECKdayVtE0MgCjG/xBaVUKwbQzX2iW1E+w577k0F9YzHNpmSHw
         XiEJ0Mry9CArtWym/5ljQ7baxSqW05uSeYNmZVVY/Kckrlq5JYWYcfvm9Xsr9mgTG1Uo
         lculkYsOa7Q3KeCnnCLJwRz0A8QfTjS1R5Fd4q1YJsXJ6H3608huGlt9EYnav7Zpq8/9
         DSSvLK0C02JVdLbiqTma+3y9JGd/fXZ8STJ95avLrM8UpoAM1owHs2OwPKS0yNMwpeN9
         1dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341105; x=1780945905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x73312yTLBbhfljYcI9Ib0e0L1yAbNQCfiacXPd/r+Y=;
        b=hA6VbQq+YfxlG9LAvXocUVd1N8EDN4cAjAkrd4YN5ZxUx9+V+MkYF1pGMBPslPc3qt
         xTFsibbR677r+MMk95mftHzLy0y9Tbl+9e3LHzW610BqswNGpLzqTKFa9ODZAlJmvmF1
         hZsk5CxtgR4Jc70W2UDsnsTqGmkg+Ra8ZDRUynu7EP18joHTBQeMstE/8DlPNdSDh4De
         Xw8gjrMLQyKO+NEp9aOFN0OK/Jil06ruWRglxG+TKCag/GiXfLSRvbxzJJ51IZLlC6Ct
         yCJ1EopDT/qlsF9ZvLHab6D2/QLmMxNOv11OlC+2QoOmwRhLeW8k9FTsliRUdOMBodSC
         B2Sw==
X-Forwarded-Encrypted: i=1; AFNElJ82DsN4d0+WYPert1kB//9tW0v7a69411+SDWQE/kQY+pAoHmDtqMysHF6q2epNrg9rhuHy9g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwiPuQ5XNWoumuNnYNFYkqV8kyx84eOjOA+bC60k31cpdOPohFl
	Q9hIjy36XqNJ+w5hlHhFsKNc3gORO7F+DuGqKXwmZXGRZKLl9jfWAKW7IghB/v7uQXIjPmjIB0C
	gL5bqDj70MFGlP27LrwiE9Q==
X-Received: from edvu10.prod.google.com ([2002:a05:6402:110a:b0:676:9c6b:6e9d])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a418:b0:687:2ab9:f4a0 with SMTP id 4fb4d7f45d1cf-68dd7818266mr374734a12.5.1780341104979;
 Mon, 01 Jun 2026 12:11:44 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:11:36 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601191136.799134-1-mclapinski@google.com>
Subject: [PATCH] kexec_file: skip checksum verification when relocations
 aren't needed
From: Michal Clapinski <mclapinski@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Cc: Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_121148_446074_2DCA1806 
X-CRM114-Status: GOOD (  14.83  )
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

If we used CMA to allocate segments then
1. we're not working with a crash kernel.
2. relocations are not going to happen.

Therefore, we can safely disable checksum verification.

Instead of adding a new variable to purgatory, just skip adding regions
and save the default value of SHA256 hash.

Saves ~250ms on my 4.0 GHz CPU.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 kernel/kexec_file.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e6..2dc8b0435fe6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -808,6 +808,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	void *zero_buf;
 	struct kexec_sha_region *sha_regions;
 	struct purgatory_info *pi = &image->purgatory_info;
+	bool can_skip_checksum = true;
 
 	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY))
 		return 0;
@@ -822,6 +823,23 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 	sha256_init(&sctx);
 
+	/*
+	 * If all segments were loaded into contiguous memory, there will be no
+	 * relocations. In that case there is no risk of memory corruption by
+	 * uncancelled DMA and we can skip checksum calculation.
+	 */
+	for (i = 0; i < image->nr_segments; i++) {
+		if (!image->segment_cma[i]) {
+			can_skip_checksum = false;
+			break;
+		}
+	}
+
+	if (can_skip_checksum) {
+		pr_info("disabling checksum verification in purgatory\n");
+		goto skip_checksum;
+	}
+
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
@@ -867,6 +885,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		j++;
 	}
 
+skip_checksum:
 	sha256_final(&sctx, digest);
 
 	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-- 
2.54.0.929.g9b7fa37559-goog


