Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632A606AC3D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=czyg3PHT;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKcDV15F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=h6dwKVBh50DCzDeIRT2L9U5TfDV06YRfq9HuX25Gdcw=; b=czyg3PHTEik3ELtg3LwSMbgUN4
	9L0SWTNuD29/4q6chkNtACMV5muShoGq7+RrWSrhNd9Rn3kfOZ8P4v+s6oJ+9Hkb6eJQyFLm3snGj
	c+PINU15yNL/s+3596yq6MIFdc0D4E0N4Jpd3q6JFJhfbNrjiq8YuEd1t6F+FxcoKlCI3kY9ikfNg
	wYZ/x6E0CP/oMGCX7EnUM9pA4vR3qi9QOFyYcoGVsMZh+vZ17nllZLJKoJE3LnZpN7jY4YuK56RGA
	OpnuwXiC+ekSTeO8tq1mncG940JP8cY6Fs+srRgSegfeFubBr6XS3KAzJ8td1wvTYKG7rF/FlEB+6
	YZuGGGVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhoj-00000006vdV-0GSX;
	Wed, 04 Nov 2026 20:42:45 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhog-00000006vbz-15Jr
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 20:42:43 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so10358735e9.3
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793824960; x=1794429760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h6dwKVBh50DCzDeIRT2L9U5TfDV06YRfq9HuX25Gdcw=;
        b=IKcDV15Fm0JVoJqMbqYHDr2La1NSQR3lKr0N+jv38SJWuDs9afqN7gm0tzFC995JOB
         45yQIDTTgUKZ7d4huqEZZxPAaY+e6hkNu68wpGFkH13L2uzk5m1jwiVN+LG7+oaQWaVn
         DEys3mA5yawSwmHa3XhX9wj6ik/7M0Hcg1hI69wtvTXluFbxFxMQ0JJMPLJRAZoWMF8g
         wJj7oSXxvTriRKBMq4xyu+inSDXGz0oLximR6Qkl1Qkj8+y+9011s9UXOJpP2qSa6UhJ
         4b/xWpeCgHSKjPwVttREgRLBpaPuQt11IaFgCEANYKEz1KpsStCjXcIOXUt7mmsHNscG
         i6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793824960; x=1794429760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h6dwKVBh50DCzDeIRT2L9U5TfDV06YRfq9HuX25Gdcw=;
        b=u+5Acx7MJ2/cNd9myliOxk4Wnx6lp0UYMo4FQx/EGRMcVIE/tE7kMUWUwjomtRksdr
         8945D3GLaDvMYlgDoLVPg9S4Jr/YE0SF8V1+l5CCsx7kZmg5LU+lrKUAcfwPu96xUxYz
         ecs0Hxi+KktaKx/OWV/nZwShbZBGo/CV0T+1lwYbaZw3VZd9aXzYl3zOQd9pweGMegl/
         /uhGC1anW9VfXl5URpymKXqHMfIeMLL6Kp689GcGSAIoXrKvyMobKWqNTZAmJqJF9K72
         NU3ZWWukqahHs6lPJbKNhzXVKJi43EGr2yQITTPvg9wuDX24GOIUz0IopHNdz/Gyho4F
         Mjmw==
X-Forwarded-Encrypted: i=1; AKwUvBxt9pQ3q5bFhtIJc0aEe/BG2M3coTbY5EW5qlbTml0MH2cspe19mzrzIFsSKMsf3mU7fgNnWQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9HdOb+qM6+qFx994xt6mNj1SH2zsxmlGb6DCw/j5ofUNz3vBe6
	2MKYm0163v0O4QCV1bkTB4cXNVQATHRb0b8830FG5FSsC5hYMoOcW9gu
X-Gm-Gg: AYBFou3jdNckBoPbvW6TG5th5d72Mnxk5Mi+LYzhilFGREW8BW0Ot+qb88trzo6dHct
	vHFD0iMWFtI2X65KOaNe32Nqk525Wq0vkxR4qC2R3TguU2RNCI/ziXmAdM3zZ1qwuNnrEQKAs+b
	mJt/HFkC/UtMmsLhT/ZsV6nmHhnRmSbB0kKKkLATy+2h2PGmfIcHIip86ushT4Y3AHit4SKj7GV
	63NY5RHa9yEGZ1HTu0ev4oGNd9oYlbv478tYmpAkiMC4nsUSd6mWtOLUoWF+oM51wo8JWQZmIOk
	gzueTFQJq/9J8HzVZrX8jvk1CCBMKWQgonPmcv2EUdqczk1RnFPlhiTq7YgVsbS7sC2qX9ixzWZ
	b336e9nrcpfC/hl91dxM/A3Bo/8saoguey4OI2QPh/ZLJXy6gUlQCdsYL468anAemaJUVx2+G67
	4C7dz8gZL58ekk+sdabVbWynP7ht3wUmAdi2y9sdThGrmOXj2HOsqRaFAjz771jdEkz+mmn7sL6
	3j1CFELCDDJyzZFL9yYIU9P+dFtN2oWNvKRSGhQJwkhsqNOkRs8WObCCVtNhF+cHSCMUP3ziItC
	/X/zxAmufrq1Dg==
X-Received: by 2002:a05:600c:4f55:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4ac182dcba3mr424220875e9.17.1793824959945;
        Wed, 04 Nov 2026 12:42:39 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac1a1csm5716451f8f.12.2026.11.04.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:42:39 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>
Subject: [PATCH v2] memblock: don't allocate new reserve_mem regions on a KHO boot
Date: Wed,  4 Nov 2026 21:42:17 +0100
Message-ID: <20261104204235.9066-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_124242_310685_7C22F186 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a KHO boot, a reserve_mem region that can't be revived is allocated
from KHO_NOPRSRV memory, which includes the bootmem the next kernel
boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
then fails:

  WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
  failed to prepare memblock FDT for KHO: -22

Without it, the next kernel puts its memmap on top of the region and
the ramoops records in it are lost.

There is no use case for adding regions across a live update, so fail
instead of allocating, and drop the TODO.

Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- fail on a KHO boot instead of allocating outside bootmem, as agreed
  with Pratyush [1]. this drops v1's patch 1.
- not an RFC anymore.
- based on v7.4-rc1.

v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/

[1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/

 mm/memblock.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a450092a80fb..e325e0542c9a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2827,7 +2827,16 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_kho_revive(name, size, align))
 		return 1;
 
-	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
+	/*
+	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
+	 * which includes the bootmem the next kernel boots out of. Only regions
+	 * handed over by the previous kernel are supported.
+	 */
+	if (is_kho_boot()) {
+		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
+		return -EOPNOTSUPP;
+	}
+
 	start = memblock_phys_alloc(size, align);
 	if (!start) {
 		pr_err("reserve_mem: memblock allocation failed\n");

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0


