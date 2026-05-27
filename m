Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361D2CD5BD1
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DuujAuF8eXBWdShhG/kW229CX67XgkUB6V+YnX45VpI=; b=g3oWw8/u61m838WcwSG1PNdDEo
	a16ak0o3OWJKgSkJznxNs+IVthSZLFNISwwMFYTiZSfGtfuZwganqU9yFoO51e5yoDscUrHlfOcL5
	UJmlhUhq8UEacMkpcsxwQrRwBCjVUkRKNBYQmvj3+j6N76Pe9syxNdTQxlZNyYCSl40tgvzssvvgq
	rCQLen4rQYOASnOVQvsKoLwTrD73lx3cIZe4mabrHEMjXPKxF9aEPwIOaE6mxi2l47PUXdTilO5YD
	ATnpLxYyQJffUu7AoN1bM8GZtWMylK6P4ULHFuYLqhjPgeOTt4qfWuyrxE8qWrFb3xH7g46HvMQK7
	b+1QnpZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yT-00000003F90-0qJy;
	Wed, 27 May 2026 03:30:29 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yQ-00000003F4r-0fmr
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:30:28 +0000
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso4790988a12.3
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852625; x=1780457425; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuujAuF8eXBWdShhG/kW229CX67XgkUB6V+YnX45VpI=;
        b=q4hWZSCKeiettoonFVyxzyJfFK1x1pvzT3sEomlFnWnCa7DgPF4MarS8TyYcjlMfga
         dj26DTqcU69U4sKvJlYJPbNc+RvPtzSqQa8DLEhqzsKBLOxwtKY42SYFqrPEl+MMA1rn
         arglLLVzqyRPeveX0jvFCGAmU5jctr5t6DjYaO+ubWO54+O46UzWnvIdB0T9yMylZ7hO
         zPDQRkgriDKHKBuuTu3exUd9sxF5nhIs6fbhnBWl8PYEh3p8kg09C6yRggXvuy38IXWU
         Pq+FbCNRA8C2WLhyn0yWh47JbD0sBsDEGBePgczXjpdeo1GoOTpxepp1EnZBun00Arom
         XSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852625; x=1780457425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuujAuF8eXBWdShhG/kW229CX67XgkUB6V+YnX45VpI=;
        b=HcI1zeDQx0esRcEjHKllccoM2r4ll6LlSv7dOzaRKBxwGl6i+mqVcKEsZVYyy4RHjg
         3uS82ODekWxXqQTbyi+S4pGlQt33O4MlyQvNJdBP+pPthf8YYSq2/D1NBMAyhPGzb36S
         CMBVvs/VTZE2NfGJ2/DOq3y+Gykj4Qjk6HZRIP0NrFEoLmaNHKDOz+ha9B38C2BxEvzN
         RIlLPLJBmvoSdn80EdbbaNIxdM4/zGfGY+YIlvR7LSdHTgYTgNI9CdYqBeVPcaqwS8tS
         D7UMZwKxSh7P47CzleMkyUMdT6jHm1BKL+6zBCQClIzmCi/UKT/M4eGp849klnfacr1W
         8JlA==
X-Forwarded-Encrypted: i=1; AFNElJ+R1Kg5ZdaR30pyy8u30uGiBn4uR9yX8dfvNpl2LWfL7VHfCMWynzV5AIpK/ZTt5Gunwp4V8A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzmw24Knh4+PujFEeV9S0W0kx381dySen4dUdmUPA4w6r4L2uWW
	DaACu701YtUROGmCTtXhAI8y75bV5oVHUXbB/ByVhtcBUMAf1CcyUkxOcOAalEXdgCFoHA==
X-Gm-Gg: Acq92OEs/WwX5mUhcgLrKS65un33ajaYn1fTpINkDurHp4xWAQXPqWv68B8/zTD4y98
	pE2sB6fZuIZulH8pa7xjdrRKRCmyuuWpzIXglLmIW1rVjpZ42vt/E7jQoWmNczX98zjuLa2zGO6
	iGpUbvFR6FQiIYCJ4phXFTpGt/4Kj4TCu9ZoAnXUvwEKrenYavrlI1By3Tov1JCPR1ZhRSc/qa4
	TKAnWtQt0MBTuzEIkrAL62VESu5v9FjkBH8B+2yzXbN/4hgZwlhQgwAKrUddXD1fgWTH7VLAUFI
	7LLX03YXCfNxJrvEFYoZwoIiqgwyu/wxqomqfZFfGacoizAkjw1MRl2ySu//i0xeXQE2cycxz1u
	S+V3u9q2stAui8MWZEIH2WjiArH5eGPBzgE2XagkfprAedMMyZU4iE2rceuihKZVKZo86BYFrag
	MA9Bpaebc/gNpCB+uUT+aSMuhOfInckBVclYPV
X-Received: by 2002:a05:6a21:6d81:b0:3a3:17f8:bedd with SMTP id adf61e73a8af0-3b328cc257bmr21442620637.17.1779852624627;
        Tue, 26 May 2026 20:30:24 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:24 -0700 (PDT)
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
Subject: [PATCH v3 05/11] of: reserved_mem: split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
Date: Wed, 27 May 2026 11:29:11 +0800
Message-ID: <20260527032917.3385849-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_203026_207265_90AB489E 
X-CRM114-Status: GOOD (  17.06  )
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

Prepare for storing /memreserve/ entries in the reserved_mem array.
alloc_reserved_mem_array is skipped if the device tree lacks a
/reserved-memory node, pointer 'reserved_mem' continues to reference
the reserved_mem_array which lives in __initdata, storing
/memreserve/ entries into reserved_mem_array would result in metadata
loss, and an out-of-bounds memory access will occur if the device
tree contains more than MAX_RESERVED_REGIONS /memreserve/ entries.

So split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late(),
and call alloc_reserved_mem_array() whether or not there is a
/reserved-memory node.

No functional change.
The actual /memreserve/ population is added in a follow-up patch.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/fdt.c             | 7 +++++--
 drivers/of/of_private.h      | 1 +
 drivers/of/of_reserved_mem.c | 6 +-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 82f7327c59ea..83a2a474831e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1284,8 +1284,11 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
-	/* Save the statically-placed regions in the reserved_mem array */
-	fdt_scan_reserved_mem_late();
+	/* Attempt dynamic allocation of a new reserved_mem array */
+	if (fdt && alloc_reserved_mem_array()) {
+		/* Save the statically-placed regions in the reserved_mem array */
+		fdt_scan_reserved_mem_late();
+	}
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..50e5a533e059 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+bool __init alloc_reserved_mem_array(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 05defc91e901..888dcb6bdce5 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -69,7 +69,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
  * the initial static array is copied over to this new array and
  * the new array is used from this point on.
  */
-static bool __init alloc_reserved_mem_array(void)
+bool __init alloc_reserved_mem_array(void)
 {
 	struct reserved_mem *new_array;
 	size_t alloc_size, copy_size, memset_size;
@@ -272,10 +272,6 @@ void __init fdt_scan_reserved_mem_late(void)
 		return;
 	}
 
-	/* Attempt dynamic allocation of a new reserved_mem array */
-	if (!alloc_reserved_mem_array())
-		return;
-
 	if (__reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return;
-- 
2.43.0


