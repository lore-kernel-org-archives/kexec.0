Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A83DFF8864
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 06:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X32YgoESRg0ywcKfjv7wOK1DWSx0V8m7oh8gezp47dw=; b=C8XuVIGhYpJ0Xz4KKADOVam7N5
	Tz7Uq1iYuogin5QOOfnrWbdYtI5oTDk0YMTe2WPu4RClCSSSnvtIXCAwGyVFzA0PkvoPYAXqtG6VG
	Y/JYSreiXqEQ9YZ3kiQ2yMaXYmjioRP3ly3L+Dr2YDbJUnYNzQ9oVblxSoEAz403pbYrGTmMJTA/e
	NC89p83QuMQyR6DMltJMUcRLcYu5dSZAT2CVYWSkD93o/2poghvC/ld5TCZFGrQnwwK+haJOMtw+k
	n39MubnuAco4Rq02wfOzOuJE7o2fdjHL3sVtAj2SoNmEt6xPOH6AKKIwnew8Nh0XWL1K/S4u2B6E8
	qcpmQ4gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyt1-000000034sK-3793;
	Wed, 29 Apr 2026 06:59:07 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHysz-000000034qI-2CDQ
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 06:59:06 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so6908083b3a.3
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777445944; x=1778050744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X32YgoESRg0ywcKfjv7wOK1DWSx0V8m7oh8gezp47dw=;
        b=LTDfxdSOFhdtXYUGOvgPogcdyJ8FeNipoqjQo5TgexJ+0ev/gIdauhwKgKMP8cJn43
         9Tj+o1U2LalDryx3MPqzbZB2S9oHE+7Gdo8X7GKmIJDhdWlyJR3uPoAd8+Z7dvfnR3+A
         BaRYW4p0iodKigLmFHcGWsiJ/7olxvo+Adbd8aLWrxbQcBpYi0ujMnCJZeNsBj1ZxZsB
         87qxJhjZyvVnlhVwxAk0Xwik9Ub5yuAIjoBI2fo73luQl37xVRRF2J/WEVIYtAbfnGPi
         lSTXQe38/pExvo7T12+D+h7jDfBZ1MR/6WIoihS9SFLGERtklIeCZTc0ADQDdgW93wnC
         E3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445944; x=1778050744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X32YgoESRg0ywcKfjv7wOK1DWSx0V8m7oh8gezp47dw=;
        b=tNDHoiTtydITORuruWu024pMqzN62npZV82Ch2Wtp0N4d5WCC4tyHHGNasyblJUv3F
         1eGy67mY+/lyBwsLMeEebByfMVxakO3MLc3DuzMC4Icq2hcXh/i3l1zfZG4HsXUFzAof
         vSOvNE1EdjI4ky9rQKNoUS0fTG3IzZzHXJkhUZMvxXb2+kI9gB07kA83LyeSr4p8PvKB
         fPGUzcpQkWPmUk5xlhrzPQA2IpXDl0kA61nzdrko6jbMtuNkFsYIM3S2Wh3pGm2utccW
         n+vPZSWHLEFaPKT17V+FHXSckp03dSNdabE/mjO1HSZKJKNu/ZL3dDA3p2GtQKM1kgAe
         v/Cw==
X-Gm-Message-State: AOJu0Yw2tk407G7l08EbPx3iaNA09C88b5aspf5hoDOL1YUV8XCRKAbM
	K3LRv7M4fbD+CJfsrecJ/c5lt1CbEJzuBrOJnEWpU/QEr0UVLZogFLihUNR7kxMIGq47GvFD
X-Gm-Gg: AeBDiesc9fni4SMEGBKHu2XKak/S1HuxvYf/dTFJqBw8K62HScA8hINVosgoQKZmgxG
	tpOS/CyQSE/DN4mTdqD9abFO4/WCq2l51TDmoSA9xqp2RQiQ8Md8zG7JcYGwtv3CluvODiuhi4s
	JOgM2vIoDqqsY/AMRyaiNYe4rdZlSgo+P9ldVv3tWfoZ7sJW9surAdSF517MtVkVdWaM1FWjK7i
	tCAaglZ6IhJTe89rL+bo8HmbqCAx2F1n9UkItuJh8HI63nKlYGGZASFv1EoIVflc/k3ILuxsvlB
	IaqBz6mX2aHd0iqgFHjq1elt0/5BTgqJqXls2r651KcXtNBwglIE4bq4sX1JaA1M+8DzJG7/K4a
	dTffZJDiCulHwcy5QhwOZ2VFyYcr7NRTSBkW8+k0+heWfXcKVjuHtgv235w1yS26bAuQ4+sPnTn
	ek23BYtjslkHcarHstyCfQ89peM8ANzVLdCo16L3aIN1I/KbO3bau6TMRTBP4=
X-Received: by 2002:a05:6a00:17aa:b0:823:1c5f:1c43 with SMTP id d2e1a72fcca58-834ddc5725bmr6614944b3a.36.1777445944007;
        Tue, 28 Apr 2026 23:59:04 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.28.23.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:59:03 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	chenwandun@lixiang.com,
	zhaomeijing@lixiang.com,
	everyzhao@126.com
Subject: [PATCH 02/11] of: reserved_mem: reject reserved memory outside physical address range
Date: Wed, 29 Apr 2026 14:58:22 +0800
Message-ID: <20260429065831.1510858-3-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_235905_560547_E3436B47 
X-CRM114-Status: GOOD (  17.29  )
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

early_init_dt_reserve_memory() does not validate whether the region
falls within physical memory. If a device tree incorrectly specifies a
reserved memory region outside the physical address range:

 - For the non-nomap path, memblock_reserve() blindly adds the region
   to memblock.reserved, creating a stale entry that refers to
   non-existent memory.

 - For the nomap path, memblock_mark_nomap() silently fails to match
   any region in memblock.memory, but still returns success.

Add a memblock_overlaps_region() check at the entry of
early_init_dt_reserve_memory() to reject such regions before any
memblock operation takes place. This also simplifies the existing nomap
guard: the original "overlaps && is_reserved" condition reduces to just
"is_reserved", since the overlap with physical memory is already
guaranteed by the new check.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9d1b0193864c..03c676052dab 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -112,14 +112,21 @@ static int fdt_fixup_reserved_mem_node(unsigned long node,
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
 					       phys_addr_t size, bool nomap)
 {
+	if (!memblock_overlaps_region(&memblock.memory, base, size)) {
+		phys_addr_t end = base + size - 1;
+
+		pr_warn("Reserved memory region %pa..%pa is outside of physical memory\n",
+			&base, &end);
+		return -EINVAL;
+	}
+
 	if (nomap) {
 		/*
 		 * If the memory is already reserved (by another region), we
-		 * should not allow it to be marked nomap, but don't worry
-		 * if the region isn't memory as it won't be mapped.
+		 * should not allow it to be marked nomap. The region being
+		 * physical memory is guaranteed by the overlap check above.
 		 */
-		if (memblock_overlaps_region(&memblock.memory, base, size) &&
-		    memblock_is_region_reserved(base, size))
+		if (memblock_is_region_reserved(base, size))
 			return -EBUSY;
 
 		return memblock_mark_nomap(base, size);
-- 
2.43.0


