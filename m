Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0361BCF34A0
	for <kexec@archiver.kernel.org>; Thu,  3 Oct 2024 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3eaRQfUC23wZjL8VoVmyZnmMA5O/ZsS4GDLzV0tyF+Y=; b=OBaA4Rx9WQ5Jyv
	SqK/4pZUqWgYSI53MQTffv+PVAurm0f3tYclJ3uiIMs366grh7bZ+h/koaBSpv6tamP7ABIV16UqV
	8rdEkq/kimpcPquDVb2r0AkJuUgi76DQjnw/LltzDUBqXORXvsSs1b8leWv3cQHCVG0Bo8hdOs107
	xFUZKXuiczQ0bP0tlbXbk/rcrKc9An7V299KFottltwtYZ5fJ0QCYOaos5sM1tbUVIvmSektgFLxT
	s7r56NBJdhcloWAu9DXFeLve7jeezdChiC49hobi6LRGzuYcMVATFZuWKA4XU3EgVaOuMH7TGpl6X
	7k/6Bf5rgm6qBOsPK+hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swKBn-00000008vWn-4Az7;
	Thu, 03 Oct 2024 11:40:12 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swKAR-00000008vKJ-1Wh5;
	Thu, 03 Oct 2024 11:38:52 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7a9ae8fc076so93389985a.2;
        Thu, 03 Oct 2024 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727955525; x=1728560325; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QH30CE01/KIA8vmhQ9aUPnrMhqjqonBdBshFm2UJvlQ=;
        b=hNglnOSuqoloL8PJNnE8fVzj44ffI8eD78spV40G0nOA3BJ81GddjNVYiBfcJ2A0on
         CWdsuJMlLALx0yC8Z+2CzJ4XvYqUZeTKzn/Jd7uiLGoQ/M3mMQIPISHRY2UM6IkgCr8+
         gWmYbbWpDTgGZLGgE4Rce7sfNJc1dBGwAl3yUWm02ByOmFURzkIY/quTkLeE4tVc8KsS
         jFg9SmIgC2a/Tf3ft1Zt50iIAC/u28ZFDFMt4EmKipl4ch/UN0f4YJE6hrK89Hd9Tife
         skz/tuknTIdoszGrp9gkBNjvPoz7MBgowX2xuAgqhocCCuvyir36G+wnjV6zEnbaKpfm
         CsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955525; x=1728560325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QH30CE01/KIA8vmhQ9aUPnrMhqjqonBdBshFm2UJvlQ=;
        b=AfXiXM4sH8foap+WC/F3rFEnNPWQODyJZU4xVx/rP6+9e/mzDRiNn6cNzmqCdUC0Z4
         YM6BL4ZHCo3rdaSyliKmIEDRH8dw4bjfpMUz9N747BRDmMb/MX8hgBFvUH9dfwR/eELR
         rL6xo3+1BpaePL78EhUACyTgDRHRw/KWWvG/JbSuPm4q0aU/qJWC1v4glOVBjg1CQ2TW
         5jos4bfVGuuOGAgGAUyhnCmFpxCod5OmNBGokfx/OS4BjMXAQNymAo5KP2K8+5jrC3Li
         emnDznSDGaYnleiTYkNbCUikQmaW763MrwCNp6pjnLqzB3e+qCuaOy6rtDOPo66al8ZW
         6G0w==
X-Forwarded-Encrypted: i=1; AJvYcCV6CV8UG5Y2/S0XYaBqr1eQnqht6dZ3wPesmnulT8hgNJmAao34FaOCBMDTYTLJYwh9X1dif1ge8qBQGVB2fsJ43Q==@lists.infradead.org, AJvYcCVWRwqKbUFMfNPeYuQc7N1GXvPOl6zkgn3b4YOwJ5aQOOsC3NUxk0Wv5aIZjVRVKXCNcCe1Hg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyELglyHskOT+w7uVufy+3bXhCJ1zToOJQoerRWEmO/K2+lC0wL
	prZtvTMfupEEmYB01TCCLQnReDQHCObjX5eXdQUxF9kkUxZa7aFl
