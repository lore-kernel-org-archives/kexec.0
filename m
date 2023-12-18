Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ECDC46CD3
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 05:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kt5OohYAER3B97NqQrAchWTVkgsUSiKgqecHHiJiA0c=; b=3C2TFgMUdOepmH
	10fpZxVFN2HsxTI0Btuog0W0FoG6ofYlxC1IbqGcsxN3ajw1acwtyySdgUp47knXyHDz38PZVdYqU
	gX6f/JCTSlbBhbTXizXfBn5ukZsS74bsjO2mxIJjipExF/THl4QyMZnnqhaIXrdQ5sImXtu6tK/Lk
	OGy5CdXaB/foTPMXdhOoFSQ4SO9KjIBiws+pevgQj/FLcmtpImzPNeBFzY6trc8UXgQxn5dPXkSYB
	XVCOAWNMRqva/2dTgrYssrjty70y/FrfxkV54Gjvh8y+xz0t3hkP+odun4CLqWbyeWVEY70IlOQKX
	pqH2Q283OawrbiJzPVfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66Y-00974q-2i;
	Mon, 18 Dec 2023 05:23:50 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66W-00973V-1x
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 05:23:49 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso678675a12.3
        for <kexec@lists.infradead.org>; Sun, 17 Dec 2023 21:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877026; x=1703481826; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQnwILLACfSGYQkjloIf0lXx3GTHPwbPk0Xy5aE3Myw=;
        b=dfaCDzZF9i6WUfUoghXuwAOwZWL0u04Y0YqYraW/mZ82L3iCAIBYn0+pXJ1aFx/U05
         1mGczst8BigXTn2AqFy5nbPljSdWHvegMLBaDnamEvkGTLZj8Ry0emGr6pRd+PXE7UKN
         XoM/F9JUOqsqZKpelyVXsazNE1dusEc97TtusQoJa0E5IQvVo9dIGrwVkD8hBUNK/xxW
         GKy3cDY7dyCf8K0FBsQQ/o9qNaGKWujjQkJpZ0ljgLL8LstdCc+2IEHTUq3CmRVl5BWY
         TVdntNK1/4K4nxrjfR+eMHqft36q3NJLyp7mIOtwh/N0hbDWVFzhwxzQuuvMvumen1kj
         ouDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877026; x=1703481826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQnwILLACfSGYQkjloIf0lXx3GTHPwbPk0Xy5aE3Myw=;
        b=JhHq4XQE8SsLCUUgwIjagD2/Y8PnF/OSecVn5SQAyHITjLNqMEBYbXGq4xSTVNvCeT
         pUQpmcRq7zC37Y0mSNaAB+Qt1utfSC5JU/fgRaZrMHrR+gzXuiuMUf5/cfmJtIn+mxD+
         R4rzNmcSWiP0ki80EmWDjCGsV2egNRiLIh6TM54DvMVpM2fBM9TVwrFHVyO2JLs5EKKw
         juiySMcrgg3lP8sdZeE0or334y1i3JWNMhSl8nD6fzdmy4KCBm3jKZxHZ5Iypm2Cdv5F
         PrLR1/MTspoS+xJ23MHQfkeEE8GEIhHtehh/cG7gIVrahL505xnRFNOqI3gcDSNAVkbE
         LW3g==
X-Gm-Message-State: AOJu0Yx6YdSSxNghGOqSmBJiNtogvt3icDPDlQxneJn+t9LpTJGXbgHP
	8Z1LhSvGzquPYlT+WSnUbfqxFlOTGe1m
X-Google-Smtp-Source: AGHT+IFw5y65y0+JsjrN3MYStIkdT4JJeQW8vu+TO7+O+OqlJvfipHInYun5NcigxdUF3BjcEXQ8Rg==
X-Received: by 2002:a17:903:947:b0:1d3:be34:7869 with SMTP id ma7-20020a170903094700b001d3be347869mr201389plb.45.1702877026556;
        Sun, 17 Dec 2023 21:23:46 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3c0300c72sm582434plh.197.2023.12.17.21.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:23:46 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [RFC 3/3] of: fdt: Parse properties of reusing CMA in kdump
Date: Mon, 18 Dec 2023 13:23:25 +0800
Message-Id: <20231218052325.20982-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231218052325.20982-1-kernelfans@gmail.com>
References: <20231218052325.20982-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_212348_648698_A00D921A 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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

From: Pingfan Liu <piliu@redhat.com>

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
---
 drivers/of/fdt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..09673440f876 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -620,6 +620,19 @@ static void __init fdt_reserve_elfcorehdr(void)
 		elfcorehdr_size >> 10, elfcorehdr_addr);
 }
 
+static void __init fdt_reserve_kdump_cma(void)
+{
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!is_kdump_kernel())
+		return;
+	if (!kdump_cma_pfn || !kdump_cma_pg_cnt || !kdump_cma_pg_paddr)
+		return;
+	memblock_reserve(kdump_cma_pfn << PAGE_SHIFT, kdump_cma_pg_cnt << PAGE_SHIFT);
+	pr_info("Reserving %llu KiB of memory at 0x%llx for kdump cma\n",
+		kdump_cma_pg_cnt >> 10, kdump_cma_pfn << PAGE_SHIFT);
+}
 /**
  * early_init_fdt_scan_reserved_mem() - create reserved memory regions
  *
@@ -637,6 +650,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 
 	fdt_scan_reserved_mem();
 	fdt_reserve_elfcorehdr();
+	fdt_reserve_kdump_cma();
 
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
@@ -1150,6 +1164,34 @@ int __init early_init_dt_scan_memory(void)
 	return found_memory;
 }
 
+static void __init early_init_dt_check_kdump_cma(unsigned long node)
+{
+	const __be32 *prop;
+	int len;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+	if (!is_kdump_kernel())
+		return;
+	pr_debug("Looking for kdump cma property... ");
+
+	prop = of_get_flat_dt_prop(node, "kdump,cma_pfn", &len);
+	if (!prop)
+		return;
+	kdump_cma_pfn = *prop;
+
+	prop = of_get_flat_dt_prop(node, "kdump,cma_pg_cnt", &len);
+	if (!prop)
+		return;
+	kdump_cma_pg_cnt = *prop;
+
+	prop = of_get_flat_dt_prop(node, "kdump,cma_pg_paddr", &len);
+	if (!prop)
+		return;
+	kdump_cma_pg_paddr = *prop;
+
+}
+
 int __init early_init_dt_scan_chosen(char *cmdline)
 {
 	int l, node;
@@ -1168,6 +1210,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
+	early_init_dt_check_kdump_cma(node);
 
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
