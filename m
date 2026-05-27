Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63D5CD5BD2
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nz17AGesBxrxvpMg+ldtjUwMkbrsU+FQ5Omh3mR+f58=; b=mD+RReQ1RBkyzwn9SNPiel5t4y
	YUVNFVfDXHxolaEg8Z4fdptegNLHGxJG21T5W+c11sy1aqf0RX0fthIwLukMMpHNTpoAOs3tGAohk
	hE0nIJhJpqqYHkfyV0G6uYXGmSTfLJNOrqCNVmnWzAgjEIkxQmBY5IvU2FLaq+zhC+7XprtFsVV8w
	DJloZMEcIzWyCSIUbCXJ9q+MjQt5eZ+mpHvizbX16Ud7P35uQH4Leuadtr22CtNlt0Sl3bEGDtcUy
	2+Ew/j+bWtrUmTZTd8vYDh9kMRh6bQp+2ozyT7mxX2/IkPTz86PaOqjMpow9k4lj1V4eneF+fohSM
	yShg5RCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4y3-00000003Eig-3OHX;
	Wed, 27 May 2026 03:30:03 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4y0-00000003EeX-2WLl
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:30:02 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-841513664bbso3083538b3a.1
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852600; x=1780457400; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz17AGesBxrxvpMg+ldtjUwMkbrsU+FQ5Omh3mR+f58=;
        b=DeBO29+M+CzT4Lkw0NUu6t2Gth0Q7AKYXm+4qwlmp8A0HbuNGpTQDkQR4f/2q2N1Wq
         Wue5sUhI3aFKsgL7O8WWPrVMCeAuEa4ldu77jcr8/Pga6rb+Qw3DcQ/OIjlS0I+TtBwY
         ktarfE/Uv64Aq9WpQogtKsF1r/c43hKPQEmDgXSiVZPJNTFEBzxCQzDRiK2U3napV1gY
         ZihMMg5BKR9M3uRUgyGmnEOkQiY5GhxRslFS6XfdS/jLpRjpXd8BIh24EA4kB4zraBww
         gUQKKuOlV1dLv9rHyNNAnvoIyg9O+SVoxFtY4sGwRECRQMTAqRK//D9Vhnx1KlP0IBgz
         /ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852600; x=1780457400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nz17AGesBxrxvpMg+ldtjUwMkbrsU+FQ5Omh3mR+f58=;
        b=ab9UbYa+0rRi+F9qDN9iJwp1u3ifWsb+4UHSscc3Fg0KOfYyWs9kP/P7LiBXYS4PeV
         Q5o0W2Lv5fUokesz1LfCgVLEP9UMYCoiVegKnZZHh26Yizk4vfljcITF5BIUO6ZBlZcH
         Zej+az3p5yZwCDcE2W5XrIbvtOluf30/bD5FZivvA6yQobRwyOZmsLdebqNhPCrzoInZ
         xHgku9HbtP8u22KGIZhTmPYV+YYSgksvRM/+vNQVUEo1HNFfQ7bD4BZvVlzJCqpd6PDN
         1AVOb4cHqIMBMgAY53RporpPZtZWOA51fmAlaQOMSn+ee3J2kMh0U/25zqbs7Ti8sC0u
         G2HA==
X-Forwarded-Encrypted: i=1; AFNElJ90PZq9DCDIDwzgwrIvdaL04zlYnxmkqWXB1mGZ0eXfywOqgngjv+gUBvSqQBhtDMa5jH04Cw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1krMgqvIrjuF5aB1HDk4aVfe2Nv08UOjvryiod9J3fOK/Dppa
	qePctTzlFRMueWF/DPQahemZ02WHib7HXBwU36MV1NoOV0soU+MYvjow
X-Gm-Gg: Acq92OGHZcSM3Bq+Xk54X7kszRFrDYK0rkFhmqdin2WQRgJ+HXuhWb1LLQ6PobLk5ce
	mnUe2Lqtmpz+zqHhUhxAo7/he2HeD2T8Fed753xJLaHIh7B1uJtrBq0w3hUOnVs+QvsG3n/iabW
	274rdcrMkb6cqKvDowGK2QyCVyY5LZ4qDJlV5SMiHxGUUQhzcHOI2BK/sDKHzUrIpWqStiKLdZX
	wWyZZc+VuvbqEhW8T/SMYWRmZYUDiKPE4XMBFMH02ij7uMegsKjZRyIgwbFv5A57nmaPozIo8E2
	02WVXIAu0z74K1soupUTUW+KFB91jiNE2VsTvkZrOeIHHNJGY1HsvbEL1jFbwrrzHLwyx2ljXpK
	fisrb2+1Nxrz0PGlZ4Ci4QaOaUJ6If1JV8EJg1Tj9ahCq4cxIyAmo6Btn/f72RoYus0JRjGhjWw
	+ht5xCFPZhnL1gJZyk5lilJYOHCnK9j3O99L8z65pi51eCISk=
X-Received: by 2002:a05:6a00:ab86:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-8414b427c3emr17125755b3a.11.1779852599870;
        Tue, 26 May 2026 20:29:59 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:29:59 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 03/11] of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array() fails
Date: Wed, 27 May 2026 11:29:09 +0800
Message-ID: <20260527032917.3385849-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_203000_652383_042FECAA 
X-CRM114-Status: GOOD (  14.61  )
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

From: Wandun Chen <chenwandun@lixiang.com>

The global pointer 'reserved_mem' continues to reference the
reserved_mem_array which lives in __initdata if
alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
exported for post-init use, that would dereference freed memory
and trigger a use-after-free.

So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
fails.

Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 313cbc57aa45..6d479381ff1f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
  * the initial static array is copied over to this new array and
  * the new array is used from this point on.
  */
-static void __init alloc_reserved_mem_array(void)
+static bool __init alloc_reserved_mem_array(void)
 {
 	struct reserved_mem *new_array;
 	size_t alloc_size, copy_size, memset_size;
 
+	if (!total_reserved_mem_cnt)
+		return true;
+
 	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
 	if (alloc_size == SIZE_MAX) {
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
-		return;
+		goto fail;
 	}
 
 	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
 	if (!new_array) {
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
-		return;
+		goto fail;
 	}
 
 	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
 	if (copy_size == SIZE_MAX) {
 		memblock_free(new_array, alloc_size);
-		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
-		return;
+		goto fail;
 	}
 
 	memset_size = alloc_size - copy_size;
@@ -100,6 +102,11 @@ static void __init alloc_reserved_mem_array(void)
 	memset(new_array + reserved_mem_count, 0, memset_size);
 
 	reserved_mem = new_array;
+	return true;
+
+fail:
+	reserved_mem_count = 0;
+	return false;
 }
 
 static void fdt_init_reserved_mem_node(unsigned long node, const char *uname,
@@ -266,7 +273,8 @@ void __init fdt_scan_reserved_mem_late(void)
 	}
 
 	/* Attempt dynamic allocation of a new reserved_mem array */
-	alloc_reserved_mem_array();
+	if (!alloc_reserved_mem_array())
+		return;
 
 	if (__reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
-- 
2.43.0


