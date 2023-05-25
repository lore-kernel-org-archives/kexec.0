Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24100C7EE2C
	for <kexec@archiver.kernel.org>; Thu, 25 May 2023 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GwigmQMhdJICWmKpQ95iwrUKRTc435VHd7OVSCGz/IY=; b=Xs3/M2P1lV/X7i
	G198wqH7ET+5HyYeX0B+8DpJQjPVecNPnNqAZ6hPR3I+qY+maa7y94hUpcnmgdtFNWZteIpmKAYEq
	MZgxJlko9o2Hy2cGpaCOLd/dYV9heDLO15Cn7VSbEK2c/X4TVljdxg8nNLre4hKY9vVPdOwjkLxA4
	w4EutBhhsank4aYNUhkbPxUMjoDLfUoii8kKYAUWZ78sfwVwpn6sAxdzakW/2cILrnHoIPxS7LaKk
	VUvbx/wenDfnwwWEDcf+lWSjYorrpnw+dZd7rZmhKXoSM/EFvXY+23UBDl7Df77pYF3lO1JcyOHVy
	+VQtzJ8VhXl6cKQ0jyQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q27cx-00GC0S-3A;
	Thu, 25 May 2023 09:51:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q27cv-00GBzZ-0d
	for kexec@lists.infradead.org;
	Thu, 25 May 2023 09:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685008279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hAxjra5W1+1SvpBMN22QXJJOi5JB+teXZgPwJvUgVGE=;
	b=Q9t3HPe1XmP+KVL3Bl5lCvG9jgwbLTKUjKCb338xO4W6xB5LJljgQzyBVtv1QDIcMY5FGf
	ukoiPTLi0esXqkTznqc6HrwWC8u3k5ohtE76mL+8bKJu3QKht0/e+SUAw4lpq9/KajXpa2
	aWM7faeCXLAeiYOA9w7xuq1j11AhXXQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-hjbXOWmvONixtdrXen6znQ-1; Thu, 25 May 2023 05:49:38 -0400
X-MC-Unique: hjbXOWmvONixtdrXen6znQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5308f5d8ac9so912270a12.0
        for <kexec@lists.infradead.org>; Thu, 25 May 2023 02:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008177; x=1687600177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAxjra5W1+1SvpBMN22QXJJOi5JB+teXZgPwJvUgVGE=;
        b=RjS3ADTPu4TcL1w6RxYXNMQjSRQrLHj9Ydb5Uq2Mihe6+ktUbosRAyDH8SGpCHTHZb
         MJQOqAZd37QAmoA2btZZ1sT1FuksZF4f5eonycHLUXVYu5gxLtvwyos1k2jTS6c5Ci3R
         j8hMtLuV6RgVPz5zvc43m2SMr5kTIfdViw/EqIT/LbqnxutdOUcp7zCYyah1lL8ylNkw
         +LNx69K1KO57SYEyqtqhBPy+phVims3QIOqkNDyU7YtYks0UiP3XSfqyiBMkoBtJV8dy
         IVhAWSmpQTW9Ct0oo88ZtZTUVctWn60a4oU/HcEbFRIv66uV4Quv/0qXg3nbhxugDo+v
         CImw==
X-Gm-Message-State: AC+VfDxOwrmBCWps4NEnxnGxLg6aGkZuGKYWNhhU3xK51NXEfibvfrvY
	t3b/3KwnDF0yshLuxafgwdFOuns4haNiDtZ88KJUkHpGFj4s+srmqZA6KpEEs/kr5qMFbt0MRlh
	NhG0dKF74XjzEmDwiwJkp
X-Received: by 2002:a17:903:230f:b0:1af:a03:8d82 with SMTP id d15-20020a170903230f00b001af0a038d82mr1149861plh.57.1685008177419;
        Thu, 25 May 2023 02:49:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64F7+wAhODeQTh71SkG9KiZ+8BDhumZp7KJkEik3KY4RGXnQjHL9XswjQ5pC+GeNWlMRi+Sg==
X-Received: by 2002:a17:903:230f:b0:1af:a03:8d82 with SMTP id d15-20020a170903230f00b001af0a038d82mr1149833plh.57.1685008177110;
        Thu, 25 May 2023 02:49:37 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001ab2b4105ddsm1008282plh.60.2023.05.25.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:49:36 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Thu, 25 May 2023 17:49:14 +0800
Message-Id: <20230525094914.23420-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_025121_325562_EFBC3D6F 
X-CRM114-Status: GOOD (  17.85  )
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

In this patch, we will make sure the EFI config table is always mapped.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..755aa12f583f 100644
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
+map_efi_sys_cfg_tab(struct x86_mapping_info *info, pgd_t *level4p)
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
+	result = map_efi_sys_cfg_tab(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.33.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
