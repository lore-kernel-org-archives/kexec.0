Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD8CD043F
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 06:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1iCm8y4kbWCIcgUpU9S1KPoq4Lc5Fqr5q19Pt4lfz4=; b=lR5VSiOgepIlO0Y2TEYHUWCSgE
	5teL+jZ4vHVepSAOcwquHSUeTDn/rPT4lPbYR9G+Z8DnhWcEX4dPWP6aDPUx7aIWkhM/Awk5qbGyq
	KMlzCTazNLEeWjPF8jccE1Jku9wAPgpBkbQYvFr94o/PRjNPz6Ed8Hga0VigKef5Lem21Ba1uXmaW
	2IzBU3dM3a4E+P4yC4zNl1Owr1NIJENnGlqlZduDjYC2yfT5hrgxsoYu3fhalb28MUWb2ef0UQgku
	ruFKnmTZii7Hn3AjkHv5p2JRdhTqq7hT1jJvggdoHhdC0mAQLbNWdPKFfkjrfFI3gC2kg9W2cjeKO
	X6aNEWjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0Ss-0000000CSva-2NAQ;
	Tue, 06 Jan 2026 06:22:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0Sn-0000000CSuQ-3ztQ
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 06:22:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767680560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1iCm8y4kbWCIcgUpU9S1KPoq4Lc5Fqr5q19Pt4lfz4=;
	b=POPTvrXuZ06+9uxk6lA9Pb70YyUY1F0mLh/6jhMQljkY0MpY30ZD3ckw9751N0aHstclgu
	+yUBKlbm/JcL0DdxnGb/mjvDituajTHGfVW7nuOG60lknSrb9OCvRRWyUV5VnOtxhl/g7o
	IA9QnRmqtUMCg1xH2i9FZIklbNBPF6A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-nWJ7AYSKMhOM0TiABpwICQ-1; Tue, 06 Jan 2026 01:22:38 -0500
X-MC-Unique: nWJ7AYSKMhOM0TiABpwICQ-1
X-Mimecast-MFC-AGG-ID: nWJ7AYSKMhOM0TiABpwICQ_1767680557
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0bb1192cbso13669325ad.1
        for <kexec@lists.infradead.org>; Mon, 05 Jan 2026 22:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767680557; x=1768285357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1iCm8y4kbWCIcgUpU9S1KPoq4Lc5Fqr5q19Pt4lfz4=;
        b=ggMMyjc2yzho7svlY+sTm+ga8VbAd8LBhnWZUOwupqtgHeYRDsxmeLpgPmj/35zeh3
         mmEzDNWRDi5LUlCis4twzfzdJZzbcTCf1ja8IEd+PH/ti/Z16o5811qJu1eVNCZophL/
         9HBCRpq1haoJ3FNI2QaRMDPb6LnM9y1mBCRWFsxj3P6EwkHqpY1wHO+HniB4UZkntw3P
         ks8KxDyiTPCpzPAf21/qOdX3uhHSAJ73hhekcWvT+dO+mu/NyKnhFiOHzalZZK/5Uun1
         Eeh3ezQXfVnl0GF8Yq1PmEsVNSc9xojdO5P2egOAX9x0MUQpg1/GwM0VUC28iYm6pap5
         z75A==
X-Gm-Message-State: AOJu0Yx4vfkHWu5ZZt5POsuqTZHRQEUcluxHu35zhQTV6E/UOXOPnrEn
	AFfic/s93k06n5tkN6sgB8J99ckeSTsnHWWDV+H/eF99WHeqHKarT9QeW4VjWa475vcOIt6lllS
	DgcAnU3C5vTEThDQ8pBoKhtiY/g/sHUuhSReV+jigUGIYQsgXbIxi3p/cUqk1GE4YcSIiYpmQAR
	RRKIQ9Bw/RYceB/5S5xEZC5Pn//xv22Dkk4vUdWv58LoM=
