Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A90C54E5D
	for <kexec@archiver.kernel.org>; Mon, 18 Mar 2024 07:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=at52R3+zGFUVXagp7BvDbMaVrrWx3zH+LZzbwzNKyl4=; b=k4uROSxDqw9G4m
	SQfJHGMgpP7WCcKAYVwoj1IfYhNzcOx9VnVMaTBN482JSpGVmj7vSfcZUJEKnjGJ4eptO0Z7+17Bc
	2MccFM4KtG21LhGNz7iz6UvGqRxZhdwwHynn2P4WjWve1F09iuBaGe4xy4ujh2ykZWmE32GRSxI3q
	GvLAWGxVwQPhjKQxiKmwkkVnpilBO9/bx9ATrDzjdAYGcbCMkJJwXw6aK96MkzFQl/XYqOqMFDJet
	++T4+ybQaOs+ARve5L2X/6ADTyxmIcManU3H4pyR0FDI1e8umlwb2LvbFu5JXp73QPxojuXZ8jmQj
	EU+Syb+WNO56/XfLY2AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm71F-00000007Xli-09xH;
	Mon, 18 Mar 2024 07:02:49 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2418::600] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm71B-00000007Xio-3nkG
	for kexec@lists.infradead.org;
	Mon, 18 Mar 2024 07:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRybgNIAECvQCQsJvb0kNof2YAtHEIfUZY2WVxo3g0T2FhqAyKv49M+PyY83pyEi3s3S/KLOtgtp5v4oA+hFhSrqyPRSNqib+MryJBU8t52CuCUqgvd4AAoZq8m2aOsXaoaxipIELJVA26ANw21rrOQL97bQDYi/BqCXZLT1fbtnskOrDL041Af7OLOBFrcCxNcRKbORZMbGtsm3g8dgSmGlHjFdE1YiHJZmeI2LMT1LgT44Qx8FD8x3ntjw5XhAdv6XmCXGFOWwtBdXEvvwJ8Mijb7c2fjSEOCwYR3ff/KyiwtZrICIWoK2ktFalx7914yWx5rW9Pic2NEQcdjCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+85XbWfJbKBP7XmrEj0lBQMTOoQQ8dWyQJCfkoFmycU=;
 b=Co3duslKSmZ8H28+kO1y/xrnWYBE30xpogVY+prthu4nD0gU8ai3VGmobHj8tW5UITvZutI48hyLFX54XJVmIUnNUihzrVmhysPaGe+ruN8vlIQBwo9Ownk8BruizH+Pw8Q2QbW308LJpgHLRpZupg9V2+JvdfUP4Yd8U19PkxInb4C5/tmPAEypnNOtNRGWGU7+3VZGgjGgYon5IzoJTKQng5S2LXw6nuUUzgbrzjd/MTF/xLsY6X/W5TX/N1GoQw1Zz3ifjqvReyKmxqP0iF3QBEnUh1nU4lFLDBwGTlNwO73A745s9P1BGerqoY/AHStPQXE20Cv7lnkBEj1g6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+85XbWfJbKBP7XmrEj0lBQMTOoQQ8dWyQJCfkoFmycU=;
 b=TeTpBphJ2thxECkMskSvyydmlxoDvzDPeRbqldLRGO5cmKEWhADuO+DbvrgEyQRbM/+YY0sVEOnhIRAvG03hd+T6nW+Iap2HU/WrWu8RtqB5GNnfhKgexVByHQx6JWjPe4YxsZYiYRH5ap0f0tfEsxo3kRz79gghEwNBMLfGgsc=
Received: from DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) by
 LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:02:41 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::95) by DM5PR07CA0084.outlook.office365.com
 (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 07:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:02:40 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:02:39 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <elena.reshetova@intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <seanjc@google.com>, <michael.roth@amd.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <bdas@redhat.com>, <vkuznets@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>
Subject: [PATCH v2 1/3] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 18 Mar 2024 07:02:29 +0000
Message-ID: <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710744412.git.ashish.kalra@amd.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com> <cover.1710744412.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: e661cc3a-c515-4312-c3ec-08dc471966f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCxkxCK6aw0/UClItug+3omadoMxcMpIeIOW22EhwhK5JjEjTL3yBO271vzvWZh1JhKZ/mRtHL8yRHL863hbj0VVmSsbSKVUVfd2/CU206UUq69C7KrCKaa16rW1d5/NZoOy2Jwbc8HYlfu9RvGl+cDqicuKkutMNY9ZrHYiIzXgpla1yDcL4WqP/aRWVOKZYsKlrKG/nOt89SzHLd9CGYBKK5z+f3A65ESg6lzKR6FvsEOY6085UGiYaZXku3ENvoqqT3Xsa0JmafDmFaJS8z0lFFznv1psCw8pXDbu85WYeSgcSrz6mAJzqAy1ix/GsW0cgUjKJ3cmNkYFpCEh9frsMfmtjo6B53yFQCrZ1Udyj8G4pNMqVRoeG0wSYWu6FdheWcCzI3RA6M4vk4mCgJ/LFGisnNSmdpFTsp4mmSS9j2qkAWon4M4nQMcru18d0wELzDHZilqTsL79afamizMpF6mb6g+nqWohVRmUWZvSkArXCypctljoaq/J4vUD5/kBWZFrhA/M+wWYTQuIDzU4LsLT8T/qWu16rLFOBJ3Gf6G9acylr8IBaBXW0CkmgjEz9iKgQSDp7xhNYEP9wjMsY/KB1Ksu1Nr7NRfYyCyMjJbpiCR9n3c7oeGbHZJcmwSHnyBsqArQBwP1S0oiEuuZdtNtFel1Yh+Pg3bDLO3r7dbP2oLdMzKqqHFGth7gkef8nidCiaKdzlqED1PVfWUtLwHPLeOLuTZs9obahkGRkb4uv/rnmeiPtAtEB22l
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:02:40.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e661cc3a-c515-4312-c3ec-08dc471966f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_000245_973721_CE18BD37 
X-CRM114-Status: GOOD (  11.65  )
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

From: Ashish Kalra <ashish.kalra@amd.com>

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memboot & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..d4562d074371 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
+	/*
+	 * For kexec use case, we need to use the EFI memmap passed from the first
+	 * kernel via setup data, so we need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memboot & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+	if (efi_setup)
+		return;
+
 	if (efi_mem_desc_lookup(addr, &md) ||
 	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