X-Google-Smtp-Source: AGHT+IEsftUbErs0PEHHR3fZPjrpqAZaPwPf+30Hv6n3XFmFyIPXQLxmLuXNFR3P1/kV98FpLv5gzw==
X-Received: by 2002:a05:620a:1921:b0:7a9:bb10:e072 with SMTP id af79cd13be357-7ae626bda77mr996374285a.23.1727955525448;
        Thu, 03 Oct 2024 04:38:45 -0700 (PDT)
Received: from localhost (fwdproxy-ash-004.fbsv.net. [2a03:2880:20ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b39ca00sm43757985a.43.2024.10.03.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:38:44 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: mark.rutland@arm.com,
	will@kernel.org
Cc: leitao@debian.org,
	catalin.marinas@arm.com,
	robh@kernel.org,
	saravanak@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and use it at kexec
Date: Thu,  3 Oct 2024 12:38:40 +0100
Message-ID: <20241003113840.2972416-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_043847_425810_FE4C56F4 
X-CRM114-Status: GOOD (  15.44  )
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

 __pa() is only intended to be used for linear map addresses and using
it for initial_boot_params which is in fixmap for arm64 will give an
incorrect value. Hence stash the physical address when it is known at
boot time and use it at kexec time instead of converting the virtual
address using __pa().

Reported-by: Breno Leitao <leitao@debian.org>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
---
 arch/arm64/kernel/setup.c | 8 ++++++++
 drivers/of/fdt.c          | 6 ++++++
 drivers/of/kexec.c        | 8 ++++++--
 include/linux/of_fdt.h    | 2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b22d28ec8028..a4d96f5e2e05 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	/* Early fixups are done, map the FDT as read-only now */
 	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
 
+	/*
+	 * Save dt_phys address so that it can be used later for kexec. This
+	 * is done as __pa() is only intended to be used for linear map addresses
+	 * and using it for initial_boot_params which is in fixmap will give an
+	 * incorrect value.
+	 */
+	set_initial_boot_params_pa(dt_phys);
+
 	name = of_flat_dt_get_machine_name();
 	if (!name)
 		return;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4d528c10df3a..9e312b7c246e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -457,6 +457,7 @@ int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
 
 void *initial_boot_params __ro_after_init;
+phys_addr_t initial_boot_params_pa __ro_after_init;
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
@@ -1185,6 +1186,11 @@ bool __init early_init_dt_scan(void *params)
 	return true;
 }
 
+void __init set_initial_boot_params_pa(phys_addr_t params)
+{
+	initial_boot_params_pa = params;
+}
+
 static void *__init copy_device_tree(void *fdt)
 {
 	int size;
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 9ccde2fd77cb..ca9f27b27f71 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -300,8 +300,12 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		goto out;
 	}
 
-	/* Remove memory reservation for the current device tree. */
-	ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
+	/* Remove memory reservation for the current device tree.
+	 * For arm64, initial_boot_params is a fixmap address, hence __pa(),
+	 * can't be used to get the physical address.
+	 */
+	ret = fdt_find_and_del_mem_rsv(fdt, IS_ENABLED(CONFIG_ARM64) ?
+				       initial_boot_params_pa : __pa(initial_boot_params),
 				       fdt_totalsize(initial_boot_params));
 	if (ret == -EINVAL) {
 		pr_err("Error removing memory reservation.\n");
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..dbd99bf21ac8 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -31,6 +31,7 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 extern int __initdata dt_root_addr_cells;
 extern int __initdata dt_root_size_cells;
 extern void *initial_boot_params;
+extern phys_addr_t initial_boot_params_pa;
 
 extern char __dtb_start[];
 extern char __dtb_end[];
@@ -73,6 +74,7 @@ extern int early_init_dt_scan_root(void);
 extern bool early_init_dt_scan(void *params);
 extern bool early_init_dt_verify(void *params);
 extern void early_init_dt_scan_nodes(void);
+extern void set_initial_boot_params_pa(phys_addr_t params);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
-- 
2.43.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
