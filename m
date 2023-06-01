Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C83C77B7E
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PH2ROJ4TRM8ecC0+O+lZzXCZrn3UFtHzYzhxRrlmtgM=; b=zunbq8HIiz81sh
	nBg7vvOefy/Mb6kVEQhDsaxzYym3BLVqKvF0FzU7WQrN7l4UwY51VJkKTyC4DVTyUfeMren4eoeSq
	Z5EIaX+oHZ/LsCLg98L+rgOVQ2H89Xl0e2A0pRD8Z6QE2ezfAXZRVWJ8YCikJB0ErQg3f0b+UcvD/
	RJDFXUK1XIGNcEAGQui7BxnSHBsr/yfojRCIzSWQNUvLGSVe6tcIsJYkG+MmQ4ljVb83oBQAu+dX2
	M4gI28m1OYBsu2yM/efPazd6GH3AyU4P38xKxLDQ8dOWZiYPGAraXd/nzCTkS8B3m90YgdeVaOCt6
	IW2Oaa40FLB6BF4BRnlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dAD-002RaZ-13;
	Thu, 01 Jun 2023 07:56:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dA9-002RZQ-1G
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685606159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v0btJxCCZe43YDGHsdR9uwY7u4rDiYwVgo7mtVALHgE=;
	b=WGU0h5HZ6wb5lSUPrCfgvvqG+NcV67QMJDO2skNn4FX/4CWhfY6eO8AajBXX25mQiAwo5A
	i1euus/AnZqUq5dzSsIxcREy4ZXWSpLnKxEj6NF3sG1UXBWK/jjQFcSTMJF55v58pLhzp8
	Qt9eN3hX2cG31PcEB1ypLjbPIJuVaLo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-TWKpT5veO6O69hiOJZnPwg-1; Thu, 01 Jun 2023 03:55:58 -0400
X-MC-Unique: TWKpT5veO6O69hiOJZnPwg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-64d2f088dc2so672905b3a.3
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685606157; x=1688198157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0btJxCCZe43YDGHsdR9uwY7u4rDiYwVgo7mtVALHgE=;
        b=WbDUjhjK/teRU1F8+PPkxK4nSbyclwD2vmrkkm3PMb5vBgpKX0EhfOgxo1frSVjO4V
         XIBtUjd3K8xYumCoOeB1A1Qzq4qVVGx1/fTKPqzBVoC6bAtFMIXq/30N87/ahDui8syu
         5LT5y/HbR+vrkcM+wiNpnNFuymxzd3EwILCyIzlQsaXM0K6jVxkyTMFPmbSZ7C6WuCBH
         vGW+LBKUa3/T65fTt//lPpGyjfolGlVRC2g1bivUpVAJknNQiRtR6prwETLQMy8zCdpy
         D4jd8QJh/jenwKQ1Eq0QtukD31+eRWCsDwYJ4QeMfcWGozcCXYNUA6ycIkjDCTfjdSsN
         BWtg==
X-Gm-Message-State: AC+VfDwQUtRG/Kkv025vb+6eeWI0WDR183nQs/5waLq9z0Z37zKkRyXl
	AdB/7DkHIyLMdi1GigbDe9akszl4se3zW2rq2v2rFQWhmUBXX15rWXstW1gR99JF+wyR3W/AQr4
	HqbtensKCdPLUZj1LD6tQ
X-Received: by 2002:a05:6a00:3910:b0:64f:7c9d:9c09 with SMTP id fh16-20020a056a00391000b0064f7c9d9c09mr11549198pfb.32.1685606157381;
        Thu, 01 Jun 2023 00:55:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AFiGmMIL5yucVf1xXEUVV0IZpvnTGUsiZsNXeIglwrAEjmuisCODxuG3g3iCemJzBVxOWkw==
X-Received: by 2002:a05:6a00:3910:b0:64f:7c9d:9c09 with SMTP id fh16-20020a056a00391000b0064f7c9d9c09mr11549178pfb.32.1685606157062;
        Thu, 01 Jun 2023 00:55:57 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00643355ff6a6sm4600773pfo.99.2023.06.01.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:55:56 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ardb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Thu,  1 Jun 2023 15:20:44 +0800
Message-Id: <20230601072043.24439-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_005601_523296_1DC3C732 
X-CRM114-Status: GOOD (  19.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
EFI config table.

Currently EFI system table is identity-mapped for the kexec kernel, but EFI
config table is not mapped explicitly:

    commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
                          tables to the ident map")

Later in the following 2 commits, EFI config table will be accessed when
enabling sev at kernel startup. This may result in a page fault due to EFI
config table's unmapped address. Since the page fault occurs at an early
stage, it is unrecoverable and kernel hangs.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

In addition, the issue doesn't appear on all systems, because the kexec
kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
EFI config table can end up to be mapped into due to 1 GB page size.
However if nogbpages is set, or cpu doesn't support pdpe1gb feature
(e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
due to 2 MB page size, thus a page fault hang is more likely to happen.

This patch will make sure the EFI config table is always mapped.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
Changes in v2:
- Rephrase the change log based on Baoquan's suggestion.
- Rename map_efi_sys_cfg_tab() to map_efi_tables().
- Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-ltao@redhat.com/
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..664aefa6e896 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #endif
 
 static int
-map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
+map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
@@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	}
 
 	/*
-	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
-	 * not covered by pfn_mapped.
+	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
+	 * since they are not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_tables(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.33.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
