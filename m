Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2629FCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ICQyIKowVj3RyrjMn4gMzYuhROzG3qohL1WARXEfQY=; b=z+bIsnh/s+nKk5QBSI34mIuu+j
	PDk4ei5YMqcEGTgFEoSJ0JkIEbL2fqKPEPNumaMEsN7GPG1xwy6tsPO522wv4GhI7QxLZi28/BDHM
	AaLP6Ukd1XPkZHC6Nxm8wyNglmmQd6ejUHeoEI+jFTBtQxEvsgAuZvWQmXCqmYXRXBxtELplWetpl
	cOfNfa9G4uk58UqSBJVJfYAwIJT3K0oHCiU41LfGSXGuDwSRGiTs1Ig23RZaA5miGFjqMcL5lySdS
	4Mwra1PCpPP46Xt06hufOtHU/OADbS1M4FE90aBmcRkAHByjNBBFLwqxPEAL0l24N82DmJXVIcNY+
	726q4CPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbG7-00000002659-0eQV;
	Fri, 16 Oct 2026 06:17:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbG6-0000000263w-10Vz
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 06:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9ICQyIKowVj3RyrjMn4gMzYuhROzG3qohL1WARXEfQY=; b=EZqEy0jieMekzTzKtcieD4ck9g
	dKP9PQf4S4pcXBsfbi9/JG1/smkhIwMVHcpSu0KOlWXbPl8aFHenrZloVL0ESP1fXAivJcas4oQwq
	WhYw73zii89eQ/qZ4Wp45g9YUhOG07pjJODWRtZiiuRoS2kBZ7jzY7bPk0M5XZEhe9I1U67QTehVy
	rxCyGSuxmeiDHRQqBbEI0h6fD5rPrlv0Ks4eU0+3mjg6NBRrCgLTf7yz88aZFvVpfFAxGOk6e3yuw
	CpKbPqONW1VM2sLgaIfkvrbwwZtdMNduMDlubFxKF23oDQI2hDuCZyPQRTe/bZTNsqYTHeDNrXfiE
	MHULls+w==;
Received: from mail-pz2-x0b.google.com ([2607:f8b0:4864:3b::b])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHbG2-000000019rI-3oBS
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:17:37 +0000
Received: by mail-pz2-x0b.google.com with SMTP id 41be03b00d2f7-cd65a511e43so73732a12.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131453; x=1792736253; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ICQyIKowVj3RyrjMn4gMzYuhROzG3qohL1WARXEfQY=;
        b=TGg/1iiwz6O4Zix/0UXhNig29Yfefl+J0q1Mz2KPkZOYD5OWNE6XHQapjJyGZLDX3U
         F50Ddirkxzk6MH9idpoClz3i+Qrc10O8PXG3sECOl4J48m31oQuaT+YfCfAv67a396WF
         1Z2CMbYNTukoqH5fbReRjAoBSfuR+ddTq94bPoi7iy12AGBWRVZsYOaM/u+sZxASichn
         PRosWdk/WvHp2T1IurmPwFA3FFGqYdRKgZ/SFQD9ftiAwVGr3aQ5fKoeTSDUFY656QSb
         rlHXviO7y4xDxEeJCkSmOSLGBSemxs34TSJ7vJIy6FXodVl8L2SkrtBp1TWXdXEE36c8
         ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131453; x=1792736253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ICQyIKowVj3RyrjMn4gMzYuhROzG3qohL1WARXEfQY=;
        b=STb4egqIlRy5w3TqqXs9nN7j45mxs5nd1ae1NZJW6Di0HIjyDMZmHkRdNWmpHiFQ6J
         wXAyxaS2eo9f2Q57HScSM2anv/BBHLroF8lnKqDgNMSfEX7uykXa56d659rO5ikUSq/v
         HLXodGke3BOU2O04dDwIGbVaz6N3p41O2tXaSgccC38D7nzOQJHyCdyxCXcCAKR4Q3Ux
         ybPSAj+miRTV0lWiCNxW0CXrM4LZxpmcgWXw/OMkv80bevXBG08WLSbEZwBRJ2LVHo8W
         /2sl4quDz7hVA0QW3MwEXyamd5GmkWnfplVyhB0RY0tReDvwBIkBeD9gP3/bVu39o989
         X8yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwB4E9ZtlBZUi07z60reRkAPq0X8H4VUuXlI8fs4UAxQdEUCW+e6V/q9kvp2S+rjqtyFgBsVg==@lists.infradead.org
X-Gm-Message-State: AFq9FYICPomDNgPGxjZoRhbUUSRCieOCXhV9BvRrRwVeq8rpaYI975qL
	n+pwHBivUe6ZQRhjSooz6pTNPeTizdt2rXUjO9XSCWIvBqjrfDUmApgD
X-Gm-Gg: AYBFou0Z7CMOhdmvmM7r9bugseqphOQKs/FdKWXYxaxpcN0K52hLmspO4Dbhf4kow/a
	AM0yis6ng2nFNm2lWw3VRNbTFAyKLq4OJYSBGiyr1r/VcswyixFptjHQYsoiphyjwb79jDO9/uN
	lalRlzwWW7rBpYiBMF99efIAryUM6yapAxmNpPokYWhYOAzyOq32P+gBZz4WTcEybc7HIhBPjf2
	yxpkHDRuI3rEfnMRxMagWXhxA9mtyC6zPxqkYbtNscSwf0T/zeGf1/43/Fnweu0k4rtA42mZwHW
	0iS8URu9e5wtyZKs11oxdFKU+qKiJalWCdO6VW2D29a39KsYvELO3qGFR/sqBJR+akITInLUyuZ
	veofuXmQfkTSAJEddk+yiAWeMPd3bEo7Wd/3SWEWmWfrmZDCNlVdzmL4x4zG+57W/o8wG9Tp1o2
	cltoxngoActtPKEv7Ukbxe9xtbZdITdGNFrBfStPWeOegrTyrkc+/Q99DqlkTi69lePfCyrH2Gu
	iMmY918xEM=
X-Received: by 2002:a05:6a00:1941:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-89d7f51698fmr8778955b3a.32.1792131453020;
        Thu, 15 Oct 2026 23:17:33 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:17:32 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [RESEND PATCH v8 7/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Fri, 16 Oct 2026 14:15:48 +0800
Message-ID: <20261016061549.4181390-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_071735_578298_E6D0CF27 
X-CRM114-Status: GOOD (  13.82  )
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

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ecc923102622..a5f223a74b7e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
 
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
+	fdt_mark_reserve_mem_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..505735732c13 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..f29a07e8fb23 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+		if (rmem->size && !rmem->dumpable)
+			memblock_mark_nodump(rmem->base, rmem->size);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0