X-Gm-Gg: AY/fxX6pzEI+yC74ErBhTqrdWD0aJ6CXjTjk3zqngFuMqa0HuGlWHBcJa/kSATGMEDF
	sUl8aq2Tim0a18PqaFuWuatBjbnp0BKCdyx8OgSwfAR+FFh2I9L/yKhhDfb707PAl1cAn6n/nsQ
	Wsyl3hJX0ku3NUxeCUHTwwtrYLBTIOSBmSbfYHIbm9ceQZ4i99T1BwYNjO9tWFjS/LkHDru/Alu
	oyXE29Stcm+u4Nt3YOJWYhLqCEl5XuZR2dznTZIPvmwJGHz3PI1KzfMKfbW6jML1lwhqkVeDxWo
	1TmhRjkwKxlRz8ApkCl4OBbf8dbfPKkr/xZF7RoRh8XhPdaC9cfbCUu4qbEa0ypYTO7FrKsBG1r
	y
X-Received: by 2002:a17:903:38cc:b0:295:fc0:5a32 with SMTP id d9443c01a7336-2a3e2c8edfemr18998485ad.3.1767680556745;
        Mon, 05 Jan 2026 22:22:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjkYzfagGmKLQPkTpXjihNKVxM4m77yLyUH+xkoj2AwvmqMvu52zZRrnKlXNZzGMaZuNwW/w==
X-Received: by 2002:a17:903:38cc:b0:295:fc0:5a32 with SMTP id d9443c01a7336-2a3e2c8edfemr18997735ad.3.1767680555369;
        Mon, 05 Jan 2026 22:22:35 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2f8asm10548925ad.57.2026.01.05.22.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 22:22:34 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
Subject: [PATCH v2] arm64/kdump: pass dm-crypt keys to kdump kernel
Date: Tue,  6 Jan 2026 14:22:30 +0800
Message-ID: <20260106062231.448170-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226141116.1379601-1-coxu@redhat.com>
References: <20251226141116.1379601-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AV3pslb5T2d7gg_pCmb1gXHRpSGAdmSoKmYFfWTPTOs_1767680557
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_222242_054430_2D5CADAE 
X-CRM114-Status: GOOD (  19.72  )
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

CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
device dump target by addressing two challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for ARM64, we only need to add device tree
property dmcryptkeys [2] as similar to elfcorehdr to pass the memory
address of the stored info of dm-crypt keys to the kdump kernel.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
[2] https://github.com/devicetree-org/dt-schema/pull/181

Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2
- Krzysztof
  - Use imperative mood for commit message
  - Add dt-schema ABI Documentation
- Don't print dm-crypt keys address via pr_debug


 arch/arm64/kernel/machine_kexec_file.c |  9 +++++++++
 drivers/of/fdt.c                       | 17 +++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 410060ebd86d..5f3bad8ca96d 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -134,6 +134,15 @@ int load_other_segments(struct kimage *image,
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		ret = crash_load_dm_crypt_keys(image);
+
+		if (ret == -ENOENT) {
+			kexec_dprintk("No dm crypt key to load\n");
+		} else if (ret) {
+			pr_err("Failed to load dm crypt keys\n");
+			goto out_err;
+		}
 	}
 #endif
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..9b6a6a402cb7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -866,6 +866,22 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 		 elfcorehdr_addr, elfcorehdr_size);
 }
 
+static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
+{
+	const __be32 *prop;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
+		return;
+
+	pr_debug("Looking for dmcryptkeys property... ");
+
+	prop = of_get_flat_dt_prop(node, "linux,dmcryptkeys", NULL);
+	if (!prop)
+		return;
+
+	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+}
+
 static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
 /*
@@ -1097,6 +1113,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
+	early_init_dt_check_for_dmcryptkeys(node);
 
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 1ee2d31816ae..4bfb1ea5744e 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -432,6 +432,25 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		if (ret)
 			goto out;
 
+		if (image->dm_crypt_keys_addr != 0) {
+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+						       "linux,dmcryptkeys",
+						       image->dm_crypt_keys_addr,
+						       image->dm_crypt_keys_sz);
+
+			if (ret)
+				goto out;
+
+			/*
+			 * Avoid dmcryptkeys from being stomped on in kdump kernel by
+			 * setting up memory reserve map.
+			 */
+			ret = fdt_add_mem_rsv(fdt, image->dm_crypt_keys_addr,
+					      image->dm_crypt_keys_sz);
+			if (ret)
+				goto out;
+		}
+
 #ifdef CONFIG_CRASH_DUMP
 		/* add linux,usable-memory-range */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,

base-commit: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
-- 
2.52.0


